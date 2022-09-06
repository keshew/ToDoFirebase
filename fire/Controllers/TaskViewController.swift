//
//  TaskViewController.swift
//  fire
//
//  Created by Артём Коротков on 04.09.2022.
//

import UIKit
import Firebase

class TaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "HOHO #\(indexPath.row)"
        cell.textLabel?.textColor = .white
        return cell
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
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController, animated: true)
        
    }
    
    }


