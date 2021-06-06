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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let currentTask = delegate?.getInfo() else {
            return
        }
        
        titleOfTask.layer.borderWidth = 1
        titleOfTask.layer.borderColor = UIColor.gray.cgColor
        
        descriptionOfTask.layer.borderWidth = 1
        descriptionOfTask.layer.borderColor = UIColor.gray.cgColor
        
        titleOfTask.text = currentTask.value(forKey: "titleOfTask") as? String
        descriptionOfTask.text = currentTask.value(forKey: "descriptionOfTask") as? String
        dateToBeDone.setDate(currentTask.value(forKey: "dateToBeDone") as! Date,
                             animated: false)
                
        let priority = currentTask.value(forKey: "priorityOfTask") as! Int
        priorityStepper.value = Double(priority)
        priorityLabel.text = "\(Int(priorityStepper.value))"
        
    }
    
    // MARK: hide keyboard
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: change priority
    @IBAction func changePriority(_ sender: Any) {
        priorityLabel.text = "\(Int(priorityStepper.value))"
    }
    
    // MARK: edit current task
    @IBAction func editCurrentTask(_ sender: Any) {
        delegate?.updateTask(title: titleOfTask.text,
                             description: descriptionOfTask.text,
                             date: dateToBeDone.date,
                             priority: Int(priorityStepper.value))
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: delete current task
    @IBAction func deleteCurrentTask(_ sender: Any) {
        delegate?.deleteTask()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: close info tab
    @IBAction func closeInfoTab(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
