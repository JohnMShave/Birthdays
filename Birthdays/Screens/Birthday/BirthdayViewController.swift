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
    @IBOutlet weak var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            goBackTapped()
            return
        }

        initialsLabel.text = viewModel.initials
        nameLabel.text = viewModel.name
        ageLabel.text = viewModel.age
        
        applyStyling()
    }

    private func applyStyling() {
        initialsLabel.layer.cornerRadius = 50
        initialsLabel.clipsToBounds = true
        
        goBackButton.layer.cornerRadius = 6
        goBackButton.clipsToBounds = true
    }
    
    @IBAction func goBackTapped() {
        dismiss(animated: true, completion: nil)
    }
}
