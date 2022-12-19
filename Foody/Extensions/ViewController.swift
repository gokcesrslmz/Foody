//
//  ViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 19/12/2022.
//

import UIKit

extension UIViewController {
    static func create() -> Self {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: className, bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("couldn't load \(className) as \(type(of: self))")
        }

        return vc
    }
}
