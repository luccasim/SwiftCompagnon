//
//  ProfileViewController.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 2/28/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var loginLabel: UILabel!{
        didSet{
            loginLabel.text = user.profile.login
        }
    }
    @IBOutlet weak var walletLabel: UILabel!{
        didSet{
            walletLabel.text = "Wallet : \(user.profile.wallet)"
        }
    }
    @IBOutlet weak var correctionLabel: UILabel!{
        didSet{
            correctionLabel.text = "Correction : \(user.profile.correctionPoint)"
        }
    }
    @IBOutlet weak var levelLabel: UILabel!{
        didSet{
            levelLabel.text = "\(user.profile.level)"
        }
    }
    @IBOutlet weak var progressBar: UIProgressView!{
        didSet{
            let number = user.profile.level.truncatingRemainder(dividingBy: 1)
            progressBar.progress = Float(number)
            progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        }
    }
    @IBOutlet weak var firstNameLabel: UILabel!{
        didSet{
            firstNameLabel.text = "FirstName: \(user.profile.firstName)"
        }
    }
    @IBOutlet weak var lastNameLabel: UILabel!{
        didSet{
            lastNameLabel.text = "LastName: \(user.profile.lastName)"
        }
    }
    @IBOutlet weak var phoneLabel: UILabel!{
        didSet{
            phoneLabel.text = "Phone: \(user.profile.phone)"
        }
    }
    @IBOutlet weak var mailLabel: UILabel!{
        didSet{
            mailLabel.text = "Email: \(user.profile.mail)"
        }
    }

    fileprivate var user : User = api42.shared.currentUser!
    
    private func getImage(){
        if let img = user.image {
            self.imageView.image = img
        }
        else {
            if let url = URL(string: user.profile.imageUrl) {
                let qos = DispatchQoS.background.qosClass
                let queue = DispatchQueue.global(qos: qos)
                queue.async {
                    if let data = try? Data.init(contentsOf: url){
                        let img = UIImage.init(data: data)
                        DispatchQueue.main.async {
                            self.user.image = img
                            self.imageView.image = img
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
