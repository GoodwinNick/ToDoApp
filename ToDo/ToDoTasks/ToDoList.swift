//
//  ToDoList.swift
//  ToDo
//
//  Created by Евгений Петренко on 01.06.2021.
//

import SwiftUI

class ToDoList {
    private (set) var tasks: [Task]? = [Task]()
    
    enum SortBy {
        case priotity
        case date
    }
    
    func addNewTask(newTask: Task) {
        tasks?.append(newTask)
    }
    
    func editTask (task: Task, index: Int) {
        tasks?[index] = task
    }
    
    func sortBy(_ typeOfSort: SortBy) {
        print(tasks!)
        switch typeOfSort {
        case .priotity:
            tasks = tasks?.sorted(by: {
                $0.priority! < $1.priority!
            })
            
        case .date:
            tasks = tasks?.sorted(by: {
                $0.dateToBeDone! < $1.dateToBeDone!
            })
        }
        print(tasks!)
    }
    
    func deleteTask (_ deleteTask: Task) {
        guard let _ = tasks?.count else {
            return
        }
        tasks?.removeAll { item in
            if item.title == deleteTask.title,
            item.description == deleteTask.description,
            item.dateToBeDone == deleteTask.dateToBeDone,
            item.priority == deleteTask.priority { return true }
            
            return false
        }
    }
        
}
