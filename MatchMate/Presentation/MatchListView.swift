import SwiftUI

struct MatchListView: View {
    @StateObject private var viewModel: MatchListViewModel

    init(viewModel: MatchListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                if viewModel.isLoading && viewModel.matches.isEmpty {
                    VStack {
                        Spacer()
                        ProgressView("Loading matches...")
                        Spacer()
                    }
                } else {
                    List {
                        if let error = viewModel.errorMessage {
                            Label(error, systemImage: "exclamationmark.triangle")
                                .font(.caption)
                                .foregroundColor(.red)
                                .listRowBackground(Color.red.opacity(0.1))
                        }

                        ForEach(viewModel.matches) { match in
                            MatchCardView(
                                match: match,
                                onAccept: { viewModel.accept(id: match.id) },
                                onDecline: { viewModel.decline(id: match.id) }
                            )
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .buttonStyle(.plain)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Profile Matches")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
