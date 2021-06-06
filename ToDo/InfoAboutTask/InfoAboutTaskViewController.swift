//
//  infoAboutTaskViewController.swift
//  ToDo
//
//  Created by Евгений Петренко on 02.06.2021.
//

import UIKit
import CoreData

class InfoAboutTaskViewController: UIViewController {
    
    weak var delegate: TransferedDelegate?
    
    
    @IBOutlet weak var titleOfTask: UITextView!
    
    @IBOutlet weak var descriptionOfTask: UITextView!
    
    @IBOutlet weak var dateToBeDone: UIDatePicker!
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    @IBOutlet weak var priorityStepper: UIStepper!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentTask = delegate?.getInfo() else {
            return
        }
        
        titleOfTask.text = currentTask.value(forKey: "titleOfTask") as? String
        descriptionOfTask.text = currentTask.value(forKey: "descriptionOfTask") as? String
        dateToBeDone.setDate(currentTask.value(forKey: "dateToBeDone") as! Date,
                             animated: false)
        priorityStepper.maximumValue = 1
        priorityStepper.maximumValue = 10
        
        let priority = currentTask.value(forKey: "priorityOfTask") as! Int
        priorityStepper.value = Double(priority)
        priorityLabel.text = "\(Int(priorityStepper.value))"
        
    }
    @IBAction func changePriority(_ sender: Any) {
        priorityLabel.text = "\(Int(priorityStepper.value))"
    }
    
    @IBAction func editCurrentTask(_ sender: Any) {
        delegate?.updateTask(title: titleOfTask.text,
                             description: descriptionOfTask.text,
                             date: dateToBeDone.date,
                             priority: Int(priorityStepper.value))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteCurrentTask(_ sender: Any) {
        delegate?.deleteTask()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeInfoTab(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
