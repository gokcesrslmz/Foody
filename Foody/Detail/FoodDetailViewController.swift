//
//  FoodDetailViewController.swift
//  Foody
//
//  Created by Gökçe Sarsılmaz on 25/01/2023.
//

import UIKit

class FoodDetailViewController: UIViewController {
    private let dataSource : [String] = ["onion", "olive oil", "garlic", "mushrooms", "tomate", "parmesan", "spagetti", "salt"]
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealRecipeLabel: UILabel!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealNameLabel.text = "Spaghetti"
        mealRecipeLabel.text = "Put the onion and oil in a large pan and fry over a fairly high heat for 3-4 mins. Add the garlic and mince and fry until they both brown. Add the mushrooms and herbs, and cook for another couple of mins. "
        imageView.image = UIImage(named: "spaghetti")
        youtubeButton.addTarget(self, action: #selector(openYoutubeLink), for: .touchUpInside)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction private func openYoutubeLink(_ sender: Any) {
        if let urlToOpen = URL(string: "https://www.youtube.com/watch?v=jBoMTZIHqLc"){
            UIApplication.shared.open(urlToOpen)
        }
    }
}

extension FoodDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientCell", for: indexPath) as! FoodDetailCollectionViewCell
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 30.0)
    }
    
}
