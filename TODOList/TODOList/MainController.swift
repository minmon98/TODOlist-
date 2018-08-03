//
//  MainController.swift
//  TODOList
//
//  Created by Minh Mon on 7/18/18.
//  Copyright © 2018 Minh Mon. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Data models
    
    let TODO = 0
    let DONE = 1
    let sections = ["TODO", "Done"]
    var tasks = [
        ["Task 1", "Task 2", "Task 3"],
        ["Task 4", "Task 5"]
    ]
    
    let imgTODO = UIImage.init(named: "checked.png")
    let imgDONE = UIImage.init(named: "done.png")
    
    // MARK: UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: UI Events
    @IBAction func btnAdd_Pressed(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "New task", message: "Add new task", preferredStyle: .alert)
        let saveAction = UIAlertAction.init(title: "Save", style: .default) {
            UIAlertAction in
            let task = alert.textFields?.first?.text
            
            self.tasks[self.TODO].append(task!)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellID", for: indexPath) as! TableCell
        
        cell.lblWork.text = tasks[indexPath.section][indexPath.row]
        
        if (indexPath.section == TODO) {
            cell.btnDone.setBackgroundImage(imgTODO, for: .normal)
        } else {
            cell.btnDone.setBackgroundImage(imgDONE, for: .normal)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == TODO
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tasks[TODO].remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
}

