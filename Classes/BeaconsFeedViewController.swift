//
//  BeaconsFeedViewController.swift
//  Eatery
//
//  Created by Monica Ong on 3/13/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BeaconsFeedCell"

public enum BeaconType: String {
    case Attending = "Attending"
    case Feed = "Feed"
}

class BeaconsFeedViewController: UICollectionViewController {
    
    private var sectionHeaderHeight: CGFloat = 40.0
    private var sections: [BeaconType] = [.Attending, .Feed]
    private var eventsAttending: [BeaconsEvent] = []
    private var eventsNewsFeed: [BeaconsEvent] = [] //Organized by date
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes & nib
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.registerNib(UINib(nibName: "BeaconsFeedCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        //View appearance
        view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        var section = 0
        if !eventsAttending.isEmpty{
            section += 1
        }
        if !eventsNewsFeed.isEmpty{
            section += 1
        }
        
        return section
        
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section]{
        case .Attending: return eventsAttending.count
        case .Feed: return eventsNewsFeed.count
        default: return 1
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BeaconsFeedCell
        var event = eventsAttending[indexPath.row]
        switch sections[indexPath.section]{
        case .Attending:
            event = eventsAttending[indexPath.row]
        case .Feed:
            event = eventsNewsFeed[indexPath.row]
        default:
            event = eventsAttending[indexPath.row]
        }
        
        cell.time.text = getTimeFromDate(event.date)
        cell.eventTitle.text = event.title
        cell.creatorName.text = event.creator
        //Set creator pro pic
        cell.creatorProPic.image = UIImage(named: "\(event.creator)")
        //Set joinbutton based if joined or not
        if event.joined{
            cell.joinButton.setImage(UIImage(named: "Joined"), forState: .Normal)
        } else{
            cell.joinButton.setImage(UIImage(named: "NotJoined"), forState: .Normal)
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
