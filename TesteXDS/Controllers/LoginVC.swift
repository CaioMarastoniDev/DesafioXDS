//
//  LoginVC.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 17/06/21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let alertService = AlertService()
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.btnCorner()
        hideKeyboardWhenTappedAround()
        textfieldDelegates()
    }
    
    //MARK: - JsonRequest
    func jsonRequest(email:String, password: String) {
        
        let login = Login(email: email, password: password)
        
        networkingService.requestLogin(endpoint: "/signin", loginObject: login) { [weak self] (result) in
            
            switch result {
            case .success(let user): self?.performSegue(withIdentifier: "escolhaSegue", sender: user)
                
            case.failure(let error):
                
                guard let alert = self?.alertService.alert(message: error.localizedDescription) else { return }
                self?.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func didTapLoginButton() {
        
        guard
            let email = userEmailTextField.text,
            let password = passwordTextField.text
            else { return }
                
        jsonRequest(email: email, password: password)
    }
    
    func textfieldDelegates() {
        userEmailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}

extension UIViewController {

    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
