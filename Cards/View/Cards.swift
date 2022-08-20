//
//  Cards.swift
//  Cards
//
//  Created by Nataliya Lazouskaya on 19.08.22.
//

import UIKit

protocol FlippableView: UIView {
    
    var isFlipped: Bool { get set }
    var flipCompletionHandler: ((FlippableView) -> Void)? { get set }
    func flip()
}

class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    
    var color: UIColor!
    
    var isFlipped: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var flipCompletionHandler: ((FlippableView) -> Void)?
    
    private let margin = 10
    let cornerRadius = 20
    
    lazy var frontSideView = getFrontSideView()
    lazy var backSideView = getBackSideView()
    
    private var anchorPoint = CGPoint(x: 0, y: 0)
    
    private var startTouchPoint: CGPoint!
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        
        setupBorders()
    }
    
    override func draw(_ rect: CGRect) {
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        
        if isFlipped{
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        let shapeView = UIView(frame: CGRect(x: margin, y: margin, width: Int(self.bounds.width) - margin*2, height: Int(self.bounds.height) - margin*2))
        view.addSubview(shapeView)
        let shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds
        return view
    }
    
    private func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        switch ["circle", "line"].randomElement()! {
        case "circle":
            view.layer.addSublayer(BackSideCircle(size: self.bounds.size, fillColor: UIColor.black.cgColor))
            
        case "line":
            view.layer.addSublayer(BackSideLine(size: self.bounds.size, fillColor: UIColor.black.cgColor))
        default:
            break
        }
        
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds = true
        return view
    }
    
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        anchorPoint.x = touches.first!.location(in: window).x - frame.minX
        anchorPoint.y = touches.first!.location(in: window).y - frame.minY
        
        startTouchPoint = frame.origin
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.frame.origin.x = touches.first!.location(in: window).x - anchorPoint.x
        self.frame.origin.y = touches.first!.location(in: window).y - anchorPoint.y
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
         UIView.animate(withDuration: 0.5, animations: {
         self.frame.origin = self.startTouchPoint
         
         if self.transform.isIdentity {
         self.transform = CGAffineTransform(rotationAngle: .pi)
         } else {
         self.transform = .identity
         }
         }, completion: nil)*/
        if self.frame.origin == startTouchPoint {
            flip()
        }
        
        let window = UIApplication.shared.windows[0]
        
        let lowerBorder = UIScreen.main.bounds.height - window.safeAreaInsets.bottom - self.frame.height  - window.safeAreaInsets.top - CGFloat(margin) * 2 - CGFloat(50)
        let rightBorder = UIScreen.main.bounds.width - window.safeAreaInsets.right - self.frame.width - window.safeAreaInsets.left - CGFloat(margin) * 2
        
        if (touches.first!.location(in: window).x - anchorPoint.x) > rightBorder {
            self.frame.origin.x = rightBorder
        } else if self.frame.origin.x < CGFloat(0) {
            self.frame.origin.x = 0
        } else {
            self.frame.origin.x = touches.first!.location(in: window).x - anchorPoint.x
        }
        
        if self.frame.origin.y < CGFloat(0) {
            self.frame.origin.y = 0
        } else if (touches.first!.location(in: window).y - anchorPoint.y) > lowerBorder {
            self.frame.origin.y = lowerBorder
        } else {
            self.frame.origin.y = touches.first!.location(in: window).y - anchorPoint.y
        }
    }
    
    func flip(){
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromTop]) { _ in
            self.flipCompletionHandler?(self)
        }
        isFlipped.toggle()
    }
}
