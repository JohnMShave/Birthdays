//
//  ViewController.swift
//  Birthdays
//
//  Created by John Shave on 12/09/2022.
//

import UIKit

class BirthdaysListViewController: UIViewController {
    
    var viewModel = BirthdaysListViewModel()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBirthdays()
    }
    
    private func fetchBirthdays() {
        viewModel.fetchBirthdays { [weak self] success in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                guard success else {
                    let alert = UIAlertController(title: "Network error", message: "Network Error", preferredStyle: .alert)
                    let actionRetry = UIAlertAction(
                        title: "Retry",
                        style: .default,
                        handler: { [weak self] _ in
                            self?.fetchBirthdays()
                        }
                    )
                    alert.addAction(actionRetry)

                    self.present(alert, animated: false, completion: nil)
                    return
                }
                
                self.tableView.reloadData()
            }
        }
    }
}

extension BirthdaysListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "BirthdayViewController") as! BirthdayViewController
        viewController.viewModel = BirthdayViewModel(birthday: viewModel.birthdays[indexPath.row])
        present(viewController, animated: true, completion: nil)
    }
}

extension BirthdaysListViewController: UITableViewDataSource {
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
