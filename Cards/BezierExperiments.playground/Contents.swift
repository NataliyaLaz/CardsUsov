//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        createBezier(on: view)
    }
    
    private func createBezier(on view: UIView) {
        let shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        shapeLayer.lineWidth = 5
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.green.cgColor
        
        shapeLayer.lineCap = .butt
        
        shapeLayer.lineJoin = .round
        //shapeLayer.lineDashPattern = [10,3]
        
        //корректирует значние первого сегмента
       // shapeLayer.lineDashPhase = 5
        
       // shapeLayer.strokeStart = 0.4
       // shapeLayer.strokeEnd = 0.6
        
 
        shapeLayer.path = getShapePath().cgPath
        
    }
    
    private func getPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 150, y: 50))
        path.addLine(to: CGPoint(x: 150, y: 150))
        path.close()
        
        path.move(to: CGPoint(x: 50, y: 70))
        path.addLine(to: CGPoint(x: 150, y: 170))
        path.addLine(to: CGPoint(x: 50, y: 170))
        path.close()

        return path
    }
    
    private func getRectPath() -> UIBezierPath {
        let rect = CGRect(x: 10, y: 10, width: 200, height: 100)
        //let path = UIBezierPath(rect: rect)
       // let path = UIBezierPath(roundedRect: rect, cornerRadius: 30)
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 30, height: 0))
        return path
    }
    
    private func getArcPath() -> UIBezierPath {
        let centerPoint = CGPoint(x: 200, y: 200)
        
        let path = UIBezierPath(arcCenter: centerPoint,
                                radius: 150,
                                startAngle: .pi/5,
                                endAngle: .pi,
                                clockwise: true)
        return path
    }
    
    private func getOvalPath() -> UIBezierPath {
        let rect = CGRect(x: 50, y: 50, width: 200, height: 100)
        let path = UIBezierPath(ovalIn: rect)
        return path
    }
    
    private func getCurvePath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 10))
        path.addCurve(to: CGPoint(x: 200, y: 200),
                      controlPoint1: CGPoint(x: 300, y: 20),
                      controlPoint2: CGPoint(x: 20, y: 300))
        
        return path
    }
    
    private func getShapePath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 250))
        path.addLine(to: CGPoint(x: 100, y: 200))
        path.addLine(to: CGPoint(x: 70, y: 200))
        let firstCenter = CGPoint(x: 70, y: 150)
        path.addArc(withCenter: firstCenter,
                    radius: 50,
                    startAngle: .pi/2,
                    endAngle: .pi*3/2,
                    clockwise: true)
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 70))
        let secondCenter = CGPoint(x: 150, y: 70)
        path.addArc(withCenter: secondCenter,
                    radius: 50,
                    startAngle: .pi,
                    endAngle: 0,
                    clockwise: true)
        path.addLine(to: CGPoint(x: 200, y: 100))
        path.addLine(to: CGPoint(x: 230, y: 100))
        let thirdCenter = CGPoint(x: 230, y: 150)
        path.addArc(withCenter: thirdCenter,
                    radius: 50,
                    startAngle: .pi*3/2,
                    endAngle: .pi/2,
                    clockwise: true)
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 200, y: 250))
        path.close()

        return path
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
