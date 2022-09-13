//
//  BirthdayProvider.swift
//  Birthdays
//
//  Created by John Shave on 13/09/2022.
//

import Foundation

protocol BirthdayProviding {
    func fetchBirthdays(_ completion: @escaping (Result<[ApiBirthday], NetworkError>) -> Void)
}

enum NetworkError: Error {
    case badURL
    case invalidDataReturned
}

class BirthdaysProvider: BirthdayProviding {
    func fetchBirthdays(_ completion: @escaping (Result<[ApiBirthday], NetworkError>) -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/?results=1000&seeed=chalkboard&inc=name,dob") else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidDataReturned))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let networkBirthdays: ApiBirthdays = try decoder.decode(ApiBirthdays.self, from: data)
                completion(.success(networkBirthdays.birthdays))
                return
            } catch {
                completion(.failure(.invalidDataReturned))
                return
            }
        }
        task.resume()
    }
}
