import SwiftUI

extension Image {
    static let reset: some View = Image(systemName:"arrow.triangle.2.circlepath")
        .font(.system(size: 40))
    static let undo: some View = Image(systemName:"clock.arrow.2.circlepath")
        .font(.system(size: 40))
    static var dice: some View {
        Group {
            if #available(iOS 15.0, *) {
                Image(systemName: "dice")
                    .font(.system(size: 40))
            } else {
                Image(systemName: "die.face.5")
                    .font(.system(size: 40))
            }
        }
    }
    static var settings: some View {
        Group {
            if #available(iOS 15.0, *) {
                Image(systemName: "gearshape.circle")
                    .font(.system(size: 40))
            } else {
                Image(systemName: "gearshape")
                    .font(.system(size: 40))
            }
        }
    }
}
