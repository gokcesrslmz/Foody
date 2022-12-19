//
//  Coordinator.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 19/12/2022.
//

import UIKit

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
        navigationController.pushViewController(viewController, animated: true)
    }
}
