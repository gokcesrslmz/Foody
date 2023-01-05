//
//  ViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 19/12/2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    var nextButtonCompletion:(() -> ())?
    
    @IBOutlet weak var appNameLbl: UILabel!
    @IBOutlet weak var firstOnboardingImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        nextButtonCompletion?()
    }
    
    func setupView(){
        appNameLbl.text = "FOODY"
        descriptionLbl.text = "Discover Delicious Recipes"
        descLbl.text = "Easily find the best recipe you are looking for with all the details"
        firstOnboardingImg.image = UIImage(named: "first-onboarding")
        nextButton.layer.cornerRadius = 15
    }
}

