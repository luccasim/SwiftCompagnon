//
//  AchievementViewController.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 2/28/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController {

    fileprivate var data = (api42.shared.currentUser?.achievements.achievements)!
    
    @IBOutlet weak var collectionView: UICollectionView!
    {
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib.init(nibName: "AchievementCell", bundle: nil), forCellWithReuseIdentifier: "achievementCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool{
        return false
    }

}

extension AchievementViewController : UICollectionViewDelegate {
    
}

extension AchievementViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as? AchievementCell
        cell?.setup(WithAchievement: data[indexPath.row])
        return cell!
    }
}

extension AchievementViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 70)
    }
}
