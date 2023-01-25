//
//  Coordinator.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 19/12/2022.
//

import UIKit
import FirebaseAuth

final class Coordinator {
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startFirstView() {
        let viewController = FirstViewController.create()
        viewController.nextButtonCompletion = {
            self.showSecondView()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showSecondView() {
        let viewController = SecondViewController.create()
        viewController.startButtonCompletion = {
            self.showLoginView()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showLoginView() {
        if Auth.auth().currentUser != nil, UserDefaults.standard.bool(forKey: "ISRemember"){
            showHomePage()
            return
        }
        
        let viewController = LoginViewController.create()
        viewController.clickedRegisterCompletion = {
            self.showRegisterView()
        }
        viewController.loginSuccessful = {
            self.showHomePage()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showRegisterView() {
        let viewController = RegisterViewController.create()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showHomePage() {
        let viewController = HomeViewController.create()
        viewController.goToDetail = {
            self.showDetailPage()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showDetailPage() {
        let viewController = FoodDetailViewController.create()
        navigationController.pushViewController(viewController, animated: true)
    }
}
