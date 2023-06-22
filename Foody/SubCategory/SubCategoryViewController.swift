//
//  SubCategoryViewController.swift
//  Foody
//
//  Created by Merve Nurgül BAĞCI on 18.05.2023.
//

import UIKit

class SubCategoryViewController: UIViewController {
    
    @IBOutlet weak var mealListTableView: UITableView!
    
    var mealList = [SubCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealListTableView.dataSource = self
        mealListTableView.delegate = self
        mealListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchData()
    }
    
    func fetchData () {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            do {
                let mealResponse = try JSONDecoder().decode(Meals.self, from: data)
                self.mealList = mealResponse.meals
                
                DispatchQueue.main.async {
                    self.mealListTableView.reloadData() 
                }
            } catch {
                print("JSON decoding error: \(error)")
            }
        }
        task.resume()
    }
}

extension SubCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let meal = mealList[indexPath.row]
        cell.textLabel?.text = meal.idMeal
        return cell
    }
}




