//
//  ViewController.swift
//  fire
//
//  Created by Артём Коротков on 04.09.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    let segue = "toTask"
    var ref: DatabaseReference!
    
    
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        warningLabel.alpha = 0
        Firebase.Auth.auth().addStateDidChangeListener({ [ weak self ] (auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segue)!, sender: nil)
            }
            
        })
       
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTF.text = ""
        passwordTF.text = ""
    }
    
    
    func displayWarningLabel(WithText text: String)  {
        warningLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [ weak self ] in
            self?.warningLabel.alpha = 1
        }) { [ weak self ] complete in
            self?.warningLabel.alpha = 0
        }
    }
    

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(WithText: "Information is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(WithText: "Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segue)!, sender: nil)
                return
            }
            
            self?.displayWarningLabel(WithText: "No such user")
        })
    }
    
    
    
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(WithText: "Information is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in

            guard error == nil, user != nil else {
                print(error!)
                return
            }
            
            let userRef = self?.ref.child((user?.user.uid)!)
            userRef?.setValue(["email": user?.user.email])
        })
    }
}

