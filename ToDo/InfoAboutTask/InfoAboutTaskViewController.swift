//
//  infoAboutTaskViewController.swift
//  ToDo
//
//  Created by Евгений Петренко on 02.06.2021.
//

import UIKit

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
        titleOfTask.text = currentTask.title
        descriptionOfTask.text = currentTask.description
        dateToBeDone.setDate(currentTask.dateToBeDone!, animated: false)
        priorityStepper.maximumValue = 1
        priorityStepper.maximumValue = 10
        priorityStepper.value = Double(currentTask.priority ?? 0)
        priorityLabel.text = "\(Int(priorityStepper.value))"
        
    }
    @IBAction func changePriority(_ sender: Any) {
        priorityLabel.text = "\(Int(priorityStepper.value))"
    }
    
    @IBAction func editCurrentTask(_ sender: Any) {
        delegate?.updateTask(task: Task(title: titleOfTask.text,
                                        description: descriptionOfTask.text,
                                        priority: Int(priorityStepper.value),
                                        dateToBeDone: dateToBeDone.date))
        
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
