//
//  Event+CoreDataProperties.swift
//  Event
//
//  Created by Joshua Thompson on 18/07/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var eventDate: NSDate?
    @NSManaged public var eventDescription: String?
    @NSManaged public var eventId: String?
    @NSManaged public var eventImageUrl: [String]?
}
