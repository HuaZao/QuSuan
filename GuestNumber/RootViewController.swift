//
//  RootViewController.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/18.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit


class RootViewController: UIViewController {
    
    @IBOutlet weak var historyPoint: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let point = UserDefaults.standard.object(forKey: pointString) as? Int{
            self.historyPoint.text = "历史最高分:\(point)"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func gameStartAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            globalHard = .Easy
        case 2:
            globalHard = .General
        case 3:
            globalHard = .Hentai
        default:
            globalHard = .Hentai
        }
        self.performSegue(withIdentifier: "ShowGame", sender: self)
    }
    

}
