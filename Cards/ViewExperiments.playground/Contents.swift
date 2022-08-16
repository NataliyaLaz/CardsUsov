//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
       setupViews()
    }
    
    private func setupViews() {
        self.view = getRootView()
        let redView = getRedView()
        let greenView = getGreenView()
        let whiteView = getWhiteView()
        let pinkView = getPinkView()
        redView.transform = CGAffineTransform(rotationAngle: .pi/3)
        set(view: greenView, toCenterOfView: redView)
        whiteView.center = greenView.center
        self.view.addSubview(pinkView)
        self.view.addSubview(redView)
        redView.addSubview(greenView)
        redView.addSubview(whiteView)
    }
    
    private func getRootView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
    private func getRedView() -> UIView {
        let view = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }
    
    private func getGreenView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        view.backgroundColor = .green
        return view
    }
    
    private func getWhiteView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = .white
        return view
    }
    
    private func getPinkView() -> UIView {
        let view = UIView(frame: CGRect(x: 50, y: 300, width: 100, height: 100))
        view.backgroundColor = .systemPink
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.95
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 10, height: 20)
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.opacity = 0.7
        
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        layer.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        layer.cornerRadius = 10
        
        /*
        print(view.frame)
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        view.transform = CGAffineTransform(rotationAngle: .pi / 4)
        print(view.frame)
        
        view.transform = CGAffineTransform(scaleX: 1.5, y: 0.7)
        
        view.transform = CGAffineTransform(translationX: 100, y: 5)
        
        view.transform = CGAffineTransform(rotationAngle: .pi / 3).scaledBy(x: 2, y: 0.8).translatedBy(x: 50, y: 50)
        
        view.transform = CGAffineTransform.identity
         
         view.transform = CGAffineTransform(rotationAngle: .pi / 4).inverted()*/
        
        view.layer.addSublayer(layer)
        return view
    }
    
    private func set(view moveView:UIView, toCenterOfView baseView: UIView) {
        moveView.center = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
