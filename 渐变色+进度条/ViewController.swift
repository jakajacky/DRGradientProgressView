//
//  ViewController.swift
//  渐变色+进度条
//
//  Created by xqzh on 16/9/12.
//  Copyright © 2016年 xqzh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var progView:DRGradientProgressView!
  var i:CGFloat!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 创建光谱 进度条
    progView = DRGradientProgressView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 2))
    progView.progress = 0.0
    self.view.addSubview(progView)
    
    
    // 模拟进度
    i = 0.0
    let timer = Timer(timeInterval: 0.1, target: self, selector: #selector(move), userInfo: nil, repeats: true)
    let runloop = RunLoop.main
    runloop.add(timer, forMode: RunLoopMode(rawValue: "NSDefaultRunLoopMode"))
    
    timer.fire()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func move() {
    progView.progress = i
    i = i + CGFloat(0.01)
  }
  
}

