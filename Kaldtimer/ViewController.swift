//
//  ViewController.swift
//  Kaldtimer
//
//  Created by Kyle Rohr on 12/7/21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    let viewModel = TimerViewModel()

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startStopButton: RoundButton!

    private var cancellables = [AnyCancellable]()

    override func viewDidLoad() {
        super.viewDidLoad()

        startStopButton.setTitle(Strings.start, for: .normal)
        startStopButton.addTarget(self, action: #selector(startStopTapped), for: .touchUpInside)

        setupViewModelBindings()

        viewModel.handleViewEvent(.viewDidLoad)
    }

    // MARK: - Setup

    private func setupViewModelBindings() {
        let timeCancellable = viewModel.$time.sink { [weak self] time in

            self?.timeLabel.text = "\(time.formattedString ?? "")"
        }
        cancellables.append(timeCancellable)

        let stateCancellable = viewModel.$state.sink { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .initial, .stopped:
                self.configureForStopped()
            case .running:
                self.configureForRunning()
            }
        }
        cancellables.append(stateCancellable)
    }

    // MARK: - Configuration

    private func configureForStopped() {
        startStopButton.setTitle(Strings.start, for: .normal)
    }

    private func configureForRunning() {
        startStopButton.setTitle(Strings.stop, for: .normal)
    }

    // MARK: - Actions

    @IBAction func startStopTapped() {
        viewModel.handleViewEvent(.startStopTapped)
    }

}

extension ViewController {

    struct Strings {
        static let start = NSLocalizedString("Start", comment: "")
        static let stop = NSLocalizedString("Stop", comment: "")
    }

}

extension TimeInterval {

    var formattedString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: self)
    }

}

