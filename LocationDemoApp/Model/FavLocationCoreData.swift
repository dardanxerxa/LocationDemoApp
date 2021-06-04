//
//  FavLocationCoreData.swift
//  LocationDemoApp
//
//  Created by Dardan Xërxa on 6/2/21.
//  Copyright © 2021 Dardan Xërxa. All rights reserved.
//

import Foundation
import CoreData

class FavLocationCoreData {
    
    static let shared = FavLocationCoreData()
    
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "FavLocation")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()
    
    private init() { }
}



