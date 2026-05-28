//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by user295386 on 5/27/26.
//

import SwiftUI

@main
struct MatchMateApp: App {
    private let container = DIContainer()

    var body: some Scene {
        WindowGroup {
            MatchListView(viewModel: container.makeMatchListViewModel())
        }
    }
}
