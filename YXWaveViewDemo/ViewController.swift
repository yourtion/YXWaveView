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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.redColor()
        let waterView = YXWaveView(frame: self.view.bounds, color: UIColor.whiteColor(), y: 250)
        
        self.view.addSubview(waterView)
        waterView.start(20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

