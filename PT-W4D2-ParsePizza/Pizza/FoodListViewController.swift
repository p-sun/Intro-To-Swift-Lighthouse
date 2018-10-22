//
//  SecondViewController.swift
//  Pizza
//
//  Created by Curtis Mak on 2017-11-18.
//  Copyright © 2017 Curtis Mak. All rights reserved.
//

import UIKit
import Parse

class FoodListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var dataSet = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup PFQuery and "findObjects"
        
        let query = PFQuery(className: "Food")
//        query.whereKey("name", equalTo: "Tacos")
        query.findObjectsInBackground { (list, error) in
			
			guard let list = list else {
				print("Could not query food list. Error \(String(describing: error))")
				return
			}
			
            self.dataSet = list
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PizzaTableViewCell
        
        // Get PFObject and set values
        
        let pfObj = self.dataSet[indexPath.row]
        
        cell.nameLabel.text = pfObj["name"] as? String
        cell.descriptionLabel.text = pfObj["description"] as? String
        
        let pfFile = pfObj["image"] as? PFFile
        pfFile?.getDataInBackground(block: { (data, error) in
            
            let image = UIImage(data: data!)
            cell.foodImageView.image = image
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

