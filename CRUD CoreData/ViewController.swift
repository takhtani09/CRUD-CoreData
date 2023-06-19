//
//  ViewController.swift
//  CRUD CoreData
//
//  Created by IPS-108 on 16/06/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblAge: UITextField!
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }

    @IBAction func btnSave(_ sender: UIButton) {
        guard let name = lblName.text, !name.isEmpty else {
            print("Enter name")
            return
        }
        
        guard let ageString = lblAge.text, let age = Int(ageString) else {
            print("Enter valid age")
            return
        }

        // Create a new Person object and set its attributes
        let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: managedObjectContext) as! Student
        student.id = UUID()
        student.name = name
        student.age = Int16(age)
        
        // Save the changes to Core Data
        do {
            try managedObjectContext.save()
            print("Data saved .")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "ShowDataVC") as! ShowDataVC
            navigationController?.pushViewController(nextVC, animated: true)
            
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func showData(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "ShowDataVC") as! ShowDataVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

