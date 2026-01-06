//
//  LoginController.swift
//  MidTermProject
//
//  Created by user on 02.01.26.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet private weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        emailTextField.text = UserDefaults.standard.string(forKey: "emailSaved")
        passwordTextField.text = UserDefaults.standard.string(forKey: "passwordSaved")
    }


    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let savedEmail = UserDefaults.standard.string(forKey: "emailSaved"),
              let savedPassword = UserDefaults.standard.string(forKey: "passwordSaved")
        else { return showAlert(message: "Please sign up first")}
        if email == savedEmail, password == savedPassword {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            if let windowScene =  UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = MainTabBarController()
            }
        } else {
            showAlert(message: "Wrong email or password")
        }
        
        
    }
    

    @IBAction func signupTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        navigationController?.show(vc, sender: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Login error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
