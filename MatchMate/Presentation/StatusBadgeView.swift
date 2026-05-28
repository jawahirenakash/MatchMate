import SwiftUI

struct StatusBadgeView: View {
    let status: MatchStatus

    var body: some View {
        Text(status == .accepted ? "Accepted" : "Declined")
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(status == .accepted ? Color.green : Color.red)
            .cornerRadius(10)
    }
}
