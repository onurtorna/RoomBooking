//
//  AvailableHoursListView.swift
//  RoomBooking
//
//  Created by Onur Torna on 02/05/18.
//

import UIKit

class AvailableHoursListView: UIView {

    var stackView: UIStackView!

    init(frame: CGRect, hourCount: Int, availableHourList: [Int: [Bool]]) {
        super.init(frame: frame)

        stackView = UIStackView.init(frame: frame)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        for index in Global.bookingStartHour..<(hourCount + Global.bookingStartHour) {
            let availableHourView = AvailableHourView.loadFromNib()

            availableHourView.customizeViews(availableList: availableHourList[index],
                                             hourText: "\(index)")
            stackView.addArrangedSubview(availableHourView)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        embed(childView: stackView, constant: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
