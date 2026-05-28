import SwiftUI
import SDWebImageSwiftUI

struct MatchCardView: View {
    let match: MatchProfile
    let onAccept: () -> Void
    let onDecline: () -> Void

    private var avatarURL: URL? {
        URL(string: "https://i.pravatar.cc/150?u=\(match.id)")
    }

    var body: some View {
        VStack(spacing: 12) {
            WebImage(url: avatarURL)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.teal, lineWidth: 2))

            Text(match.name)
                .font(.title3.weight(.bold))
                .foregroundColor(.teal)
                .multilineTextAlignment(.center)

            Text(match.city)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(match.company)
                .font(.caption)
                .foregroundColor(.secondary)

            if match.status == .pending {
                HStack(spacing: 32) {
                    Button(action: onDecline) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 36))
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)

                    Button(action: onAccept) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 36))
                            .foregroundColor(.teal)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 4)
            } else {
                StatusBadgeView(status: match.status)
                    .padding(.horizontal)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 3)
    }
}
