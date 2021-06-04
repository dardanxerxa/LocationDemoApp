//
//  Location+CoreDataClass.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 3.6.21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var id: UUID
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var image: String
}
