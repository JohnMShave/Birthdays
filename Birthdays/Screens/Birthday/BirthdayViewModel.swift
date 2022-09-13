//
//  BirthdayViewModel.swift
//  Birthdays
//
//  Created by John Shave on 13/09/2022.
//

import Foundation

class BirthdayViewModel {
    let initials: String
    let name: String
    let age: String
    
    init(birthday: Birthday) {
        self.initials = birthday.initials
        self.name = birthday.fullName
        self.age = (birthday.age != nil) ? "\(String(describing: birthday.age))" : "Unknown"
    }
}
