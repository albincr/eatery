//
//  BeaconsFeedCell.swift
//  Eatery
//
//  Created by Monica Ong on 3/13/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//

import UIKit

class BeaconsFeedCell: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var creatorProPic: UIImageView!
    @IBOutlet weak var creator: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var attendeeProPic1: UIImageView!
    @IBOutlet weak var attendeeProPic2: UIImageView!
    @IBOutlet weak var attendeeProPic3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        creatorProPic.layer.cornerRadius = creatorProPic.frame.width/2.0
        attendeeProPic1.layer.cornerRadius = attendeeProPic1.frame.width/2.0
        attendeeProPic2.layer.cornerRadius = attendeeProPic2.frame.width/2.0
        attendeeProPic3.layer.cornerRadius = attendeeProPic3.frame.width/2.0
    }
    
}
