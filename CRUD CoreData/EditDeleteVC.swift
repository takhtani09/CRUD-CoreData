//
//  EditDeleteVC.swift
//  CRUD CoreData
//
//  Created by IPS-108 on 16/06/23.
//

import UIKit
import CoreData

class EditDeleteVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!

    var selectedStudent: Student?
    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the managed object context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext

        updateUI()
    }

    func updateUI() {
        guard let student = selectedStudent else {
            return
        }

        txtName.text = student.name
        txtAge.text = "\(student.age)"
    }

    @IBAction func btnEdit(_ sender: UIButton) {
        guard let student = selectedStudent else {
            return
        }

        // Update the student data
        student.name = txtName.text
        if let ageString = txtAge.text, let age = Int16(ageString) {
            student.age = age
        }

        do {
            try managedObjectContext.save()
            print("updated successfully.")
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to update data: \(error.localizedDescription)")
        }
    }

    @IBAction func btnDelete(_ sender: UIButton) {
        guard let student = selectedStudent else {
            return
        }

        // Delete the student from Core Data
        managedObjectContext.delete(student)

        do {
            try managedObjectContext.save()
            print("deleted successfully.")

            


            self.navigationController?.popViewController(animated: true)
            
        } catch {
            print("delete student: \(error.localizedDescription)")
        }
    }
}

