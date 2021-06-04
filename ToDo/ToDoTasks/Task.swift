//
//  Task.swift
//  ToDo
//
//  Created by Евгений Петренко on 01.06.2021.
//

import UIKit

struct Task {
    private (set) var title: String?
    private (set) var description: String?
    private (set) var priority: Int? = 0
    private (set) var dateToBeDone: Date?

    
    init(title: String, description: String, priority: Int, dateToBeDone: Date) {
        self.title = title
        self.description = description
        self.priority = priority
        self.dateToBeDone = dateToBeDone
    }

}
