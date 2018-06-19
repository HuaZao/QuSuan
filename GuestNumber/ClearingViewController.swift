//
//  ClearingViewController.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/19.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit

let pointString = "Point"

class ClearingViewController: UIViewController {
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var lvLabel: UILabel!
    @IBOutlet weak var psLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    
    var lvCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackgroundMusicManager.share.playGameOverMusic()
        self.lvLabel.text = "你成功闯过了\(self.lvCount)关"
        self.pointLabel.text = "总分:\(self.lvCount)"
        self.designationLabel.text = "获得\"\(self.guestDesignation(self.lvCount))\"称号"
        if let point = UserDefaults.standard.object(forKey: pointString) as? Int{
            if lvCount > point{
                UserDefaults.standard.set(lvCount, forKey: pointString)
            }
        }else{
            UserDefaults.standard.set(lvCount, forKey: pointString)
        }
    }

    
    private func guestDesignation(_ lv:Int)->String{
        switch lv {
        case 0...5:
            self.psLabel.text = "PS:Emmm....你数学是体育老师教的?"
            return "战五渣"
        case 6...10:
            self.psLabel.text = "PS:快扶我起来,我还能再战十个回合"
            return "手残党"
        case 11...15:
            self.psLabel.text = "PS:哦?是吗"
            return "呵呵"
        case 16...20:
            self.psLabel.text = "PS:少年?真不考虑给个好评"
            return "小试牛刀"
        case 21...25:
            self.psLabel.text = "PS:你的手还好吗?"
            return "渐入佳境"
        case 26...30:
            self.psLabel.text = "PS:你该不会把脚也用上了吧???"
            return "我是处女座"
        case 31...35:
            self.psLabel.text = "PS:大佬...需要冰可乐吗?"
            return "大哥,抽烟"
        case 36...40:
            self.psLabel.text = "PS:无敌...是多么寂寞"
            return "高手寂寞"
        default:
            self.psLabel.text = "P.S:你应该还没女朋友吧......"
            return "加藤鹰之手"
        }
        
    }
    
    @IBAction func toRootAction(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
