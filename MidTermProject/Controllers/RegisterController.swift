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
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromFile()
    }
    
    private func loadDataFromFile() {
        do {
            let data = try Data(contentsOf: getFilePath())
            users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func getFilePath() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls[0].appendingPathComponent("Users.json")
        return url
        
        
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
        
}
    
    @IBAction func signupTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            return
        }
        
        if users.contains(where: { $0.email.lowercased() == email.lowercased() }) {
            let alert = UIAlertController(title: "Error", message: "This user already exists", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive)
            alert.addAction(action)
            present(alert, animated: true)
                return
            }
        
        let user = User(name: name, email: email, password: password)
        users.append(user)
        saveData()
        
        if let loginVC = navigationController?.viewControllers.first(where: { $0 is LoginController }) as? LoginController {
            loginVC.fillFields(email: email, password: password)
        }
        navigationController?.popViewController(animated: true)


    }
    

}
