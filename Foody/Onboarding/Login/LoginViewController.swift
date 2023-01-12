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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            let defaults: UserDefaults = UserDefaults.standard
            if defaults.bool(forKey: "ISRemember") {
                rememberMeSwitch.setOn(true, animated: false)
                print("already logged user")
            }
            else {
                rememberMeSwitch.setOn(false, animated: false)
            }
        }
        rememberMeSwitch.addTarget(self, action: #selector(self.rememberMeSwitchChck(_:)), for: .valueChanged)
  
        emailTextFld.layer.cornerRadius = 20
        passwordTextFld.layer.cornerRadius = 20
        loginImageView.image = UIImage(named: "chicken")
        welcomeLbl.text = "Welcome"
        loginLbl.text =  "Login your account"
        loginBttn.layer.cornerRadius = 15
        registerBttn.layer.cornerRadius = 15
    }
   
   
    @IBAction func rememberMeSwitchChck(_ sender: UISwitch) {
        let defaults: UserDefaults? = UserDefaults.standard
        if sender.isOn {
            defaults?.set(true, forKey: "ISRemember")
            print("switch is on")
            }
            else {
                defaults?.set(false, forKey: "ISRemember")
                print("switch is off")
            }
        }
    
    @IBAction func loginBttnClicked(_ sender: Any) {
        guard let email = emailTextFld.text else { return }
        guard let password = passwordTextFld.text else { return }
        if email != "" && password != "" {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                       if error != nil{
//                           self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try again.")
                           if !email.isValidEmail(email: email){
                               self.errorMessage(titleInput: "Error!", messageInput: "Please control the email")
                           }else if !password.isValidPassword(password: password){
                               self.errorMessage(titleInput: "Error!", messageInput: "Please control the password")
                           }
                       }else{
                           self.errorMessage(titleInput: "WELCOME!", messageInput: error?.localizedDescription ?? "Success Login.")
                           UserDefaults.standard.set(true, forKey: "REMEMBER_USER")
                           print("success login")
                       }
                   }
               }
        else{
                   errorMessage(titleInput: "Error!", messageInput: "Enter the username and password")
               }
           }
    
    func errorMessage(titleInput:String, messageInput:String){
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

    func isValidEmail(email: String) -> Bool {
         let emailRegex = "[a-zA-Z0-9.%-]+@[a-zA-Z0-9-]+.[a-zA-Z]{2,4}"
         let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
         let result = emailTest.evaluate(with: self)
         return result
     }

    func isValidPassword(password: String) -> Bool {
         let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,10}$"
         let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
         let result = passwordTest.evaluate(with: self)
         return result
     }
 }
