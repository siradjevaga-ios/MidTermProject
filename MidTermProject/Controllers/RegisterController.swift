//
//  RegisterController.swift
//  MidTermProject
//
//  Created by user on 03.01.26.
//

import UIKit
class RegisterController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet private weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            return
        }
        UserDefaults.standard.set(name, forKey: "nameSaved")
        UserDefaults.standard.set(email, forKey: "emailSaved")
        UserDefaults.standard.set(password, forKey: "passwordSaved")
        navigationController?.popViewController(animated: true)

        
    }
    

}
