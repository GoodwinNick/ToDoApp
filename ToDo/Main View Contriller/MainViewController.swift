//
//  ViewController.swift
//  ToDo
//
//  Created by Евгений Петренко on 01.06.2021.
//

import UIKit




class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var toDoTable: UITableView!
    
    private var indexOfTypedRow: Int?
    private let toDoList = ToDoList()
    private let identifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTable.register(UINib(nibName: "toDoCellIdn",
                                 bundle: nil),
                           forCellReuseIdentifier: identifier)
    }
    
    
    @IBAction func sortByPriority(_ sender: Any) {
        toDoList.sortBy(.priotity)
        toDoTable.reloadData()
    }
    
    @IBAction func sortByDate(_ sender: Any) {
        toDoList.sortBy(.date)
        toDoTable.reloadData()
    }
    
    // MARK: SEND_SELF_TO_DELEGATE
    @IBSegueAction func goToInfoScreen(_ coder: NSCoder) -> AddNewTaskViewController? {
        let viewController = AddNewTaskViewController(coder: coder)
        viewController?.delegate = self
        return viewController
    }
    
    @IBSegueAction func goToAddTaskScreen(_ coder: NSCoder) -> InfoAboutTaskViewController? {
        let viewController = InfoAboutTaskViewController(coder: coder)
        viewController?.delegate = self
        return viewController
    }
    
    // MARK: ALL_ABOUT_TABLE
    func tableView(_ tableView: UITableView,
                   willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        indexOfTypedRow = indexPath.row
        return indexPath
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return toDoList.tasks?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoIdn",
                                                       for: indexPath) as! CustomTableViewCell
     
        guard let task = toDoList.tasks?[indexPath.row] else {
            return UITableViewCell()
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        cell.titleLabel?.text = task.title
        cell.descriptionLabel?.text = task.description
        cell.priorityLabel?.text = "Priority " + String(task.priority!)
        cell.dateToBeDoneLabel?.text = "Date " + String(formatter.string(from: task.dateToBeDone ?? Date.init()))
        return cell
    }
}








// MARK: EXTENSION_FOR_DELEGATING
extension MainViewController: TransferedDelegate {
    
    
    // MARK: DELEGATE_FUNCs
    func addNew(task: Task) {
        toDoList.addNewTask(newTask: task)
        toDoTable.reloadData()
    }
    
    func updateTask(task: Task) {
    
        
        toDoList.editTask(task: task, index: indexOfTypedRow!)
        toDoTable.reloadData()
    }
    func getInfo() -> Task {
        
        guard let index = indexOfTypedRow else {
            return Task(title: "Wrong", description: "Wrong", priority: 0,dateToBeDone: .init())
        }
        return (toDoList.tasks?[index])!
    }
    
    func deleteTask() {
        guard let index = indexOfTypedRow else {
            return
        }
        
        guard let task = toDoList.tasks?[index] else {
            return
        }
        
        toDoList.deleteTask(task)
        toDoTable.reloadData()
    }
    
}
