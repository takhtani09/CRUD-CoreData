//
//  Student+CoreDataProperties.swift
//  CRUD CoreData
//
//  Created by IPS-108 on 16/06/23.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var age: Int16
    @NSManaged public var gender: Bool

}

extension Student : Identifiable {

}
