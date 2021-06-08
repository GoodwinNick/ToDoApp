//
//  ProtocolForTransferData.swift
//  ToDo
//
//  Created by Евгений Петренко on 03.06.2021.
//

import Foundation

protocol TransferedDelegate: AnyObject {
    func addNew(title: String,
                description: String,
                date: Date,
                priority: Int)
    
    func updateTask(title: String,
                    description: String,
                    date: Date,
                    priority: Int)
    
    func getInfo() -> Task
    func deleteTask()
}
