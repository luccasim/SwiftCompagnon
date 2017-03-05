//
//  ProjectsViewController.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 2/28/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {

    fileprivate let projects = (api42.shared.currentUser?.projects.projects)!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib.init(nibName: "ProjectCell", bundle: nil), forCellReuseIdentifier: "projectCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ProjectsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as? ProjectCell
        cell?.setup(WithProject: projects[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
}

extension ProjectsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
