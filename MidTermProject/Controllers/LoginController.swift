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

//        emailTextField.text = UserDefaults.standard.string(forKey: "emailSaved")
//        passwordTextField.text = UserDefaults.standard.string(forKey: "passwordSaved")
    }


    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill all fields")
            return
        }
        
        let users = loadUsers()
        
        let isValid = users.contains {
            $0.email.lowercased() == email.lowercased() &&
            $0.password == password
        }
        
        if isValid {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
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
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    private func getFilePath() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls)
        return urls[0].appendingPathComponent("Users.json")
        
    }

    private func loadUsers() -> [User] {
        do {
            let data = try Data(contentsOf: getFilePath())
       
            return try JSONDecoder().decode([User].self, from: data)
        } catch {
            return []
        }
    }
    
     func fillFields(email: String, password: String) {
        emailTextField.text = email
        passwordTextField.text = password
    }

}
