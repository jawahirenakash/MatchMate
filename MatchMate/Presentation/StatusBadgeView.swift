import SwiftUI

struct StatusBadgeView: View {
    let status: MatchStatus

    var body: some View {
        switch status {
        case .accepted:
            Label("Accepted", systemImage: "checkmark.circle.fill")
                .font(.caption.bold())
                .foregroundColor(.green)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.green.opacity(0.15))
                .clipShape(Capsule())
        case .declined:
            Label("Declined", systemImage: "xmark.circle.fill")
                .font(.caption.bold())
                .foregroundColor(.red)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.red.opacity(0.15))
                .clipShape(Capsule())
        case .pending:
            EmptyView()
        }
    }
}
