//
//  CategoryCollectionViewCell.swift
//  Foody
//
//  Created by Ezgi  on 30.01.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLabel1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let blueView = UIView(frame: bounds)
        blueView.backgroundColor = .systemBlue
        self.selectedBackgroundView = blueView
    }
    
    func setup(with category: Category) {

        categoryImageView.backgroundColor = UIColor(named: "Color2")
        categoryImageView.layer.masksToBounds = true
        categoryImageView.layer.cornerRadius = categoryImageView.frame.height / 2

        categoryImageView.image = category.image
        titleLabel1.text = category.title

    }
}

