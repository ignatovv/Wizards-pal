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
        initialHealth = value
        DataStore.initialHealth = value
        resetHealth()
        wasReseted = false
    }
    
    func updateBackground(_ data: GradientData) {
        background = data
        DataStore.background = data
    }
}
