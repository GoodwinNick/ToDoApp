//
//  ViewController.swift
//  ToDo
//
//  Created by Евгений Петренко on 01.06.2021.
//

import UIKit
import CoreData



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
    
    // MARK: fetch Request
    func fetchReq() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        do {
            let test = try managedContext.fetch(fetchRequest)
            toDoList.setTaskList(tasks: test as? [Task])
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
      }


    // MARK: - view will appear
      override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchReq()
      }

    
    @IBAction func sortByPriority(_ sender: Any) {
        toDoList.sortBy(.priotity)
        toDoTable.reloadData()
    }
    
    @IBAction func sortByDate(_ sender: Any) {
        toDoList.sortBy(.date)
        toDoTable.reloadData()
    }
    
    // MARK: send self to delegate
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
    
    // MARK: all about table
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
        formatter.dateStyle = .short
        
        let title = task.value(forKey: "titleOfTask") as? String
        cell.titleLabel?.text = title
        
        let description = task.value(forKey: "descriptionOfTask") as? String
        cell.descriptionLabel?.text = description
        
        let priority = task.value(forKey: "priorityOfTask") as? Int
        cell.priorityLabel?.text = "Priority " + (String(priority ?? 0))
        
        let date = formatter.string(from: task.value(forKey: "dateToBeDone") as? Date ?? .init())
        cell.dateToBeDoneLabel?.text = "Date " + date
        
        return cell
    }
}








// MARK: extension for delegating funcs
extension MainViewController: TransferedDelegate {
    
    func addNew(title: String, description: String, date: Date, priority: Int) {
        toDoList.addNewTask(title: title, description: description, date: date, priority: priority)
        toDoTable.reloadData()
    }
    
    func updateTask(title: String, description: String, date: Date, priority: Int) {
        toDoList.editTask(title: title, description: description, date: date, priority: priority, index: indexOfTypedRow!)
        toDoTable.reloadData()
    }

    func getInfo() -> Task {
        guard let index = indexOfTypedRow else {
            return Task()
        }
        return (toDoList.tasks?[index])!
    }
    
    func deleteTask() {
        guard let index = indexOfTypedRow else {
            return
        }
        toDoList.deleteTask(toDoList.tasks![index])
        fetchReq()
        toDoTable.reloadData()
    }
    
}


