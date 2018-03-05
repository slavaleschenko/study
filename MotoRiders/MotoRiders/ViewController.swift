//
//  ViewController.swift
//  MotoRiders
//
//  Created by Admin on 02.03.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var riders = [GlobalStats]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        downloadJSONData {
            self.tableView.reloadData()
            print("Successful")
            print(self.riders[0].items.count)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riders[0].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = riders[0].items[indexPath.row].name?.capitalized
        return cell
    }

    func downloadJSONData(completed: @escaping () -> ()) {
        let url = URL(string: "https://s3.eu-west-2.amazonaws.com/motogpriders/riders.json")

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.riders = try [JSONDecoder().decode(GlobalStats.self, from: data!)]
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON ERROR")
                }
            }
        }.resume()
    }
}

