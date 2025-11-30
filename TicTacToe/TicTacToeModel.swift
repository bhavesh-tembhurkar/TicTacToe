import Foundation

// Who is the current player?
enum Player {
    case x
    case o
}

// Represents each cell in the 3x3 grid.
enum CellState {
    case empty
    case x
    case o
}
extension CellState {
    var symbol: String {
        switch self {
        case .x: return "X"
        case .o: return "O"
        case .empty: return ""
        }
    }
}
