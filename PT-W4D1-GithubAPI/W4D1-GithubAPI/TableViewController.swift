//
//  TableViewController.swift
//  W4D1-GithubAPI
//
//  Created by Paige Sun on 2018-10-15.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

	let reuseId = "cellReuseIdentifier"
	var repoNames = [String]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		print("---------------------- viewDidLoad() ----------------------")
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
		fetchGithubRepos()
    }

	// MARK: - Network
	
	private func fetchGithubRepos() {
		
		guard let url = URL(string: "https://api.github.com/users/mattt/repos") else {
			// Deal with url being nil here
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			//print("📔 Data: \(data) \n🚔 Response: \(response) \n🔥 Error: \(error)")
			
			guard let data = data, error == nil else {
				print("🚨 Did not get any data!")
				return
			}
			
			do {
				let jsonUnformatted = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
				
				guard let jsonArray = jsonUnformatted as? [[String: Any]] else {
					return
				}
				
				for jsonItem in jsonArray {
					if let name = jsonItem["name"] as? String {
						self.repoNames.append(name)
					}
				}
				
				print("---------------------- finished network call! ----------------------")
				
				DispatchQueue.main.async {
					print("---------------------- tableView.reloadData() ----------------------")
					self.tableView.reloadData()
				}
				
			} catch {
				print("🚨 Could not deserialize data to JSON \(error)")
			}
		}
		task.resume()
	}
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		print("--- UITableViewDelegate: numberOfSections = 1")
		
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("--- UITableViewDelegate: numberOfRowsInSection = \(repoNames.count)")
		
        return repoNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		print("--- UITableViewDelegate: cellForRowAt for section: \(indexPath.section), row: \(indexPath.row)")
		print("                            title = \(repoNames[indexPath.row])")
		
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
		cell.textLabel?.text = repoNames[indexPath.row]
        return cell
    }
}
