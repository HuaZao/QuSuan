//
//  ViewController.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/16.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit
import PopupDialog
import SnapKit

class ViewController: UIViewController,GameTimerManagerDelegate{
    
    var currentLevel = 1 {
        didSet{
            self.levelLabel.text = "当前关卡:\(currentLevel)"
        }
    }
    var isStop = false
    var gameParam = GameParamModel()
    var gameModel = DigitLvModel()
    var currenrScore = 0{
        didSet{
            self.scoreLabel.text = "分数:\(currenrScore)"
        }
    }
    var inputString:String = String(){
        didSet{
            if inputString != "" {
                self.answerLabel.text = "你的回答:\(inputString)"
            }
            self.verifyResult()
        }
    }
    let timerManager = GameTimerManager.share
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var gameAnswerView: GameAnswerView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionStackView: UIStackView!
    @IBOutlet weak var questionStackViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerManager.delegate = self
        self.initGameAnswer()
    }
    
    
    private func initGameAnswer(){
        self.answerLabel.text = "你的回答:等待选中"
        self.inputString = String()
        self.gameModel = GameLvManager.share.getGameFormula(hard: globalHard, Level: self.currentLevel)
        var tag = "+"
        switch  self.gameModel.digitSymbol{
        case 0:
            tag = "+"
        case 1:
            tag = "-"
        case 2:
            tag = "x"
        default:
            break
        }
        self.setGameQuestionImage(digitA: self.gameModel.digitA ,digitB: self.gameModel.digitB, tag: tag,result: self.gameModel.result)
        self.gameParam = GameLvManager.share.getGameParam(lv: self.currentLevel, result: self.gameModel.result, tag: tag)
        self.timerManager.configurationCountDown(TimeInterval: self.gameParam.time)
        self.startGame()
    }
    
    private func setGameQuestionImage(digitA:Int,digitB:Int,tag:String,result:Int){
        self.questionStackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        var layOut = ("\(digitA)".count + "\(digitB)".count) >= 5 ? 30:40
        if UIDevice.current.model == "iPad"{
            layOut = 40
            self.questionStackViewHeight.constant = CGFloat(layOut)
        }else{
            self.questionStackViewHeight.constant = CGFloat(layOut)
        }
        
        //创建第一个
        for i in "\(digitA)"{
            let image = UIImageView(image: UIImage(named: "\(String(i))"))
            self.questionStackView.addArrangedSubview(image)
            image.snp.makeConstraints { (make) in
                make.width.height.lessThanOrEqualTo(layOut)
            }
        }
        
        //添加运算符
        let imageTag = UIImageView(image: UIImage(named: "\(tag)"))
        imageTag.contentMode = .scaleAspectFit
        self.questionStackView.addArrangedSubview(imageTag)
        imageTag.snp.makeConstraints { (make) in
            make.width.equalTo(layOut + 16)
            make.height.equalTo(layOut)
        }
        
        //创建第二个
        for i in "\(digitB)"{
            let image = UIImageView(image: UIImage(named: "\(String(i))"))
            self.questionStackView.addArrangedSubview(image)
            image.snp.makeConstraints { (make) in
                make.width.height.lessThanOrEqualTo(layOut)
            }
        }
        
        //添加运算符
        let imageEq = UIImageView(image: UIImage(named: "="))
        imageEq.contentMode = .scaleAspectFit
        imageEq.snp.makeConstraints { (make) in
            make.width.equalTo(layOut + 16)
            make.height.equalTo(layOut)
        }
        self.questionStackView.addArrangedSubview(imageEq)
        
        //添加 结果
        let imageResult = UIImageView(image: UIImage(named: "?"))
        imageResult.contentMode = .scaleAspectFit
        imageResult.snp.makeConstraints { (make) in
            make.width.equalTo(layOut + 8)
            make.height.equalTo(layOut)
        }
        self.questionStackView.addArrangedSubview(imageResult)
        
        UIView.animate(withDuration: 0.2) {
            self.questionStackView.layoutIfNeeded()
        }
        
        print("第 \(self.currentLevel) 关 \(self.gameModel.digitA)  \(tag)  \(self.gameModel.digitB) = \(self.gameModel.result)")
    }
    
    
    private func startGame(){
        self.timerManager.startTimer()
        self.gameAnswerView.creatPointView(radius: Int(self.gameParam.radius))
        BackgroundMusicManager.share.playBackgroundMusic()
    }
    
    
    private func verifyResult(){
        if self.inputString == "\(self.gameModel.result)" {
            self.gameOver(win: true)
        }
    }
    
    private func gameOver(win:Bool){
        self.isStop = true
        self.timerManager.cancelTimer()
        self.gameAnswerView.pointArray.removeAll()
        BackgroundMusicManager.share.stopBackgroundMusic()
        if win {
           self.gameWin()
        }else{
            self.currentLevel  =  self.currentLevel - 1
            self.currenrScore  =  self.currenrScore - 1
            self.gameLost()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitGame(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.gameOver(win: false)
        }
    }
    
    
    private func gameLost(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.performSegue(withIdentifier: "gameOver", sender: self.currentLevel)
        }
    }
    
    private func gameWin(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            BackgroundMusicManager.share.playGameSuccessMusic()
            self.currenrScore = self.currenrScore + 1
            self.currentLevel =  self.currentLevel + 1
            let title = "ฅ^ω^ฅ 哇!居然被你过关了"
            let message = "本次用时:\(self.timerManager.userUserTime)"
            let image = UIImage(named: "headerBg")
            let popup = PopupDialog(title: title, message: message, image: image,gestureDismissal:false)
            let nextButton = DestructiveButton(title: "下一关") {  [unowned self]  in
                self.initGameAnswer()
            }
            popup.addButtons([nextButton])
            popup.dismiss({ [unowned self]  in
                self.initGameAnswer()
            })
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    @IBAction func reloadAnswerAction(_ sender: UIButton) {
            self.answerLabel.text = "你的回答:等待选中"
            self.inputString = String()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ClearingViewController{
            vc.lvCount = sender as! Int
        }
    }
    
}

extension ViewController{
    ///时间开始
    func gameTimerManagerTimerStart(countdownTime:Float){
        self.timerLabel.textColor = #colorLiteral(red: 0.5803921569, green: 0.2156862745, blue: 1, alpha: 1)
        self.isStop = false
        print("马上开始倒计时\(countdownTime)")
    }
    /// 时间准备结束
    func gameTimerManagerTimerWillOver(currentTime:Float){
        DispatchQueue.main.async {
            self.timerLabel.textColor = UIColor.red
        }
    }
    /// 时间已经结束
    func gameTimerManagerTimerDidOver(isWin:Bool){
        DispatchQueue.main.async {
            self.timerLabel.text = "时间:0.00"
            self.isStop = true
            self.gameOver(win: false)
        }
    }
    ///时间变化
    func gameTimerManagerTimerChange(currentTime:Float){
        DispatchQueue.main.async {
            self.timerLabel.text = "时间:\(currentTime)"
        }
    }
    ///时间暂停
    func gameTimerManagerTimerPause(currentTime:Float){
        print("时间在\(currentTime)停止了")
    }
    ///时间取消
    func gameTimerManagerTimerCancel(currentTime:Float){
        print("时间取消了")
    }
}
