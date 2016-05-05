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
    @IBOutlet weak var joinButton: JoinButton!

    @IBOutlet weak var attendeeProPic1: UIImageView!
    @IBOutlet weak var attendeeProPic2: UIImageView!
    @IBOutlet weak var attendeeProPic3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func joined(){
        self.joinButton.joined()
    }
    
    func unjoined(){
        self.joinButton.unjoined()
    }
    
}
