//
//  ProtocolForTransferData.swift
//  ToDo
//
//  Created by Евгений Петренко on 03.06.2021.
//

import Foundation

protocol TransferedDelegate: AnyObject {
    func addNew(task: Task)
    func updateTask(task: Task)
    func getInfo() -> Task
    func deleteTask()
}
