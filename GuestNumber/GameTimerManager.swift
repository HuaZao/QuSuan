//
//  GameTimerManager.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/17.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit

@objc protocol GameTimerManagerDelegate:class {
    ///时间开始
    func gameTimerManagerTimerStart(countdownTime:Float)
    /// 时间准备结束
    func gameTimerManagerTimerWillOver(currentTime:Float)
    /// 时间已经结束
    func gameTimerManagerTimerDidOver(isWin:Bool)
    ///时间变化
    func gameTimerManagerTimerChange(currentTime:Float)
    ///时间暂停
    func gameTimerManagerTimerPause(currentTime:Float)
    ///时间取消
    func gameTimerManagerTimerCancel(currentTime:Float)

}

class GameTimerManager: NSObject {

   @objc weak var delegate:GameTimerManagerDelegate?
    fileprivate var timer:DispatchSourceTimer?
    fileprivate var countdownTime:Float = 0.00  // 10
    var currentTime:Float = 0.00  // 1
    var userUserTime:Float{
        get{
            return (countdownTime - currentTime)
        }
    }
    static let share = GameTimerManager()
    
    func configurationCountDown(TimeInterval:Float){
        self.countdownTime = TimeInterval
    }
    
    func startTimer(){
        self.delegate?.gameTimerManagerTimerStart(countdownTime: self.countdownTime)
        var timeout:Double = Double(self.countdownTime * 100)
        var seconds:Double = timeout;
        self.timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        self.timer?.schedule(deadline: .now(), repeating:0.01)
        self.timer?.setEventHandler {
            seconds = timeout / 100
            if (seconds <= 3 && seconds != 0){
                self.delegate?.gameTimerManagerTimerWillOver(currentTime: Float(seconds))
            }
            if (timeout <= 0){
                self.delegate?.gameTimerManagerTimerDidOver(isWin: false)
                self.timer?.cancel()
            }else{
                self.currentTime = Float(seconds)
                self.delegate?.gameTimerManagerTimerChange(currentTime: Float(seconds))
            }
            timeout = timeout - 1
        }
        self.timer?.resume()
    }
    
    func cancelTimer(){
        self.delegate?.gameTimerManagerTimerCancel(currentTime: self.currentTime / 100)
        self.timer?.cancel()
    }
    
    func pauseTimer(){
        self.countdownTime = self.currentTime
        self.delegate?.gameTimerManagerTimerPause(currentTime: self.currentTime / 100)
        self.timer?.suspend()
    }
    
}
