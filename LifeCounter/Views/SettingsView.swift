import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject private var state: GameState
    
    @State var checkAmount = 0
    @State var startingHealth = ""
    @State var startingHealthError = false
    
    @State var showSafari = false
    
    var body: some View {
        List {
            Section {
                startingHealthView
                Toggle("Flip second player screen", isOn: $state.flipScreen)
                backgroundPicker
            }
            Section {
                reviewInAppStore
                contactMe
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
        .sheet(isPresented: $showSafari) {
            SFSafariViewWrapper(url: URL(string: "https://www.ignatovv.com")!)
        }
    }
    
    private var startingHealthView: some View {
        HStack {
            Text("Starting health:")
            TextField("", text: $startingHealth)
                .keyboardType(.numberPad)
                .foregroundColor( startingHealthError ? .red : .secondaryColor)
        }
    }
    
    private var backgroundPicker: some View {
        Button(action: { state.showBackgroundPicker = true}) {
            HStack {
                Text("Background color")
                    .foregroundColor(.secondaryColor)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
        }
    }
    
    private var reviewInAppStore: some View {
        Button(action: {
            if let scene = UIApplication.shared.connectedScenes.first(
                where: { $0.activationState == .foregroundActive }
            ) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }) {
            HStack {
                Text("Review in App Store 👻").foregroundColor(.secondaryColor)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var contactMe: some View {
        Button(action: {
            showSafari = true
        }) {
            HStack {
                Text("Contact me").foregroundColor(.secondaryColor)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(GameState())
    }
}
