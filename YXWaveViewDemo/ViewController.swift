//
//  ViewController.swift
//  YXWaveViewDemo
//
//  Created by YourtionGuo on 8/26/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

import UIKit
import YXWaveView

class ViewController: UIViewController {
    
    private var waterView: YXWaveView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init Avatar OverView
        let avatarFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let avatarView = UIImageView(frame: avatarFrame)
        avatarView.layer.cornerRadius = CGRectGetHeight(avatarView.bounds)/2
        avatarView.layer.masksToBounds = true
        avatarView.layer.borderColor  = UIColor.whiteColor().CGColor
        avatarView.layer.borderWidth = 3
        avatarView.layer.contents = UIImage(named: "yourtion")?.CGImage
        
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 200)
        waterView = YXWaveView(frame: frame, color: UIColor.whiteColor())
        waterView!.addOverView(avatarView);
        waterView!.backgroundColor = UIColor(red: 248/255, green: 64/255, blue: 87/255, alpha: 1)
        
        // Add WaveView
        self.view.addSubview(waterView!)
        
        // Start wave
        waterView!.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

