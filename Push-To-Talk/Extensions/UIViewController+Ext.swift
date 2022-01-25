//
//  UIViewController+Ext.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import UIKit

extension UIViewController {
    func showOkAlert(title: String, msg: String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertWithTextField(title: String, msg: String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                if let newName = alert.textFields?.first?.text {
                    if !newName.isEmpty {
                        RecordingManager.shared.renameFile(newName: newName)
                    }
                    else {
                        let dateStr = RecordingManager.shared.getCurrentDateString()
                        RecordingManager.shared.renameFile(newName: dateStr)
                    }
                }
            }
            alert.addTextField { textField in
                textField.placeholder = "input recording name..."
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
