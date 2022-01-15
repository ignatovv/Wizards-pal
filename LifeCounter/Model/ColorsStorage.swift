import SwiftUI

struct ColorsStorage {
    static let all: [GradientData] = [
        GradientData(name: "by design", colors: ["#009FFF", "#ec2F4B"]),
        GradientData(name: "missing name", colors: ["#5433FF", "#20BDFF", "#A5FECB"]),
        GradientData(name: "bluePink", colors: [ "#03001e", "#7303c0", "#ec38bc", "#fdeff9"]),
        GradientData(name: "blue", colors: ["#C6FFDD", "#f7797d"]),
        GradientData(name: "pinkOrange", colors: ["#d8a4e1", "#ffcc81"]),
        GradientData(name: "red", colors: ["#bdc3c7", "#2c3e50"]),
        GradientData(name: "teal", colors: ["#43cea2", "#185a9d"]),
        GradientData(name: "greenOrange", colors: [ "#63b3cb", "#f7c47a"]),
        GradientData(name: "sky", colors: [ "#6eb6e4", "#daeaf3"])
    ]
    
    static let `default` = GradientData(name: "by design", colors: ["#009FFF", "#ec2F4B"])
}

extension Color {
    
    init(hex: String, opacity: Double = 1) {
        let chars = Array(hex.dropFirst())
        
        self.init(
            red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
            green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
            blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
            opacity: opacity
        )
    }
    
}
