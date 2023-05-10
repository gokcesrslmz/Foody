//
//  FoodDetailCollectionViewCell.swift
//  Foody
//
//  Created by Merve Nurgül BAĞCI on 26.01.2023.
//

import UIKit

class FoodDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    func configure(with ingredient: String){
        ingredientLabel.text = ingredient
    }
}
