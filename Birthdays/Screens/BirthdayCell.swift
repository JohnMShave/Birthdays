//
//  BirthdayCell.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import UIKit

class BirthdayCell: UITableViewCell {
    @IBOutlet private weak var initialsLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateOfBirthLabel: UILabel!
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    func configure(initials: String, name: String, dateOfBirth: Date?) {
        initialsLabel.text = initials
        initialsLabel.layer.cornerRadius = initialsLabel.frame.height / 2
        initialsLabel.clipsToBounds = true
        nameLabel.text = name
        if let dateOfBirth = dateOfBirth {
            dateOfBirthLabel.text = dateFormatter.string(from: dateOfBirth)
        } else {
            dateOfBirthLabel.text = "Uknown"
        }
    }
}
