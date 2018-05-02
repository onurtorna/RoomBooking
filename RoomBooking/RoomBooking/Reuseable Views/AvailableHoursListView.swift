//
//  AvailableHoursListView.swift
//  RoomBooking
//
//  Created by Onur Torna on 02/05/18.
//

import UIKit

class AvailableHoursListView: UIView {

    var stackView: UIStackView!

    init(frame: CGRect, hourCount: Int, availableHourList: [String]) {
        super.init(frame: frame)

        stackView = UIStackView.init(frame: frame)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        for _ in 0..<hourCount {
            let availableHourView = AvailableHourView.loadFromNib()
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
