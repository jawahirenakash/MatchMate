import SwiftUI

struct MatchCardView: View {
    let match: MatchProfile
    let onAccept: () -> Void
    let onDecline: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(match.name.prefix(2).uppercased())
                            .font(.title3.bold())
                            .foregroundColor(.blue)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(match.name)
                        .font(.headline)
                    Text(match.email)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Label(match.city, systemImage: "location")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Label(match.company, systemImage: "building")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }

            StatusBadgeView(status: match.status)
                .frame(maxWidth: .infinity, alignment: .trailing)

            if match.status == .pending {
                HStack(spacing: 16) {
                    Button(action: onDecline) {
                        Label("Decline", systemImage: "xmark")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)

                    Button(action: onAccept) {
                        Label("Accept", systemImage: "checkmark")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
