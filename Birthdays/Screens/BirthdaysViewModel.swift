//
//  BirthdaysViewModel.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import Foundation

class BirthdaysViewModel {
    private(set) var persons: [Person]
    
    init() {
        let person = Person(firstName: "John", lastName: "Shave", dateOfBirth: Date(), age: 20)
        persons = Array<Person>(repeating: person, count: 300)
    }
}
