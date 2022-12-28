//
//  SecondViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 19/12/2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButtonClicked: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLabel.text = "No matter what I cook!"
        firstLabel.font = UIFont(name: "Georgia",size: 25)
        
        secondLabel.text = "Delicious new recipes everyday.!"
        secondLabel.font = UIFont(name: "Georgia",size: 18)
        
        startButtonClicked.layer.cornerRadius = 10.0
        
        imageView.image = UIImage(named: "second-onboarding")
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        
        print("buttona tıklandı")
    }
    
}
