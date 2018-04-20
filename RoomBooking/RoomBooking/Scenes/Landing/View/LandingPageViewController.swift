//
//  LandingPageViewController.swift
//  RoomBooking
//
//  Created by Onur Torna on 19/04/18.
//

import UIKit

class LandingPageViewController: UIViewController {

    var viewModel: LandingPageViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeViewModel()
        viewModel.fetchRooms(with: nil)
    }

    private func initializeViewModel() {

        viewModel = LandingPageViewModel(dataController: LandingPageDataController())
        viewModel.stateChangeHandler = { [weak self] change in
            self?.handleState(change)
        }
    }

    private func handleState(_ change: LandingPageState.Change) {
        // TODO: To be implemented
        switch change {
        case .loadingStateChanged(let isLoading):
            break
        case .roomsFetched(let roomList):
            break
        }
    }
}

