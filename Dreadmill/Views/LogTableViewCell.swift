//
//  LogTableViewCell.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 24/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {

    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var paceLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    var run: Run? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let run = run else { return }

        let distance = run.distance.metresToMiles(places: 2).description
        durationLabel.text = run.duration.timeDurationToString()
        distanceLabel.text = "\(distance) miles"
        paceLabel.text = run.pace.timeDurationToString()
        dateLabel.text = run.date.getString()
    }
}
