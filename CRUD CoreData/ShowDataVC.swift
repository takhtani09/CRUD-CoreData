//
//  ShowDataVC.swift
//  CRUD CoreData
//
//  Created by IPS-108 on 16/06/23.
//

import UIKit
import CoreData

class ShowDataVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!

    var managedObjectContext: NSManagedObjectContext!
    var students: [Student] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the managed object context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
    }

    func fetchData() {
        let fetchRequest = NSFetchRequest<Student>(entityName: "Student") 

        do {
            students = try managedObjectContext.fetch(fetchRequest)
            tblView.reloadData()

        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }
}

extension ShowDataVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowDataTBVC
        
        let student = students[indexPath.row]
        cell.txtName.text = student.name
        cell.txtAge.text = "\(student.age)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedStudent = students[indexPath.row]

        // Instantiate the EditDeleteVC from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editDeleteVC = storyboard.instantiateViewController(withIdentifier: "EditDeleteVC") as! EditDeleteVC

        // Pass the selected student object to the EditDeleteVC
        editDeleteVC.selectedStudent = selectedStudent

        navigationController?.pushViewController(editDeleteVC, animated: true)
    }
}
