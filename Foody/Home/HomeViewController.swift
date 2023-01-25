//
//  HomeViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 25/01/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var goToDetail:(() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func detailButtonClicked(_ sender: Any) {
        goToDetail?()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
