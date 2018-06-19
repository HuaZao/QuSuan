//
//  GamePointView.swift
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/17.
//  Copyright © 2018年 SQHL. All rights reserved.
//

import UIKit

class GamePointView: HZBasePointView{

    var pointLabel: UILabel!
    var pointImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.pointLabel = UILabel(frame:self.bounds)
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5986729452)
        self.pointLabel.adjustsFontSizeToFitWidth = true
        self.pointLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.pointLabel.numberOfLines = 1
        self.pointLabel.textAlignment = .center
        let arc = arc4random_uniform(10)
        self.pointLabel.text = "\(arc)"
        self.pointLabel.textColor = UIColor.white
        self.tag = Int(arc)
        self.pointLabel.backgroundColor = UIColor.clear
//        self.addSubview(self.pointLabel)
        
        //
        self.pointImage = UIImageView(frame: self.bounds)
        self.pointImage.contentMode = .center
        self.setPointImage(number: Int(arc))
        self.addSubview(self.pointImage)

        
    }
    
    func setPointImage(number:Int) {
        let imageName = "s\(number)"
        self.pointImage.image = UIImage(named: imageName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.masksToBounds = !self.isTap
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    override func handleTap() {
        super.handleTap()
        self.isTap = true
        self.pointTap(self)
        BackgroundMusicManager.share.playTapMusic()
    }
    
}
