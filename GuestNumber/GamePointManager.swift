//
//  GamePointManager.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/17.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit

class GamePointManager: NSObject {
    
   static let height = Float(UIScreen.main.bounds.size.height)
    static let width = Float(UIScreen.main.bounds.size.width)
    
    static func getPointFrame(PointViewArray:[UIView],radius:Float,containerRect:CGRect) -> NSValue{
        var isOk = false
        var frame:CGRect!
        let arc = Int(arc4random_uniform(35))
        let newRadius = Float(arc < 20 ? 20:arc)
        while isOk != true {
            let x = arc4random() % UInt32(width - 12 - newRadius * 2)
            let y = arc4random() % UInt32(Float(containerRect.size.height) - 12 - newRadius * 2)
            frame = CGRect(x:CGFloat(x), y: CGFloat(y), width: CGFloat(newRadius * 2), height: CGFloat(newRadius * 2))
            if PointViewArray.count == 0{
                isOk = true
            }
            for view in PointViewArray{
                if view.frame.intersects(frame) {
                        isOk = false
                       break
                    }else{
                        isOk = true
                    }
                }
        }
        return NSValue(cgRect: frame)
    }

}
