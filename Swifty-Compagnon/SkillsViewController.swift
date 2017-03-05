//
//  SkillsViewController.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 2/28/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController {

    fileprivate let skills = (api42.shared.currentUser?.skills)!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SkillsViewController : UITableViewDelegate {
}

extension SkillsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell")
        cell?.detailTextLabel?.text = String(skills.skills[indexPath.row].level)
        cell?.textLabel?.text = skills.skills[indexPath.row].name
        return cell!
    }
}
