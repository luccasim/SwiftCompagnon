//
//  ProjectCell.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 3/1/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var slugLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var validatedLabel: UILabel!
    
    func setup(WithProject proj:Project)
    {
        slugLabel.text = proj.slug
        nameLabel.text = proj.name
        noteLabel.text = String(proj.note)
        if proj.validated {
            let str = "Success"
            let range = (str as NSString).range(of: str)
            let attributedString = NSMutableAttributedString(string: str)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: range)
            validatedLabel.attributedText = attributedString
        }
        else {
            let str = "Fail"
            let range = (str as NSString).range(of: str)
            let attributedString = NSMutableAttributedString(string: str)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: range)
            validatedLabel.attributedText = attributedString
        }
    }
}
