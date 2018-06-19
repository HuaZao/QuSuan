//
//  GameAnswerView.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/17.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit

class GameAnswerView: UIView {
    
    var pointArray = [UIView]()
    var totalPointNum = 1
    lazy var resultArray:[String] = {
        return Array("\(self.vc.gameModel.result)".map{String($0)})
    }()
    
    @IBOutlet weak var vc:ViewController!
    
    @IBOutlet weak var pointRangeView:UIView!
    
    lazy var matchResult:[Int] = {
        if globalHard == .Easy{
            return [1,0]
        }
        if globalHard == .General{
            return [4]
        }
        return []
    }()
    
    
    func creatPointView(radius:Int){
        if self.vc.isStop {
            return
        }
        while self.pointArray.count < self.vc.gameParam.pointNum{
            let frame = GamePointManager.getPointFrame(PointViewArray: self.pointArray, radius: Float(radius), containerRect: self.pointRangeView.frame).cgRectValue
            self.totalPointNum = totalPointNum + 1
            let pointView = GamePointView(frame: frame)
            if self.matchResult.contains(self.totalPointNum % 5){
                let result = "\(self.vc.gameModel.result)"
                let range = NSRange(location: Int(arc4random() % UInt32(result.count)), length: 1)
                let number = Int(("\(self.vc.gameModel.result)" as NSString).substring(with: range))!
                pointView.setPointImage(number: number)
                pointView.tag = number
            }
            pointView.animationCallback = {
                $0?.removeFromSuperview()
                self.pointArray.remove(object: $0!)
                if self.vc == nil{return}
                if(self.vc.isStop == false) 
                {
                    self.creatPointView(radius: radius)
                }
            }
            
            pointView.pointTap = {
                self.vc.inputString.append("\($0!.tag)")
                $0?.breakAnim(withCornerRadius: true)
            }
            self.pointArray.append(pointView)
            self.pointRangeView.addSubview(pointView)
        }
        
    }
    

}


extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
