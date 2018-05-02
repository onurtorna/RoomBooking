//
//  AvailableHourView.swift
//  RoomBooking
//
//  Created by Onur Torna on 02/05/18.
//

import UIKit

class AvailableHourView: UIView, NibLoadable {

    @IBOutlet private weak var firstQuarterView: UIView!
    @IBOutlet private weak var secondQuarterView: UIView!
    @IBOutlet private weak var thirdQuarterView: UIView!
    @IBOutlet private weak var fourthQuarterView: UIView!

    @IBOutlet private weak var hourLabel: UILabel!

    var availableTimeIntervals: [Bool] = []
    private var timeIntervalViews: [UIView] = []

    override func awakeFromNib() {
        super.awakeFromNib()

        initializeViews()
    }

    /// Customizes subviews with available time interval list and hour text
    ///
    /// - Parameters:
    ///   - availableList: Un/AvailableTime intervals in a list
    ///   - hourText: Hour text
    func customizeViews(availableList: [Bool], hourText: String) {
        hourLabel.text = hourText
        setAvailableTimeIntervals(availableList: availableList)
    }
}

// MARK: - Helpers
extension AvailableHourView {

    private func initializeViews() {
        firstQuarterView.backgroundColor = UIColor.red
        secondQuarterView.backgroundColor = UIColor.red
        thirdQuarterView.backgroundColor = UIColor.green
        fourthQuarterView.backgroundColor = UIColor.red
        hourLabel.text = "11"
    }

    private func setAvailableTimeIntervals(availableList: [Bool]) {

        for i in 0..<availableList.count {

            if i < timeIntervalViews.count {
                timeIntervalViews[i].backgroundColor = availableList[i] ? UIColor.green : UIColor.red
            }
        }
    }
}
