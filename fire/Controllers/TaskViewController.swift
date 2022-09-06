//
//  TaskViewController.swift
//  fire
//
//  Created by Артём Коротков on 04.09.2022.
//

import UIKit
import Firebase

class TaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var user: User!
    var ref: DatabaseReference!
    var tasks = Array<Task>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = FirebaseAuth.Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks ")
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        let taskTitle = tasks[indexPath.row].title
        cell.textLabel?.text = taskTitle

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.observe(.value) { [ weak self ](snapshot) in
            var _tasks = Array<Task>()
            for item in snapshot.children {
                    let task = Task(snapshot: item as! Firebase.DataSnapshot)
                _tasks.append(task)
            }
            self?.tasks = _tasks
            self?.tableview.reloadData()
        }
    }
    
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New task", message: "Add new Task", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            let tasks = Task(title: textField.text!, userID: (self?.user.uid)!)
            let taskRef = self?.ref.child(tasks.title.lowercased())
            taskRef?.setValue(tasks.converToDic())
            
            
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController, animated: true)
        
    }
    
    }


