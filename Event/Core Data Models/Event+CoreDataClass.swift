//
//  Event+CoreDataClass.swift
//  Event
//
//  Created by Joshua Thompson on 18/07/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class Event: NSManagedObject {

}

public class EventManager: NSObject {

    var coreDataManager = CoreDataManager()

    func addEvent(date: NSDate, description: String, imageUrl: [String]) {
        
        if let event =  NSEntityDescription.insertNewObject(forEntityName: "Event", into: coreDataManager.managedObjectContext) as? Event {
            
            event.eventDescription = description
            event.eventDate = date
            event.eventImageUrl = imageUrl
            
            coreDataManager.saveContext()
        }
    }
}
