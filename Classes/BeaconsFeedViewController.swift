//
//  BeaconsFeedViewController.swift
//  Eatery
//
//  Created by Monica Ong on 4/27/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//

import UIKit

enum BeaconType: String{
    case Attending
    case Feed
}

class BeaconsFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var collectionView: UICollectionView!
    private var eventType: [BeaconType] = [.Attending, .Feed]
    private var eventsAttending: [BeaconsEvent] = []
    private var eventsNewsFeed: [BeaconsEvent] = [] //N2Self: Organized by date
    
    override func viewDidLoad() {
        super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.93, alpha: 1)
        
    //Set up collection view
    setupCollectionView()
    
    view.addSubview(self.collectionView)
    
    //set up sample data
    eventsAttending.append(BeaconsEvent(date: date("4/28/2016 18:30"), title: "Come eat with me at Mattin's!", creator: "Lucas", joined: true, attendees: ["Felipe, Byron"]))
    eventsAttending.append(BeaconsEvent(date: date("5/01/2016 12:00"), title: "Come eat with me at Statler!", creator: "Andrew", joined: true, attendees: ["Felicia", "Patricia"]))
    eventsNewsFeed.append(BeaconsEvent(date: date("4/20/2016 16:00"), title: "Come eat with at Castle Black!", creator: "Jon's wolf", joined: false))
    eventsNewsFeed.append(BeaconsEvent(date: date("4/29/2016 8:30"), title: "Come eat with me!", creator: "Melinda", joined: false, attendees: ["Daenerys", "Jon", "Tyrion"]))

    
    
        
    }
    
    func setupCollectionView() {
        let layout = EateriesCollectionViewTableLayout()
        collectionView = UICollectionView(frame: UIScreen.mainScreen().bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "BeaconsFeedCell")
        collectionView.registerNib(UINib(nibName: "BeaconsFeedCell", bundle: nil), forCellWithReuseIdentifier: "BeaconsFeedCell")
        collectionView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 2 //Newsfeed Section & Attending Section
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch eventType[section]{
        case .Attending: return eventsAttending.count
        case .Feed: return eventsNewsFeed.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BeaconsFeedCell", forIndexPath: indexPath) as! BeaconsFeedCell
        var event = eventsAttending[indexPath.row]
        switch eventType[indexPath.section]{
        case .Attending:
            event = eventsAttending[indexPath.row]
        case .Feed:
            event = eventsNewsFeed[indexPath.row]
        }
        
        cell.time.text = getTimeFromDate(event.date)
        cell.eventTitle.text = event.title
        cell.creatorName.text = event.creator
        //Set creator pro pic
        cell.creatorProPic.image = UIImage(named: "profile")
        //Set joinbutton based if joined or not
        if event.joined{
            cell.joined()
        } else{
            cell.unjoined()
        }
        return cell
    }
    
    private func getTimeFromDate(date: NSDate) -> String{
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: date)
        calendar.dateFromComponents(dateComponents)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm"
        return dateFormatter.stringFromDate(date)
    }
    
    //String must have the format: yyyy/MM/dd HH:mm
        //HH:mm in 24 hours time
    private func date(date: String) -> NSDate{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        return formatter.dateFromString(date)!
    }
    
    // MARK: UICollectionViewDelegate
    // N2Self: Do I need this?
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 16)
    }
    
}
