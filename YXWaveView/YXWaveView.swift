//
//  YXWaveView.swift
//  YXWaveView
//
//  Created by YourtionGuo on 8/26/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

import UIKit

public class YXWaveView: UIView {
    
    public var currentWaterColor: UIColor = UIColor.redColor()
    public var LineY : CGFloat = 100
    public var speed : Double = 50
    private var a: CGFloat = 1.5
    private var b: CGFloat = 0
    private var jia: Bool = false
    private var timer: NSTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    public convenience init(frame: CGRect, color:UIColor, y: CGFloat) {
        self.init(frame: frame)
        
        currentWaterColor = color
        LineY = y
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func start(speed: Double) {
        stop();
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0/speed, target: self, selector:#selector(animateWave), userInfo: nil, repeats: true)
    }
    
    public func stop(){
        if (timer != nil) {
            timer!.invalidate()
            timer = nil
        }
    }
    
    func animateWave() {
        if (jia) {
            a += 0.01
        } else {
            a -= 0.01
        }
        
        if (a <= 1) {
            jia = true
        } else if (a >= 1.5) {
            jia = false
        }
        
        b+=0.1;
        
        self.setNeedsDisplay()
    }
    
    override public func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let path = CGPathCreateMutable()
        
        //画水
        CGContextSetLineWidth(context, 1);
        CGContextSetFillColorWithColor(context, currentWaterColor.CGColor);
        
        var y = LineY;
        CGPathMoveToPoint(path, nil, 0, y);
        let width = Int(self.frame.size.width)
        for x in 0...width {
            y = a * sin( CGFloat(x)/180*CGFloat(M_PI) + 4*b/CGFloat(M_PI) ) * 5 + LineY
            CGPathAddLineToPoint(path, nil, CGFloat(x), y)
        }
        
        CGPathAddLineToPoint(path, nil, CGFloat(width), rect.size.height)
        CGPathAddLineToPoint(path, nil, 0, rect.size.height)
        CGPathAddLineToPoint(path, nil, 0, LineY)
        
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        CGContextDrawPath(context, .Stroke);
    }
    
}
