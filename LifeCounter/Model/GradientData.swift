import SwiftUI

struct GradientData: Identifiable, Codable, Equatable {
    let name: String
    
    let colors: [String]
    
    var id: String {
        "\(name)\(colors)"
    }
}

extension GradientData {
    func asLinearGradient() -> some View {
        LinearGradient(
            gradient: Gradient(
                colors: colors.map { Color(hex: $0) }
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
}
