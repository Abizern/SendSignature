//
//  Canvas.swift
//
//  Created by Florentin Lupascu on 29/04/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit


/// A class which allow the user to draw inside a UIView which inherit this class.
class Canvas: UIView {

    private struct Line {
        var points: [CGPoint]
    }
    
    private var strokeColor = UIColor.black.cgColor
    private var strokeWidth = CGFloat(1)

    // public function
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    private var lines = [Line]() {
        didSet {
            guard !lines.isEmpty else { return }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(strokeColor)
        context.setLineWidth(strokeWidth)
        context.setLineCap(.round)

        lines.forEach { (line) in
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }

    /// Returns the image drawn into the canvas
    var image: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}
