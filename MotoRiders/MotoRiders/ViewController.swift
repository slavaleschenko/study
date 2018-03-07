//
//  ViewController.swift
//  MotoRiders
//
//  Created by Admin on 02.03.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var riders = [RidersStats]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        downloadJSONData { riders in
            self.riders = riders
            self.tableView.reloadData()
            print("Successful")
            print(self.riders.count)
        }
        
        tableView.dataSource = self
        tableView.rowHeight = 103
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RidersCell") as? RidersCell else {return UITableViewCell()}
        cell.nameLabel.text = riders[indexPath.row].name
        cell.teamLabel.text = riders[indexPath.row].team
        cell.bikeAndNumberLabel.text = riders[indexPath.row].bike! + ", " + "rider number is " + riders[indexPath.row].number!
        return cell
    }

    func downloadJSONData(completed: @escaping ([RidersStats]) -> ()) {
        let url = URL(string: "https://s3.eu-west-2.amazonaws.com/motogpriders/riders.json")

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let result = try [JSONDecoder().decode(ItemsStats.self, from: data!)]
                    DispatchQueue.main.async {
                        completed(result.first?.items ?? [])
                    }
                } catch {
                    print("JSON ERROR")
                }
            }
        }.resume()
    }
}

