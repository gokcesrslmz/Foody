//
//  String.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 25/01/2023.
//
import Foundation

extension String {
    func isValidEmail(email:String) -> Bool {
        let emailRegex = "[a-zA-Z0-9.%-]+@[a-zA-Z0-9-]+.[a-zA-Z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    func isValidPassword(password:String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with:password)
        return result
    }
}
