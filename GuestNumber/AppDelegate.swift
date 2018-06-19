//
//  AppDelegate.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/16.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GameTimerManagerDelegate{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        var i = 1
//        var tag = "+"
//        while true {
//               let model = GameLvManager.share.getGameFormula(hard: .General, Level: i)
//                i = i + 1
//            switch model.digitSymbol{
//                case 0:
//                    tag = "+"
//                    print("第 \(i) 关 \(model.digitA)  \(tag)  \(model.digitB) = \(model.result)")
//                case 1:
//                    tag = "-"
//                    print("第 \(i) 关 \(model.digitA)  \(tag)  \(model.digitB) = \(model.result)")
//                case 2:
//                    tag = "*"
//                    print("第 \(i) 关 \(model.digitA)  \(tag)  \(model.digitB) = \(model.result)")
//            default:
//                break
//            }
//        }
        
//        let manager = GameTimerManager.share
//        manager.delegate = self
//        manager.configurationCountDown(TimeInterval: 10)
//        manager.startTimer()
        
        return true
    }
    
    
    ///时间开始
    func gameTimerManagerTimerStart(countdownTime:Float){
        print("马上开始倒计时\(countdownTime)")
    }
    /// 时间准备结束
    func gameTimerManagerTimerWillOver(currentTime:Float){
        print("倒计时马上结束\(currentTime)")
    }
    /// 时间已经结束
    func gameTimerManagerTimerDidOver(isWin:Bool){
        print("倒计时已经结束")
    }
    ///时间变化
    func gameTimerManagerTimerChange(currentTime:Float){
        print("时间在流逝----\(currentTime)")
    }
    ///时间暂停
    func gameTimerManagerTimerPause(currentTime:Float){
        print("时间在\(currentTime)停止了")
    }
    ///时间取消
    func gameTimerManagerTimerCancel(currentTime:Float){
        print("时间取消了")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

