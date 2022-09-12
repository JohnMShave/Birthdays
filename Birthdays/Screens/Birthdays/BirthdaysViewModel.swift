//
//  BirthdaysViewModel.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidDataReturned
}

class BirthdaysViewModel {
    private(set) var birthdays: [Birthday] = []
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
        
    func fetchBirthdays(_ completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/?results=100&seeed=chalkboard&inc=name,dob") else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data else {
                completion(.failure(.invalidDataReturned))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let networkBirthdays: ApiBirthdays = try decoder.decode(ApiBirthdays.self, from: data)
                let returnedBirthdays: [Birthday?] = networkBirthdays.birthdays.map { apiBirthday in
                    guard let dob = self.dateFormatter.date(from: apiBirthday.dob.date) else {
                        return nil
                    }
                    let firstName = apiBirthday.name.first.trimmingCharacters(in: .whitespacesAndNewlines)
                    let lastName = apiBirthday.name.last.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard (firstName.isEmpty == false || lastName.isEmpty == false) else {
                        return nil
                    }
                    return Birthday(firstName: firstName, lastName: lastName, dateOfBirth: dob, age: apiBirthday.dob.age)
                }
                self.birthdays.append(contentsOf: returnedBirthdays.compactMap { $0 })
                
                completion(.success(()))
                return
            } catch {
                completion(.failure(.invalidDataReturned))
                return
            }
        }
        task.resume()
    }
}
