//
//  UsageYearly+CoreDataProperties.swift
//  SPHTechExam
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation
import CoreData

extension UsageYearly {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsageYearly> {
        return NSFetchRequest<UsageYearly>(entityName: "UsageYearly")
    }
    
    @NSManaged var year: String
    @NSManaged var quarter: String
    @NSManaged var volume: String
}
