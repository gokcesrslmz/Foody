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
        
        rememberMeSwitch.addTarget(self, action: #selector(self.stateChanged), for: .valueChanged)
                let defaults: UserDefaults = UserDefaults.standard
                if defaults.bool(forKey: "ISRemember") {
                    emailTextFld.text = defaults.value(forKey: "SavedUserEmail") as! String
                    passwordTextFld.text = defaults.value(forKey: "SavedPassword") as! String
                    rememberMeSwitch.setOn(true, animated: false)
                    print("already logged user")
                }
                else {
                    rememberMeSwitch
                        .setOn(false, animated: false)
                }
        
        loginImageView.image = UIImage(named: "chicken")
        welcomeLbl.text = "Welcome"
        loginLbl.text =  "Login your account"
        emailTextFld.layer.cornerRadius = 25
        passwordTextFld.layer.cornerRadius = 25
        loginBttn.layer.cornerRadius = 15
        registerBttn.layer.cornerRadius = 15
    }
   
    @objc func stateChanged(_ switchState: UISwitch) {
           let defaults: UserDefaults? = UserDefaults.standard
        if switchState.isOn {
               defaults?.set(true, forKey: "ISRemember")
               defaults?.set(emailTextFld.text, forKey: "SavedUserEmail")
               defaults?.set(passwordTextFld.text, forKey: "SavedPassword")
           }
           else {
               defaults?.set(false, forKey: "ISRemember")
               }
               }
    @IBAction func rememberMeSwitchChck(_ sender: Any) {

            }
    @IBAction func loginBttnClicked(_ sender: Any) {
        if emailTextFld.text != "" && passwordTextFld.text != "" {
                   Auth.auth().signIn(withEmail: emailTextFld.text!, password: passwordTextFld.text!){
                   (authdataresult, error) in
                       if error != nil{
                           self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try again.")
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
//extension String {
//
//     func isValidEmail(email:String) -> Bool {
//
//         let emailRegex = "[a-zA-Z0-9.%-]+@[a-zA-Z0-9-]+.[a-zA-Z]{2,4}"
//         let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//         let result = emailTest.evaluate(with: email)
//         return result
//     }
//
//     func isValidPassword(password:String) -> Bool {
//
//         let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,10}$"// Minimum 6 maximum 10 characters at least 1 Alphabet and 1 Number
//         let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
//         let result = passwordTest.evaluate(with:password)
//         return result
//     }
// }
