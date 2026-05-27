//
//  NetworkMonitor.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//


import Network
import Combine

class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()
    @Published var isConnected: Bool = true

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}