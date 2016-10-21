//
//  Score+CoreDataProperties.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/21.
//  Copyright © 2016年 Ned. All rights reserved.
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score");
    }

    @NSManaged public var score: Int64
    @NSManaged public var board: NSObject?

}
