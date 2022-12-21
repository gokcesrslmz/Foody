//
//  ViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 19/12/2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    var nextButtonCompletion:(() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        nextButtonCompletion?()
    }
    
    func new () {
        
    }
}

