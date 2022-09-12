//
//  Person.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import Foundation

struct Person {
    let firstName: String?
    let lastName: String?
    let dateOfBirth: Date?
    let age: Int?
    
    var fullName: String {
        var fullName: String = ""
        if let firstName = firstName {
            fullName += firstName + " "
        }
        if let lastName = lastName {
            fullName += lastName
        }
        return fullName
    }

    var initials: String {
        var initials: String = ""
        if let firstInitial = firstName.firstCharAsString {
            initials += firstInitial + " "
        }
        if let lastInitial = lastName.firstCharAsString {
            initials += lastInitial
        }
        return initials
    }
}

extension Optional where Wrapped == String {
    var firstCharAsString: String? {
        guard let self = self else { return nil }
        return String(self[self.startIndex])
    }
}
