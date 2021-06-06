//
//  AddNewTaskViewController.swift
//  ToDo
//
//  Created by Евгений Петренко on 04.06.2021.
//

import UIKit
    
    class AddNewTaskViewController: UIViewController {
        weak var delegate: TransferedDelegate?
        
        @IBOutlet weak var datePicker: UIDatePicker!
        @IBOutlet weak var priorityLabel: UILabel!
        @IBOutlet weak var priorityStepper: UIStepper!
        @IBOutlet weak var titleOfTaskField: UITextField!
        @IBOutlet weak var descriptionOfTaskField: UITextField!
            
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            priorityStepper.value += 1
            priorityLabel.text = "Priority - \( Int(priorityStepper.value))"
        }
        
        @IBAction func stepperWorked(_ sender: Any) {
            priorityLabel.text = "Priority - \( Int(priorityStepper.value))"
        }
        
        @IBAction func addAndHideController(_ sender: Any) {
            let alert = UIAlertController(title: "Error", message: "You should input at least title.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click",
                                          style: .default,
                                          handler: nil))
            
            var priority = Int(priorityStepper.value)
            guard let title = titleOfTaskField.text,
                  let description = descriptionOfTaskField.text else {
                print("Wrong")
                return
            }
            
            guard title != "" else {
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            
            switch priority {
            case _ where  priority > 10:
                priority = 10
                break
            case _ where  priority < 1:
                priority = 1
            default:
                break
            }
            
            
            delegate?.addNew(title: title,
                             description: description,
                             date: datePicker.date,
                             priority: priority)
            self.dismiss(animated: true, completion: nil)
        }
        
    }


