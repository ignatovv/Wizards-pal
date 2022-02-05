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
        .alert(isPresented: $state.showFeedbackToast) {
            rateAppAlert
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
            state.showFeedbackToast = true
        }) {
            HStack {
                Text("Leave feedback 👻").foregroundColor(.secondaryColor)
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
    
    private var rateAppAlert: Alert {
        Alert(
            title: Text("Do you like the app?"),
            message: nil,
            primaryButton: .default(Text("Yes 🥰")) {
                startAppstoreReview()
            },
            secondaryButton: .default(Text("No 🥲")) {
                sendEmail()
            }
        )
    }
    
    func startAppstoreReview() {
        if let scene = UIApplication.shared.connectedScenes.first(
            where: { $0.activationState == .foregroundActive }
        ) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func sendEmail() {
        let email = "ignatovv@protonmail.ch"
        let subject = "Feedback on your life counter app"
        let mailtoString = "mailto:\(email)?subject=\(subject)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let mailtoUrl = URL(string: mailtoString!)!
        if UIApplication.shared.canOpenURL(mailtoUrl) {
            UIApplication.shared.open(mailtoUrl, options: [:])
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(GameState())
    }
}
