//
//  LandingPageViewController.swift
//  RoomBooking
//
//  Created by Onur Torna on 19/04/18.
//

import UIKit

class LandingPageViewController: UIViewController {

    var viewModel: LandingPageViewModel!

    @IBOutlet private weak var filterHolderView: UIView!
    @IBOutlet private weak var tableView: UITableView!

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
        DispatchQueue.main.async {
            switch change {
            case .loadingStateChanged(let isLoading):
                break
            case .roomsFetched:
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension LandingPageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: To be implemented
        guard let room = viewModel.room(at: indexPath.row)
            else {
                return UITableViewCell()
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDataSource
extension LandingPageViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.roomCount
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: To be implemented
    }
}
