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
    public var realWaveColor: UIColor = UIColor.redColor() {
        didSet {
            self.realWaveLayer.fillColor = self.realWaveColor.CGColor
        }
    }
    /// mask wave color
    public var maskWaveColor: UIColor = UIColor.redColor() {
        didSet {
            self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor
        }
    }
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
        overView?.frame.origin.y = self.frame.height - (overView?.frame.height)!
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
        let height = CGFloat(waveHeight)
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, height)
        var y: CGFloat = 0

        let maskpath = CGPathCreateMutable();
        CGPathMoveToPoint(maskpath, nil, 0, height)
        
        let offset_f = Float(offset * 0.045)
        let waveCurvature_f = Float(0.01 * waveCurvature)
        
        for x in 0...Int(width) {
            y = height * CGFloat(sinf( waveCurvature_f * Float(x) + offset_f))
            CGPathAddLineToPoint(path, nil, CGFloat(x), y)
            CGPathAddLineToPoint(maskpath, nil, CGFloat(x), -y)
        }
        
        if (overView != nil) {
            let centX = self.bounds.size.width/2
            let centY = height * CGFloat(sinf(waveCurvature_f * Float(centX)  + offset_f))
            let center = CGPoint(x: centX , y: centY + self.bounds.size.height - overView!.bounds.size.height/2 - waveHeight - 1 )
            overView?.center = center;
        }
        
        CGPathAddLineToPoint(path, nil, width, height)
        CGPathAddLineToPoint(path, nil, 0, height)
        CGPathCloseSubpath(path)
        self.realWaveLayer.path = path
        
        CGPathAddLineToPoint(maskpath, nil, width, height)
        CGPathAddLineToPoint(maskpath, nil, 0, height)
        CGPathCloseSubpath(maskpath)
        self.maskWaveLayer.path = maskpath
    }
    
    
}
