//
//  RegisterViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 05/01/2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var signUpClicked: UIButton!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpClicked.layer.cornerRadius = 20.0
        
        usernameText.placeholder = "Username"
        emailText.placeholder = "Email"
        passwordText.placeholder = "Password"
        dateText.placeholder = "Date of Birth"
        
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        datePicker.maximumDate = Date()
        
        createDatePicker()
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateText.text = formatDate(date: datePicker.date)
    }
    
    func createDatePicker() {
        
      
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: true)
        dateText.inputAccessoryView = toolbar
        
        dateText.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    @objc func doneTapped () {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateText.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func formatDate(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    func dateDayCount(date:String,format:String = "dd/MM/yyyy") -> Int {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = format
        
        let calender = Calendar.current
        let firstDate = calender.startOfDay(for: dateFormatter.date(from: date)!)
        let twiceDate = calender.startOfDay(for: Date())
        let companents = calender.dateComponents([.year], from: firstDate, to: twiceDate)
        
        if companents.year! >= 15 {
            
            makeAlert(title: "Registration Successful.", message:"You are welcome. :)" )
            
            //Navigation
            
        }else {
            makeAlert(title: "Warning!", message: "Persons under the age of 15 cannot enter.")
        }
        return companents.year!
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        // email and password validation
        
        if let username = usernameText.text , let email = emailText.text , let password = passwordText.text {
            if username == "" && email == "" && password == "" {
                
                makeAlert(title: "Warning!", message: "Please Enter Username, Email and Password!" )
            }else {
                if !email.isValidEmail(email: email) {
                    makeAlert(title: "Warning!", message: "Please Enter Valid Email!")
                    
                }else if !password.isValidPassword(password: password){
                    makeAlert(title: "Warning!", message: "Please Enter Valid Password!")
                    
                }else {
                    
                    if emailText.text != "" && passwordText.text != "" && dateDayCount(date: dateText.text!) > 15 {
                        
                        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata,error) in
                            
                            if error != nil  {
                                self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                            }else {
                                
                                print("kullanici olustuldu.")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title:String, message:String) {
        
        let alert = UIAlertController(title:title,message:message,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
        
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,10}$"// Minimum 6 maximum 10 characters at least 1 Alphabet and 1 Number
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with:password)
        return result
    }
    
}


