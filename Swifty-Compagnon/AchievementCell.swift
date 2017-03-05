//
//  AchievementCell.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 3/1/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class AchievementCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.numberOfLines = 0
        }
    }
    
    func setup(WithAchievement ach: Achievement)
    {
        nameLabel.text = ach.name
        descriptionLabel.text = ach.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
