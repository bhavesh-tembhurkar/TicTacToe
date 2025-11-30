import SwiftUI

struct HomeView: View {
    @State private var startGame = false

    var body: some View {
        ZStack {
            // Dark premium gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.10),
                    Color(red: 0.10, green: 0.02, blue: 0.20)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // Title + Subtitle
                VStack(spacing: 12) {
                    Text("Tic-Tac-Toe")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text("Two-Player · Same Device")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.white.opacity(0.6))
                }

                // XO Circle Logo
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 120, height: 120)
                        .shadow(color: .black.opacity(0.5), radius: 25, x: 0, y: 18)

                    HStack(spacing: 15) {
                        Text("X")
                            .font(.system(size: 45, weight: .bold, design: .rounded))
                            .foregroundColor(.cyan)

                        Text("O")
                            .font(.system(size: 45, weight: .bold, design: .rounded))
                            .foregroundColor(.pink)
                    }
                }
                .padding(.top, 10)

                // Play Game Button
                Button {
                    startGame = true
                } label: {
                    Text("Play Game")
                        .font(.title3.bold())
                        .padding(.horizontal, 50)
                        .padding(.vertical, 15)
                        .background(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.blue, Color.cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                        .foregroundStyle(.white)
                        .shadow(color: .blue.opacity(0.5), radius: 15, x: 0, y: 10)
                }
                .padding(.top, 10)

                Spacer()
            }
            .padding()
        }
        .fullScreenCover(isPresented: $startGame) {
            GameView()
        }
    }
}

