//
//  BeaconsEvent.swift
//  Eatery
//
//  Created by Monica Ong on 3/16/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//

import UIKit

class BeaconsEvent: NSObject {
    
    public var date: NSDate
    public var title: String
    public var joined: Bool
    public var attendees: [String] //could be an empty array
    public var creator: String
    
    init(date: NSDate, title: String, creator: String, joined: Bool, attendees: [String] = []) {
//        super.init()
        self.date = date
        self.title = title
        self.creator = creator
        self.joined = joined
        self.attendees = attendees
    }

}
