//
//  ViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 19/12/2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    var nextButtonCompletion:(() -> ())?
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = view.frame.size.width
        let height = view.frame.size.height
    
        nextButton.frame = CGRect(x: width * 0.2, y: height * 0.85, width: width * 0.6, height: 50)
        nextButton.setTitle("Next", for: UIControl.State.normal)
        nextButton.backgroundColor = UIColor(named: "ThemeColor")
        nextButton.layer.cornerRadius = 12
        nextButton.titleLabel?.font = .systemFont(ofSize: 25)
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
       
        let appNameLbl = UILabel(frame : CGRect (x: width * 0.2, y: 150, width: 250, height: 100))
        appNameLbl.text = "FOODY"
        appNameLbl.font = UIFont.boldSystemFont(ofSize: 70.0)
        appNameLbl.font = UIFont(name: "Georgia", size: 70.0)
        appNameLbl.textAlignment = .center
        appNameLbl.textColor = UIColor(named: "ThemeColor")
        self.view.addSubview(appNameLbl)

        let detailLbl = UILabel(frame : CGRect (x: width * 0.07, y: 650, width: 350, height: 100))
        detailLbl.text = "Discover delicious recipes"
        detailLbl.font = UIFont(name: "Georgia", size: 25.0)
        detailLbl.textAlignment = .center
//        detailLbl.font =  detailLbl.font.withSize(25)
        detailLbl.textColor = UIColor(named: "side-color")
        self.view.addSubview(detailLbl)
        
        let imageName = "first-onboarding"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 300, width: 400, height: 300)
        view.addSubview(imageView)
    }
    @objc func nextButtonClicked(){
        nextButtonCompletion?()
    }
}

