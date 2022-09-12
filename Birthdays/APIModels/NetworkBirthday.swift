//
//  NetworkBirthday.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import Foundation

struct ApiBirthdays: Codable {
    enum CodingKeys: String, CodingKey {
        case birthdays = "results"
    }
    let birthdays: [ApiBirthday]
}

struct ApiBirthday: Codable {
    var name: Name
    var dob: DateOfBirth
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }

    struct DateOfBirth: Codable {
        let date: String
        let age: Int
    }
}
