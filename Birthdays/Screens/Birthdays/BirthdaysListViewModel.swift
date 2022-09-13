//
//  BirthdaysViewModel.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import Foundation

class BirthdaysListViewModel {
    private(set) var birthdays: [Birthday] = []
        
    private let birthdayProvider: BirthdayProviding
    
    init(birthdayProvider: BirthdayProviding = BirthdaysProvider()) {
        self.birthdayProvider = birthdayProvider
    }
    
    func fetchBirthdays(_ completion: @escaping (Bool) -> Void) {
        birthdayProvider.fetchBirthdays { [weak self] result in
            switch result {
            case .success(let birthdays):
                let fetchedBirthdays = birthdays.compactMap { Birthday(apiBirthday: $0) }
                self?.birthdays.append(contentsOf: fetchedBirthdays)
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}

private extension Birthday {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()

    init?(apiBirthday: ApiBirthday) {
        guard let dob = Self.dateFormatter.date(from: apiBirthday.dob.date) else {
            return nil
        }
        let firstName = apiBirthday.name.first.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = apiBirthday.name.last.trimmingCharacters(in: .whitespacesAndNewlines)
        guard (firstName.isEmpty == false || lastName.isEmpty == false) else {
            return nil
        }
        self.init(firstName: firstName, lastName: lastName, dateOfBirth: dob, age: apiBirthday.dob.age)
    }
}
