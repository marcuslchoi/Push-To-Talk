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
        registerTableViewCells()
    }
    
    func registerTableViewCells()
    {
        let cell = UINib(nibName: "RecordingCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "RecordingCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let localFilenames = RecordingManager.shared.getLocalFileNames() else { return 0 }
        return localFilenames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordingCell", for: indexPath) as! RecordingCell
        guard let localFilenames = RecordingManager.shared.getLocalFileNames() else { return cell }
        cell.lblName.text = localFilenames[indexPath.row]
        return cell
    }
}
