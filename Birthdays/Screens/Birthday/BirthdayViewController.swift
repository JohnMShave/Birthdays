//
//  BirthdayViewController.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import UIKit

class BirthdayViewController: UIViewController {
    var viewModel: BirthdayViewModel?
    
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            goBackTapped()
            return
        }
        
        self.initialsLabel.text = viewModel.initials
        self.nameLabel.text = viewModel.name
        self.ageLabel.text = viewModel.age
    }
    
    @IBAction func goBackTapped() {
        dismiss(animated: true, completion: nil)
    }
}

class BirthdayViewModel {
    let initials: String
    let name: String
    let age: String
    
    init(birthday: Birthday) {
        self.initials = birthday.initials
        self.name = birthday.fullName
        self.age = (birthday.age != nil) ? "\(birthday.age)" : "Unknown"
    }
}
