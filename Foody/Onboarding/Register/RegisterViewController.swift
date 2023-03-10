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
    @IBOutlet weak var passwordLabel: UILabel!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpClicked.layer.cornerRadius = 10.0
        
        usernameText.placeholder = "Username"
        emailText.placeholder = "Email"
        passwordText.placeholder = "Password"
        dateText.placeholder = "Date of Birth"
        passwordLabel.text = "Şifre en az 6 karakterli en az bir büyük harf ve bir rakam içermelidir."
        
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
        dateText.text = formatDate(date: datePicker.date)
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
        guard let date = dateFormatter.date(from: date) else{
            showAlert(title: "Warning!", message: "Children under the age of 15 are not allowed")
            return 0
        }
        
        let firstDate = calender.startOfDay(for: date)
        let twiceDate = calender.startOfDay(for: Date())
        let component = calender.dateComponents([.year], from: firstDate, to: twiceDate)
        
        if let year = component.year, year >= 15 {
            return year
        }else {
            showAlert(title: "Warning!", message: "Children under the age of 15 are not allowed")
        }
        return component.year ?? 0
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if let username = usernameText.text , let email = emailText.text , let password = passwordText.text , let dateOfBirth = dateText.text {
            if username.isEmpty && email.isEmpty && password.isEmpty && dateOfBirth.isEmpty {
                showAlert(title: "Warning!", message: "Please Enter Username, Email, Password and Date Of Birth!" )
                
            }else if !email.isValidEmail(email: email) {
                showAlert(title: "Warning!", message: "Please Enter Valid Email!")
                
            }else if !password.isValidPassword(password: password){
                showAlert(title: "Warning!", message: "Please Enter Valid Password!")
                
            }else if dateOfBirth.isEmpty {
                showAlert(title: "Warning!", message: "Please Enter Birth Of Date!")
                
            }else if usernameText.text != "" && emailText.text != "" && passwordText.text != "" && dateText.text != ""  {
                if dateDayCount(date: dateText.text ?? "") > 15 {
                    
                    Auth.auth().createUser(withEmail: (emailText.text ?? ""), password: (passwordText.text ?? "")) { (result, error) in
                        
                        if let error = error {
                            self.showAlert(title: "Warning!", message:"\(error.localizedDescription)")
                        }else  {
                            self.showAlert(title: "Registration Successful!", message: "" )
                        }
                    }
                }
            }
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title:title, message:message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
