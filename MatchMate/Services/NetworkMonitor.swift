//
//  NetworkMonitor.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Network
import Combine

protocol NetworkMonitoring: AnyObject {
    var isConnected: Bool { get }
    var isConnectedPublisher: AnyPublisher<Bool, Never> { get }
}

final class NetworkMonitor: NetworkMonitoring, ObservableObject {
    @Published var isConnected: Bool = true

    var isConnectedPublisher: AnyPublisher<Bool, Never> {
        $isConnected.eraseToAnyPublisher()
    }

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: APIConfig.Queue.networkMonitor)

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}