import Foundation


class Triangle: UIView {
    @IBOutlet weak var vwBase: UIView!
    lazy var arrPointsNeededForArrow = [(point : CGPoint, controlPoint : CGPoint)]()
    
    
    func addArrowInGivenDirection(direction: String) {
            let isArrowInverse = direction == "left" ? false : true
            let circleLayer = CAShapeLayer()
            for arrowInfo in arrPointsNeededForArrow {
                let path = UIBezierPath()
                path.addArrow(from: arrowInfo.point, controlPoint: arrowInfo.controlPoint, width: 5, height: 10, isOpen: false, isInverse: isArrowInverse)
                
                circleLayer.path = path.cgPath
                circleLayer.fillColor = direction == "left" ? UIColor.green.cgColor : UIColor.yellow.cgColor
                vwBase.layer.addSublayer(circleLayer)
            }
    }
    func populateArrayForArrow(_ dataPoints: [[CGPoint]]) {
        let bezierPath = UIBezierPath()
        for points in dataPoints {
            let config = BezierConfiguration()
            let controlPoints = config.configureControlPoints(data: points)
            for i in 0..<points.count {
                let point = points[i]
                if i == 0 {
                    bezierPath.move(to: point)
                } else {
                    let segment = controlPoints[i - 1]
                    bezierPath.addCurve(to: point, controlPoint1: segment.firstControlPoint, controlPoint2: segment.secondControlPoint)
                    if i == points.count - 1 {
                        let T: CGFloat = 0.3
                        let A = pointInLine(A: points[i-1], B: segment.firstControlPoint, T: T)
                        let B = pointInLine(A: segment.firstControlPoint, B: segment.secondControlPoint, T: T)
                        let C = pointInLine(A: segment.secondControlPoint, B: point, T: T)
                        let D = pointInLine(A: A, B: B, T: T)
                        let E = pointInLine(A: B, B: C, T: T)
                        let F = pointInLine(A: D, B: E, T: T)
                        arrPointsNeededForConceptArrow.append((point: F, controlPoint: segment.secondControlPoint))
                    }
                }
            }
        }
    }
        
    func helperForArrowArrayPopulation(startPoint: CGPoint, endPoint: CGPoint, x: Int) {
        let start = startPoint
        let last = endPoint
        var dataPoints = [[CGPoint]]()
        let xPoint = Int(start.x) > Int(last.x) ? Int(start.x) - Int(abs((last.x - start.x)/x)) : Int(start.x) + Int(abs((last.x - start.x)/x))
        let yPoint = Int(start.y) > Int(last.y) ? Int(start.y) - Int(abs((last.y - start.y)/x)) : Int(start.y) + Int(abs((last.y - start.y)/x))
        var data: [CGPoint] = []
        data.append(start)
        data.append(CGPoint(x: xPoint, y: yPoint))
        data.append(last)
        dataPoints.append(data)
        arrPointsNeededForArrow.removeAll()
        populateArrayForArrow(dataPoints)
    }

}
