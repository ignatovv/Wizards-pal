import Foundation
import SwiftUI

final class GameState: ObservableObject {
    @Published var health1: Int {
        didSet {
            wasReseted = false
        }
    }
    @Published var health2: Int{
        didSet {
            wasReseted = false
        }
    }
    
    var initialHealth: Int
    
    @Published var showSetting = false
    @Published var showBackgroundPicker = false
    
    @Published var flipScreen = true
    @Published var background: GradientData = DataStore.background
    
    private var wasReseted = false
    private var prevHealth1: Int?
    private var prevHealth2: Int?
    
    var canUndo: Bool {
        health2 == initialHealth && health1 == initialHealth && wasReseted
    }
    var canReset: Bool {
        health2 != initialHealth || health1 != initialHealth
    }
    
    init() {
        initialHealth = DataStore.initialHealth
        health1 = initialHealth
        health2 = initialHealth
    }
    
    func undo() {
        guard let prevHealth1 = prevHealth1, let prevHealth2 = prevHealth2 else { return }
        
        health1 = prevHealth1
        health2 = prevHealth2
    }
    
    func resetHealth() {
        prevHealth1 = health1
        prevHealth2 = health2
        
        health2 = initialHealth
        health1 = initialHealth
        
        wasReseted = true
    }
    
    func updateInitialHealth(_ value: Int) {
        guard value != initialHealth else { return }
        
        initialHealth = value
        DataStore.initialHealth = value
        resetHealth()
        wasReseted = false
    }
    
    func updateBackground(_ data: GradientData) {
        background = data
        DataStore.background = data
    }
    
    private let dice = [1, 2, 3, 4, 5, 6]
    @Published var toastTitle = ""
    @Published var toastSubtitle = ""
    @Published var showToast = false
    
    func throwDie() {
        guard let yourThrow = dice.randomElement() else { return }
        guard let opponentThrow = dice.randomElement() else { return }
        
        if yourThrow == opponentThrow {
            throwDie()
            return
        } else if yourThrow > opponentThrow {
            toastTitle = "You win the roll"
        } else {
            toastTitle = "You lose the roll"
        }
        
        toastSubtitle = "you: \(yourThrow) - opponent: \(opponentThrow)"
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.showToast = false
        }
    }
}
