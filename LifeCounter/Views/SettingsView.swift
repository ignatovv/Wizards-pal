import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var state: GameState
    
    @State var checkAmount = 0
    @State var startingHealth = ""
    @State var startingHealthError = false
    
    var body: some View {
        List {
            HStack {
                Text("Starting health:")
                TextField("", text: $startingHealth)
                    .keyboardType(.numberPad)
                    .foregroundColor( startingHealthError ? .red : .black)
            }
            
            Toggle("Flip second player screen", isOn: $state.flipScreen)
            
            Button(action: { state.showBackgroundPicker = true}) {
                HStack {
                    Text("Background color")
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                
            }
        }
        .onAppear {
            startingHealth = "\(state.initialHealth)"
        }
        .onChange(of: startingHealth) { newValue in
            if let value = Int(newValue) {
                startingHealthError = false
                state.updateInitialHealth(value)
            } else {
                startingHealthError = true
            }
        }
        .sheet(isPresented: $state.showBackgroundPicker) {
            BackgroundColorView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(GameState())
    }
}
