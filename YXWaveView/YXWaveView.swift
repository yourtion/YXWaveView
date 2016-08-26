//
//  YXWaveView.swift
//  YXWaveView
//
//  Created by YourtionGuo on 8/26/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

import UIKit

public class YXWaveView: UIView {

    /// wave curvature (default: 1.5)
    public var waveCurvature: CGFloat = 1.5
    /// wave speed (default: 0.6)
    public var waveSpeed: CGFloat = 0.6
    /// wave height (default: 5)
    public var waveHeight: CGFloat = 5
    /// real wave color
    public var realWaveColor: UIColor = UIColor.redColor()
    /// mask wave color
    public var maskWaveColor: UIColor = UIColor.redColor()
    /// float over View
    public var overView: UIView?
    
    /// wave timmer
    private var timer: CADisplayLink?
    /// real aave
    private var realWaveLayer :CAShapeLayer = CAShapeLayer()
    /// mask wave
    private var maskWaveLayer :CAShapeLayer = CAShapeLayer()
    /// offset
    private var offset :CGFloat = 0
    
    /**
     Init view
     
     - parameter frame: view frame
     
     - returns: view
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var frame = self.bounds
        frame.origin.y = frame.size.height-self.waveHeight;
        frame.size.height = self.waveHeight;
        maskWaveLayer.frame = frame
        realWaveLayer.frame = frame
        self.backgroundColor = UIColor.clearColor()
    }
    
    /**
     Init view with wave color
     
     - parameter frame: view frame
     - parameter color: real wave color
     
     - returns: view
     */
    public convenience init(frame: CGRect, color:UIColor) {
        self.init(frame: frame)
        
        self.realWaveColor = color
        self.maskWaveColor = color.colorWithAlphaComponent(0.4)
        
        realWaveLayer.fillColor = self.realWaveColor.CGColor
        maskWaveLayer.fillColor = self.maskWaveColor.CGColor
        
        self.layer.addSublayer(self.realWaveLayer)
        self.layer.addSublayer(self.maskWaveLayer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Add over view
     
     - parameter view: overview
     */
    public func addOverView(view: UIView) {
        overView = view
        overView?.center = self.center
        self.addSubview(overView!)
    }
    
    /**
     Start wave
     */
    public func start() {
        stop();
        timer = CADisplayLink(target: self, selector: #selector(wave))
        timer?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    /**
     Stop wave
     */
    public func stop(){
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
    }
    
    /**
     Wave animation
     */
    func wave() {
        offset += waveSpeed;
        
        let width = CGRectGetWidth(frame)
        let height = waveHeight
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, height)
        var y: CGFloat = 0

        let maskpath = CGPathCreateMutable();
        CGPathMoveToPoint(maskpath, nil, 0, height)
        var maskY: CGFloat = 0
        
        for x in 0...Int(width) {
            y = CGFloat(height) * CGFloat(sinf(0.01 * Float(waveCurvature) * Float(x) + Float(offset) * 0.045))
            CGPathAddLineToPoint(path, nil, CGFloat(x), y)
            maskY = -y;
            CGPathAddLineToPoint(maskpath, nil, CGFloat(x), maskY)
        }
        
        if (overView != nil) {
            let centX = self.bounds.size.width/2
            let centY = CGFloat(height) * CGFloat(sinf(0.01 * Float(waveCurvature) * Float(centX)  + Float(offset) * 0.045))
            let center = CGPoint(x: centX , y: centY + self.bounds.size.height - overView!.bounds.size.height/2 - waveHeight - 1 )
            overView?.center = center;
        }
        
        CGPathAddLineToPoint(path, nil, width, height)
        CGPathAddLineToPoint(path, nil, 0, height)
        CGPathCloseSubpath(path)
        self.realWaveLayer.path = path
        self.realWaveLayer.fillColor = self.realWaveColor.CGColor
        
        CGPathAddLineToPoint(maskpath, nil, width, height)
        CGPathAddLineToPoint(maskpath, nil, 0, height)
        CGPathCloseSubpath(maskpath)
        self.maskWaveLayer.path = maskpath
        self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor
    }
    
    
}
