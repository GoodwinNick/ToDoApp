//
//  Task+CoreDataProperties.swift
//  ToDo
//
//  Created by Евгений Петренко on 05.06.2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var dateToBeDone: Date?
    @NSManaged public var descriptionOfTask: String?
    @NSManaged public var priorityOfTask: Int16
    @NSManaged public var titleOfTask: String?

}

extension Task : Identifiable {

}
