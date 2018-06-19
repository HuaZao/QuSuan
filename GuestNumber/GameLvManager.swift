//
//  GameLvManager.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/16.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit
import Foundation

struct GameParamModel{
    var time:Float = 0.00
    var radius:Float = 0.00
    var pointNum = 0
    var target = 0
}

/// 关卡难度
///
/// - Easy: 简单
/// - General: 普通
/// - Hentai: 变态
enum HardModel {
    case Easy
    case General
    case Hentai
}

/// 关卡数据
struct DigitLvModel{
    var digitA = 0
    var digitB = 0
    var digitSymbol = 0 // 0为加 1为减 2为乘法
    var result = 0
}

var globalHard:HardModel = .General

class GameLvManager: NSObject {
    
 
    static let share = GameLvManager()
    
    
    func getGameParam(lv:Int,result:Int,tag:String) -> GameParamModel{
        var time:Float = 0.00
        var radius:Float = 0.00
        var pointNum = 0
        var offset = result.words.count * 2
        if tag == "x" && globalHard == .Hentai{
            offset = offset + 5
        }
        time = 10 * pow(Float(lv), -0.1) + Float(offset)
        radius = 30
        if UIDevice.current.model == "iPad"{
            pointNum = 30
        }else{
            pointNum = 15
        }
        return GameParamModel(time: time, radius: radius, pointNum: pointNum, target: 0)
    }
    
    
    /// 返回游戏关卡
    /// - Parameter hard: 关卡难度
    /// - Parameter Level: 关卡数据
    func getGameFormula(hard:HardModel,Level:Int)->DigitLvModel{
        globalHard = hard
        // 0为加 1为减 2为乘法
        var symbol = 0
        //数字的位数
        var length = ceilf(Float(Level) / 2)
        //前四关给玩家先熟悉(随机加法或者减法)
        if Level < 4{
            symbol = Int(arc4random_uniform(2))
        }else if Level < 10{
            symbol = Int(arc4random_uniform(3))
        }else{
            symbol = 2
        }
        switch symbol {
        case 0:
            length = (length > 5) ? 5:length
        case 1:
            length = (length > 5) ? 5:length
        case 2:
             length = (length > 2) ? 2 : length;
        default:
            break
        }
        switch hard {
        case .Easy:
            //简单难度全部加减
            symbol = Int(arc4random_uniform(2))
            if Level > 10{
                length = Float(arc4random_uniform(2) + 1)
            }else{
                length = 1
            }
        case .General:
            if Level > 4  && Level < 10{
                symbol = Int(arc4random_uniform(3))
            }else{
                symbol = 2
            }
        case .Hentai:
            //变态难度 默认乘法 随机上3位数,虐死玩家
            symbol = 2
            length = Float(2 + arc4random_uniform(1))
        }
        //生成两个length位内的操作数
        var digitA = arc4random() % UInt32(pow(10, length))
        var digitB = arc4random() % UInt32(pow(10, length))
        //减法不能负数
        if symbol == 1{
            if digitA < digitB{
                digitA = digitA + digitB
                digitB = digitA - digitB
                digitA = digitA - digitB
            }
        }
        var value = 0
        switch symbol{
        case 0:
            value = Int(digitA + digitB)
        case 1:
             value = Int(digitA - digitB)
        case 2:
             value = Int(digitA * digitB)
        default:
            break
        }
        let model = DigitLvModel(digitA: Int(digitA), digitB: Int(digitB), digitSymbol: Int(symbol),result:value)
        return model
    }

}
