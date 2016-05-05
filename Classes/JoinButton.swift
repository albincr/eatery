//
//  JoinButton.swift
//  Eatery
//
//  Created by Monica Ong on 4/27/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//

import UIKit

class JoinButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        
        self.unjoined()

    }
    
    func joined(){
        let green = UIColor(red:0.71, green:0.83, blue:0.58, alpha:1.0)
        self.layer.borderColor = green.CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = green
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setTitle("Joined", forState: .Normal)
    }
    
    func unjoined(){
        let lightGrey = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        self.layer.borderColor = lightGrey.CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.whiteColor()
        self.setTitleColor(lightGrey, forState: .Normal)
        self.setTitle("Join", forState: .Normal)
    }


}
