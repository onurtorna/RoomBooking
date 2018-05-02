//
//  RoomTableViewCell.swift
//  RoomBooking
//
//  Created by Onur Torna on 23/04/18.
//

import UIKit

class RoomTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var roomExplanationLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet private weak var availableHoursContainerView: UIView!

    var availableHoursListView: AvailableHoursListView?

    func setAvailableHours(hourCount: Int, availableHoursList: [String]) {
        availableHoursListView = AvailableHoursListView(frame: availableHoursContainerView.frame,
                                                        hourCount: hourCount,
                                                        availableHourList: availableHoursList)
        availableHoursListView?.translatesAutoresizingMaskIntoConstraints = false
        if let availableHoursListView = availableHoursListView {
            availableHoursContainerView.addSubview(availableHoursListView)
        }
        availableHoursContainerView.embed(childView: availableHoursListView, constant: 0.0)

    }
}
