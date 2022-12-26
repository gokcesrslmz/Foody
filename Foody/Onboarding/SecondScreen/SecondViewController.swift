//
//  SecondViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 19/12/2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButtonTapped: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLabel.text = "No matter what I cook!"
        firstLabel.font = UIFont(name: "Georgia",size: 25)
        view.addSubview(firstLabel)
        
        secondLabel.text = "Delicious new recipes everyday.!"
        secondLabel.font = UIFont(name: "Georgia",size: 18)
        view.addSubview(secondLabel)
        
        startButtonTapped.layer.cornerRadius = 10.0
        
        imageView.image = UIImage(named: "second-onboarding")
        
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        print("BUTONA TIKLANDI.")
        
    }
}


