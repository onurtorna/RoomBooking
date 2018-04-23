//
//  LandingPageViewModel.swift
//  RoomBooking
//
//  Created by Onur Torna on 20/04/18.
//

import Foundation

class LandingPageState {

    enum Change {
        case loadingStateChanged(Bool)
        case roomsFetched
    }

    var onChange: ((LandingPageState.Change) -> Void)?

    var isLoading = false {
        didSet { onChange?(.loadingStateChanged(isLoading)) }
    }

    var roomList: [Room]? {
        didSet { onChange?(.roomsFetched) }
    }
    
}

final class LandingPageViewModel {

    private enum Constants {
        static let defaultDateString = "now"
    }

    private let dataController: LandingPageDataProvider

    // Current state of the view model
    private var state = LandingPageState()

    /// Handles the state for the sake of seperation between state and view controller
    var stateChangeHandler: ((LandingPageState.Change) -> Void)? {
        get {
            return state.onChange
        }
        set {
            state.onChange = newValue
        }
    }

    /// Returns total number of rooms
    var roomCount: Int {
        return state.roomList?.count ?? 0
    }

    init(dataController: LandingPageDataProvider) {
        self.dataController = dataController
    }

    /// Returns room at given index if possible
    func room(at index: Int) -> Room? {
        guard let roomList = state.roomList,
            roomCount > index
            else {
                return nil
        }

        return roomList[index]
    }
}

// MARK: - Network
extension LandingPageViewModel {

    /// Fetches rooms with given parameters
    ///
    /// - Parameters:
    ///   - date: Date
    ///   - dateString: String representation of a date. Can be now, and today
    func fetchRooms(with date: Date?,
                    dateString: String? = Constants.defaultDateString) {

        state.isLoading = true
        dataController.getRoomList(
            with: date,
            stringDate: dateString) { [weak self] (response, error) in

                guard let strongSelf = self else { return }
                strongSelf.state.isLoading = false
                strongSelf.state.roomList = response?.roomList
        }
    }
}
