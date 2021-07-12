//
//  TimerViewModel.swift
//  Kaldtimer
//
//  Created by Kyle Rohr on 12/7/21.
//

import UIKit
import Combine

class TimerViewModel: ObservableObject {

    @Published private(set) var time: TimeInterval = 0
    @Published private(set) var state: State = .initial

    private var timerCancellable: Cancellable?

    init() {

    }

    // MARK: - View Events

    func handleViewEvent(_ event: ViewEvent) {
        switch event {
        case .viewDidLoad:
            break
        case .startStopTapped:
            handleStartStopTapped()
        }
    }

    private func handleStartStopTapped() {
        switch state {
        case .initial, .stopped:
            state = .running
            timerCancellable = Timer.publish(every: 1, on: .main, in: .default)
                .autoconnect()
                .sink(receiveValue: { [weak self] _ in
                    self?.time += 1
                })
            UIApplication.shared.isIdleTimerDisabled = true
        case .running:
            state = .stopped
            timerCancellable?.cancel()
            timerCancellable = nil
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }

}

extension TimerViewModel {

    enum State {
        case initial
        case stopped
        case running
    }

    enum ViewEvent {
        case viewDidLoad
        case startStopTapped
    }

}
