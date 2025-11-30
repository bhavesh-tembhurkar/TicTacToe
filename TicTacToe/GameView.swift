import SwiftUI

struct GameView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = GameViewModel()

    // For bounce animation of result
    @State private var showResult = false

    var body: some View {
        ZStack {

            // Background (same as home)
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.10),
                    Color(red: 0.10, green: 0.02, blue: 0.20)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {

                //  Top Bar (Centered Title)
                HStack {
                    Button {
                        showResult = false
                        viewModel.restartGame()
                        dismiss()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                            Text("Home")
                        }
                        .font(.subheadline.bold())
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                    }

                    Spacer()

                    VStack(spacing: 2) {
                        Text("Tic-Tac-Toe")
                            .font(.title3.bold())
                            .foregroundColor(.white)

                        Text("Player: \(viewModel.currentPlayer == .x ? "X" : "O")")
                            .font(.callout)
                            .foregroundColor(.white.opacity(0.7))
                    }

                    Spacer()

                    // Balance spacer for symmetry
                    Color.clear.frame(width: 80, height: 1)
                }
                .padding(.horizontal)
                .offset(y: -12)


                // MARK: - GRID AREA
                ZStack {

                    // White grid lines
                    VStack {
                        Spacer()
                        Rectangle().fill(Color.white.opacity(0.25)).frame(height: 2)
                        Spacer()
                        Rectangle().fill(Color.white.opacity(0.25)).frame(height: 2)
                        Spacer()
                    }
                    .frame(height: 330)

                    HStack {
                        Spacer()
                        Rectangle().fill(Color.white.opacity(0.25)).frame(width: 2)
                        Spacer()
                        Rectangle().fill(Color.white.opacity(0.25)).frame(width: 2)
                        Spacer()
                    }
                    .frame(width: 330)


                    //  BOARD CELLS
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3),
                        spacing: 0
                    ) {
                        ForEach(0..<9) { index in
                            ZStack {

                                // Win highlight
                                if viewModel.winningCells.contains(index) {
                                    RoundedRectangle(cornerRadius: 22)
                                        .fill(Color.white.opacity(0.10))
                                        .shadow(
                                            color: (viewModel.board[index] == .x ? Color.blue : Color.red)
                                                .opacity(0.9),
                                            radius: 25
                                        )
                                }

                                // X / O Symbol
                                Text(viewModel.board[index].symbol)
                                    .font(.system(size: 52, weight: .bold))
                                    .foregroundColor(.white)
                                    .shadow(
                                        color: (viewModel.board[index] == .x ? Color.blue : Color.red)
                                            .opacity(viewModel.board[index] == .empty ? 0 : 0.8),
                                        radius: 14
                                    )
                                    .scaleEffect(viewModel.board[index] == .empty ? 0.6 : 1.1)
                                    .animation(.spring(response: 0.35, dampingFraction: 0.6), value: viewModel.board[index].symbol)
                            }
                            .frame(width: 110, height: 110)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.makeMove(at: index)

                                if viewModel.gameResult != nil {
                                    DispatchQueue.main.async {
                                        showResult = true
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: 330, height: 330)
                }
                .frame(width: 330, height: 360)



                //  RESULT TEXT WITH ANIMATION
                if let result = viewModel.gameResult {
                    Text(result)
                        .font(.title2.bold())
                        .foregroundColor(.yellow)
                        .scaleEffect(showResult ? 1.15 : 0.4)
                        .opacity(showResult ? 1 : 0)
                        .animation(.spring(response: 0.45, dampingFraction: 0.55), value: showResult)
                        .padding(.top, 5)
                        .onAppear {
                            showResult = true
                        }
                }



                // Bottom Buttons
                HStack(spacing: 22) {

                    Button(action: {
                        showResult = false
                        viewModel.restartGame()
                    }) {
                        Text("Restart")
                            .font(.headline.bold())
                            .padding(.horizontal, 25)
                            .padding(.vertical, 12)
                            .background(Color.red.opacity(0.9))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: .red.opacity(0.5), radius: 12)
                    }

                    Button {
                        showResult = false
                        viewModel.restartGame()
                        dismiss()
                    } label: {
                        Text("Quit")
                            .font(.headline.bold())
                            .padding(.horizontal, 25)
                            .padding(.vertical, 12)
                            .background(.ultraThinMaterial)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 10)
            }
        }
    }
}


