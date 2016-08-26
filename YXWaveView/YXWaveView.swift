//
//  YXWaveView.swift
//  YXWaveView
//
//  Created by YourtionGuo on 8/26/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

import UIKit

public class YXWaveView: UIView {
    
    private var currentWaterColor: UIColor = UIColor.redColor()
    private var currentLinePointY: CGFloat
    private var a: CGFloat
    private var b: CGFloat
    private var jia: Bool
    
    override public init(frame: CGRect) {
        a = 1.5;
        b = 0;
        jia = false;
        currentWaterColor = UIColor.redColor() //[UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
        currentLinePointY = 250
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector:#selector(animateWave), userInfo: nil, repeats: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        var y = currentLinePointY;
        CGPathMoveToPoint(path, nil, 0, y);
        let width = Int(self.frame.size.width)
        for x in 0...width {
            y = a * sin( CGFloat(x)/180*CGFloat(M_PI) + 4*b/CGFloat(M_PI) ) * 5 + currentLinePointY;
            CGPathAddLineToPoint(path, nil, CGFloat(x), y);
        }
        
        CGPathAddLineToPoint(path, nil, 320, rect.size.height);
        CGPathAddLineToPoint(path, nil, 0, rect.size.height);
        CGPathAddLineToPoint(path, nil, 0, currentLinePointY);
        
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        CGContextDrawPath(context, .Stroke);
    }
    
}
