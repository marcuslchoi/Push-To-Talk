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
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTextField(title: String, msg: String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let txt = alert.textFields?.first?.text { print(txt) }
        }
        alert.addTextField { textField in
            textField.placeholder = "placeholder"
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}