//
//  BackgroundColorView.swift
//  LifeCounter
//
//  Created by Vladimir Ignatov on 15.01.2022.
//

import SwiftUI

struct BackgroundColorView: View {
    @EnvironmentObject private var state: GameState

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("Change background").font(.headline)
            LazyVGrid(columns: [.init(), .init(), .init()]) {
                ForEach(ColorsStorage.all) { data in
                    Button(action: {
                        state.updateBackground(data)
                        UISelectionFeedbackGenerator().selectionChanged()
                        state.showBackgroundPicker = false
                        state.showSetting = false
                    }) {
                        data.asLinearGradient()
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .frame(height: 200)
                    }
                }

            }
        }
        .padding()
    }
}

struct BackgroundColorView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColorView()
    }
}
