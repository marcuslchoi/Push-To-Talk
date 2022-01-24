//
//  RecordingsTableVC.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import UIKit

class RecordingsTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recordings"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
}
