//
//  BirthdaysViewModel.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import Foundation

class BirthdaysViewModel {
    private(set) var persons: [Birthday]
    
    init() {
        let person = Birthday(firstName: "John", lastName: "Shave", dateOfBirth: Date(), age: 20)
        persons = Array<Birthday>(repeating: person, count: 300)
    }
    
//    func fetch(first)
}
