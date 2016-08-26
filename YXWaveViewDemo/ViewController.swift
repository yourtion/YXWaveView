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
        let waterView = YXWaveView(frame: self.view.bounds)
        
        self.view.addSubview(waterView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

