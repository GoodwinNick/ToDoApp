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
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            titleOfTaskField.layer.borderWidth = 1
            titleOfTaskField.layer.borderColor = UIColor.gray.cgColor
            
            descriptionOfTaskField.layer.borderWidth = 1
            descriptionOfTaskField.layer.borderColor = UIColor.gray.cgColor
            
            
            priorityStepper.value += 1
            priorityLabel.text = "Priority - \( Int(priorityStepper.value))"
        }
        
        // MARK: hide keyboard
        override func touchesEnded(_ touches: Set<UITouch>,
                                   with event: UIEvent?) {
            view.endEditing(true)
        }
        
        // MARK: working of stepper
        @IBAction func stepperWorked(_ sender: Any) {
            priorityLabel.text = "Priority - \( Int(priorityStepper.value))"
        }
        
        // MARK: add task and hide controller
        @IBAction func addAndHideController(_ sender: Any) {
            
            let alert = UIAlertController(title: "Error",
                                          message: "You should input at least title.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Click",
                                          style: .default,
                                          handler: nil))
            
            var priority = Int(priorityStepper.value)
            
            guard let title       = titleOfTaskField.text,
                  let description = descriptionOfTaskField.text else {
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


