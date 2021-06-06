//
//  ToDoList.swift
//  ToDo
//
//  Created by Евгений Петренко on 01.06.2021.
//

import SwiftUI
import CoreData

class ToDoList {
    
    private (set) var tasks: [Task]? = []
    
    enum SortBy {
        case priotity
        case date
    }
    
    // MARK: set task list
    func setTaskList(tasks: [Task]?) {
        self.tasks = tasks
    }
    
    // MARK: edit task
    func editTask(title: String, description: String, date: Date, priority: Int, index: Int) {
        tasks?[index].setValue(title, forKeyPath: "titleOfTask")
        tasks?[index].setValue(description, forKeyPath: "descriptionOfTask")
        tasks?[index].setValue(priority, forKeyPath: "priorityOfTask")
        tasks?[index].setValue(date, forKeyPath: "dateToBeDone")
        save()
        
    }
    
    // MARK: sort by option
    func sortBy(_ option: SortBy) {
        let context = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()

        var task: [Task]? = nil
        var sortBy: NSSortDescriptor
            
        switch option {
        case .priotity:
            sortBy = NSSortDescriptor(key:"priorityOfTask", ascending:true)
        case .date:
            sortBy = NSSortDescriptor(key:"dateToBeDone", ascending:true)
        }
        
        fetchRequest.sortDescriptors = [sortBy]
        
        do {
            task = try context.fetch(fetchRequest)
            setTaskList(tasks: task)
        } catch {
            setTaskList(tasks: task)
        }
        
        
    }
    // MARK: delete task by index
    func deleteTask (_ deleteTask: Task) {
        let managedContext = getContext()
        managedContext.delete(deleteTask)
        save()
        
    }
    // MARK: addNewTask
    func addNewTask(title: String, description: String, date: Date, priority: Int) {
        
        let managedContext = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        let nsmo = NSManagedObject(entity: entity, insertInto: managedContext)
        nsmo.setValue(title, forKeyPath: "titleOfTask")
        nsmo.setValue(description, forKeyPath: "descriptionOfTask")
        nsmo.setValue(priority, forKeyPath: "priorityOfTask")
        nsmo.setValue(date, forKeyPath: "dateToBeDone")
        tasks?.append(nsmo as! Task)
        save()
    }
    
    // MARK: save
    func save() {
        
        let context = getContext()
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Core data context getter
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
}

    
    
    
    
    
   
