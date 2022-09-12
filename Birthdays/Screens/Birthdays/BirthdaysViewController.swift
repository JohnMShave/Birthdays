//
//  ViewController.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import UIKit

class BirthdaysViewController: UIViewController {
    
    var viewModel = BirthdaysViewModel()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchBirthdays { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.tableView.reloadData()
                case .failure(let error):
                    var errorMessage: String
                    switch error {
                    case .badURL:
                        errorMessage = "Bad url"
                    case .invalidDataReturned:
                        errorMessage = "Bad data returned"
                    }
                    let alert = UIAlertController(title: "Network error", message: errorMessage, preferredStyle: .alert)
                    let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(actionOk)
                    
                    self?.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
}

extension BirthdaysViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "BirthdayViewController") as! BirthdayViewController
        viewController.viewModel = BirthdayViewModel(birthday: viewModel.birthdays[indexPath.row])
        present(viewController, animated: true, completion: nil)
    }
}

extension BirthdaysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.birthdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = viewModel.birthdays[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell") as? BirthdayCell else {
            return UITableViewCell()
        }
        cell.configure(initials: person.initials, name: person.fullName, dateOfBirth: person.dateOfBirth)
        return cell
    }
}
