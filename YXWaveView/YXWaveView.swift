//
//  YXWaveView.swift
//  YXWaveView
//
//  Created by YourtionGuo on 8/26/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

import UIKit

public class YXWaveView: UIView {

    public var waveCurvature: CGFloat = 1.5 // 浪弯曲度
    public var waveSpeed: CGFloat = 0.5 // 浪速
    public var waveHeight: CGFloat = 4 // 浪高
    public var realWaveColor: UIColor = UIColor.redColor() // 实浪颜色
    public var maskWaveColor: UIColor = UIColor.redColor() // 遮罩浪颜色
    
    public var overView: UIView?
    
    private var timer: CADisplayLink?
    private var realWaveLayer :CAShapeLayer = CAShapeLayer()
    private var maskWaveLayer :CAShapeLayer = CAShapeLayer()
    private var offset :CGFloat = 0

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var frame = self.bounds
        frame.origin.y = frame.size.height-self.waveHeight;
        frame.size.height = self.waveHeight;
        maskWaveLayer.frame = frame
        realWaveLayer.frame = frame
        self.backgroundColor = UIColor.orangeColor()
    }
    
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
    
    public func addOverView(view: UIView) {
        overView = view
        overView?.center = self.center
        self.addSubview(overView!)
    }
    
    public func start(speed: Double) {
        stop();
        timer = CADisplayLink(target: self, selector: #selector(wave))
        timer?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    public func stop(){
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func wave() {
        offset += waveSpeed;
        
        let width = CGRectGetWidth(frame)
        let height = waveHeight
        
        //真实浪
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, height)
        var y: CGFloat = 0
        //遮罩浪
        let maskpath = CGPathCreateMutable();
        CGPathMoveToPoint(maskpath, nil, 0, height)
        var maskY: CGFloat = 0
        
        for x in 0...Int(width) {
            y = CGFloat(height) * CGFloat(sinf(0.01 * Float(waveCurvature) * Float(x) + Float(offset) * 0.045))
            CGPathAddLineToPoint(path, nil, CGFloat(x), y)
            maskY = -y;
            CGPathAddLineToPoint(maskpath, nil, CGFloat(x), maskY)
        }
        
        //变化的中间Y值
        let centX = self.bounds.size.width/2
        let CentY = CGFloat(height) * CGFloat(sinf(0.01 * Float(waveCurvature) * Float(centX)  + Float(offset) * 0.045))
        if (overView != nil) {
            let center = CGPoint(x: centX , y: CentY + overView!.bounds.size.height - waveHeight )
            overView?.center = center;
        }
        
        CGPathAddLineToPoint(path, nil, width, height);
        CGPathAddLineToPoint(path, nil, 0, height);
        CGPathCloseSubpath(path);
        self.realWaveLayer.path = path;
        self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
        
        CGPathAddLineToPoint(maskpath, nil, width, height);
        CGPathAddLineToPoint(maskpath, nil, 0, height);
        CGPathCloseSubpath(maskpath);
        self.maskWaveLayer.path = maskpath;
        self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    }
    
    
}
