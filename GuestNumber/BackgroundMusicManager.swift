//
//  BackgroundMusicManager.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/19.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class BackgroundMusicManager: NSObject {
    
    static let share = BackgroundMusicManager()
    
    //获取声音地址
   fileprivate let path = Bundle.main.path(forResource: "背景音乐", ofType: "wav")
    fileprivate var player:AVAudioPlayer? //播放器

     func playBackgroundMusic(){
        //播放
        do{
            self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            self.player?.play()
        }catch{
            print(error)
        }
    }
    
     func stopBackgroundMusic(){
        self.player?.pause()
    }
    
    
    func playTapMusic(){
        //建立的SystemSoundID对象
        var soundID:SystemSoundID = 0
        //获取声音地址
        let path = Bundle.main.path(forResource: "Tap", ofType: "wav")
        //地址转换
        let baseURL = NSURL(fileURLWithPath: path!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //播放声音
        AudioServicesPlaySystemSound(soundID)
    }
    
    
    func playGameOverMusic(){
        //建立的SystemSoundID对象
        var soundID:SystemSoundID = 0
        //获取声音地址
        let path = Bundle.main.path(forResource: "gameOver", ofType: "wav")
        //地址转换
        let baseURL = NSURL(fileURLWithPath: path!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //播放声音
        AudioServicesPlaySystemSound(soundID)
    }
    
    func playGameSuccessMusic(){
        //建立的SystemSoundID对象
        var soundID:SystemSoundID = 0
        //获取声音地址
        let path = Bundle.main.path(forResource: "success", ofType: "wav")
        //地址转换
        let baseURL = NSURL(fileURLWithPath: path!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //播放声音
        AudioServicesPlaySystemSound(soundID)
    }
    
    
}
