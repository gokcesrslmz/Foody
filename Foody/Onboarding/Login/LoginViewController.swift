//
//  LoginViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 05/01/2023.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var emailTextFld: UITextField!
    @IBOutlet weak var passwordTextFld: UITextField!
    @IBOutlet weak var loginBttn: UIButton!
    @IBOutlet weak var registerBttn: UIButton!
    
    var clickedRegisterCompletion:(() -> ())?
    let defaults: UserDefaults? = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            if ((defaults?.bool(forKey: "ISRemember")) != nil) {
                rememberMeSwitch.setOn(true, animated: false)
            }else {
                rememberMeSwitch.setOn(false, animated: false)
            }
        }
        rememberMeSwitch.addTarget(self, action: #selector(rememberMeSwitchChck), for: .valueChanged)
        emailTextFld.layer.cornerRadius = 20
        passwordTextFld.layer.cornerRadius = 20
        loginImageView.image = UIImage(named: "chicken")
        welcomeLbl.text = "Welcome"
        loginLbl.text =  "Login your account"
        loginBttn.layer.cornerRadius = 15
        registerBttn.layer.cornerRadius = 15
    }
   
   
    @IBAction func rememberMeSwitchChck(_ sender: UISwitch) {
            if sender.isOn {
                defaults?.set(true, forKey: "ISRemember")
            }else {
                defaults?.set(false, forKey: "ISRemember")
            }
        }
    
    @IBAction func loginBttnClicked(_ sender: Any) {
        guard let email = emailTextFld.text else { return }
        guard let password = passwordTextFld.text else { return }
        
        if email.isEmpty || password.isEmpty {
            errorMessage(titleInput: "Warning!", messageInput: "Please, fill the all blank field!")
        }else if email != "" && password != ""{
            if !email.isValidEmail(email: email){
                errorMessage(titleInput: "Please enter valid email!", messageInput: "Email must be in the format abc@abc.com")
            }else if !password.isValidPassword(password: password){
                errorMessage(titleInput: "Please enter valid password!", messageInput: "Password must be at least 6 characters and contain at least one capital letter")
            }
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil{
                    self.errorMessage(titleInput: "Warning!", messageInput: "Try again.")
                }else{
                    self.errorMessage(titleInput: "Welcome!", messageInput: "Success Login")
                }
            }
        }
    }

    private func errorMessage(titleInput:String, messageInput:String){
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
       }
         
    @IBAction func clickedRegister(_ sender: Any) {
        clickedRegisterCompletion?()
    }
    
}

extension String {
        func isValidEmail(email:String) -> Bool {
             let emailRegex = "[a-zA-Z0-9.%-]+@[a-zA-Z0-9-]+.[a-zA-Z]{2,4}"
             let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
             let result = emailTest.evaluate(with: email)
             return result
         }

         func isValidPassword(password:String) -> Bool {
             let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)[A-Z\\d]{6,}$" // Minimum 6 characters at least 1 uppercase letter and 1 Number
             let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
             let result = passwordTest.evaluate(with:password)
             return result
         }
 }
