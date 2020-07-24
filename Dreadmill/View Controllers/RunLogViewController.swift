//
//  RunLogViewController.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 23/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class RunLogViewController: InitialViewController {

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension RunLogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmController.getAllRuns()?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.logCell, for: indexPath) as? LogTableViewCell,
            let runs = realmController.getAllRuns() else { return UITableViewCell() }

        let run = runs[indexPath.row]
        cell.run = run
        return cell
    }
}

extension RunLogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let runs = realmController.getAllRuns() else { return }
            let run = runs[indexPath.row]
            realmController.delete(run: run)
            tableView.reloadData()
        }
    }
}
