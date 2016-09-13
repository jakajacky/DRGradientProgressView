//
//  DRGradientProgressView.swift
//  渐变色+进度条
//
//  Created by xqzh on 16/9/12.
//  Copyright © 2016年 xqzh. All rights reserved.
//

import UIKit

class DRGradientProgressView: UIView {

  // 进度
  var progress:CGFloat
  
  var proglayer: CAGradientLayer
  
  override init(frame: CGRect) {
    progress = 1.0
    proglayer = CAGradientLayer()
    super.init(frame: frame)
    
    self.layer.addSublayer(shadowAsInverse())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func shadowAsInverse() -> CAGradientLayer {
    let newShadowFrame = CGRectMake(0, 0, 0, self.bounds.height)
    proglayer.frame = newShadowFrame
    // 渐变的方向
    proglayer.startPoint = CGPointMake(0.0, 0.5)
    proglayer.endPoint   = CGPointMake(1.0, 0.5)
    // 添加渐变的颜色组合
    let  colors = NSMutableArray()
    var hue = 0
    for _ in 0...360 {
      if hue > 360 {
        break
      }
      let color:UIColor
      color = UIColor(hue: 1.0 * CGFloat(hue) / 360.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
      colors.addObject(color.CGColor)
      hue += 5
    }
    proglayer.colors = colors as [AnyObject]
    
    // 渐变颜色滚动动画
    let colorArray = NSMutableArray(array: proglayer.colors!)
    let lastColor = colorArray.lastObject!
    colorArray.removeLastObject()
    colorArray.insertObject(lastColor, atIndex: 0)
    let shiftedColors = NSArray(array: colorArray)
    proglayer.colors = shiftedColors as [AnyObject]
    let animation = CABasicAnimation(keyPath: "zxq_colors")
    animation.toValue = shiftedColors
    animation.duration = 0.02
    animation.fillMode = kCAFillModeForwards
    animation.delegate = self
    proglayer.addAnimation(animation, forKey: "zxq_animateGradient")
    
    return proglayer;
  }
}

extension DRGradientProgressView {
  
  override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    let newShadowFrame = CGRectMake(0, 0, self.bounds.width, self.bounds.height)
    proglayer.frame = newShadowFrame
    
    let colorArray = NSMutableArray(array: proglayer.colors!)
    let lastColor = colorArray.lastObject!
    colorArray.removeLastObject()
    colorArray.insertObject(lastColor, atIndex: 0)
    let shiftedColors = NSArray(array: colorArray)
    proglayer.colors = shiftedColors as [AnyObject]
    
    let animation = CABasicAnimation(keyPath: "zxq_colors")
    animation.toValue = shiftedColors
    animation.duration = 0.02
    animation.fillMode = kCAFillModeForwards
    animation.delegate = self
    proglayer.addAnimation(animation, forKey: "zxq_animateGradient")
    
    // 增加 进度模式
    let maskLayer = CALayer()
    maskLayer.frame = CGRectMake(0.0, 0.0, 0.0, self.bounds.height)
    maskLayer.backgroundColor = UIColor.blackColor().CGColor
    proglayer.mask = maskLayer
    
    var maskRect = maskLayer.frame
    maskRect.size.width = CGRectGetWidth(self.bounds) * progress
    maskLayer.frame = maskRect
    
  }
}

