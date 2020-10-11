//
//  TableViewController.swift
//  testing-SwiftyJSON
//
//  Created by Павел Кузин on 11.10.2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var titles : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalJSONCasting()
    }
    
    //MARK: Normal data casting
    func normalJSONCasting() {
        AF.request("https://codewithchris.com/code/afsample.json", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.titles.append(json["firstkey"].stringValue)
                for str in json["secondkey"].arrayValue {
                    self.titles.append(str.stringValue)
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = titles[indexPath.row]
        cell?.textLabel?.textColor = .black
        
        return cell!
    }
}
