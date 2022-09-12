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
    }
}

extension BirthdaysViewController: UITableViewDelegate {
    
}

extension BirthdaysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = viewModel.persons[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell") as? BirthdayCell else {
            return UITableViewCell()
        }
        cell.configure(initials: person.initials, name: person.fullName, dateOfBirth: person.dateOfBirth)
        return cell
    }
}
