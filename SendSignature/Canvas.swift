//
//  Canvas.swift
//
//  Created by Florentin Lupascu on 29/04/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit


/// A class which allow the user to draw inside a UIView which inherit this class.
class Canvas: UIView {

    /// Closure to run on changes to drawing state
    var isDrawingHandler: ((Bool) -> Void)?

    /// The image drawn onto the canvas
    var image: UIImage?

    /// Caches the path for a line between touch down and touch up.
    private var path = UIBezierPath()

    /// An array of points that will be smoothed before conversion to a Bezier path
    private var points = Array(repeating: CGPoint.zero, count: 5)

    /// Keeps track of the number of points cached before transforming into a bezier
    private var pointCounter = Int(0)

    /// The colour to use for drawing
    private var strokeColor = UIColor.black

    /// Width of drawn lines
    private var strokeWidth = CGFloat(1)

    override func awakeFromNib() {
        isMultipleTouchEnabled = false

        path.lineWidth = 1
        path.lineCapStyle = .round
    }

    // public function
    func clear() {
        image = nil
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        // Draw the cached image into the view and then draw the current path onto it
        // This means the entire path is not drawn every time, just the currently smoothed section.
        image?.draw(in: rect)

        strokeColor.setStroke()
        path.stroke()
    }

    private func cacheImage() {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        image = renderer.image(actions: { (context) in
            // Since we are not drawing a background color I've commented this out
            // I've left the code in case you want to use it in the future
//            if image == nil {
//                // Nothing cached yet, fill the background
//                let backgroundRect = UIBezierPath(rect: bounds)
//                backgroundColor?.setFill()
//                backgroundRect.fill()
//            }

            image?.draw(at: .zero)
            strokeColor.setStroke()
            path.stroke()
        })
    }

}

// UIResponder methods
extension Canvas {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first ?? UITouch()
        let point = touch.location(in: self)

        pointCounter = 0

        points[pointCounter] = point
        isDrawingHandler?(true)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first ?? UITouch()
        let point = touch.location(in: self)
        pointCounter += 1
        points[pointCounter] = point
        guard pointCounter == 4 else {
            // We need 5 points to convert to a smooth Bezier Curve
            return
        }

        // Smooth the curve
        points[3] = CGPoint(x: (points[2].x + points[4].x) / 2.0, y: (points[2].y + points [4].y) / 2.0)

        // Add a new bezier sub-path to the current path
        path.move(to: points[0])
        path.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2])

        // Replace the points for the new segment
        points[0] = points[3]
        points[1] = points[4]
        pointCounter = 1
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        cacheImage()
        setNeedsDisplay()
        path.removeAllPoints()
        pointCounter = 0
        isDrawingHandler?(false)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}
