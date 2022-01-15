import SwiftUI

struct ContentView: View {
    @StateObject private var state = GameState()
    
    var body: some View {
        ZStack {
            state.background.asLinearGradient().ignoresSafeArea()
            
            VStack(spacing: 0) {
                playerBoard(life: $state.health1)
                    .rotationEffect(state.flipScreen ? .degrees(180) : .degrees(0))
                playerBoard(life: $state.health2)
            }
        }
        .overlay(settings, alignment: .center)
        .ignoresSafeArea(.keyboard)

        .sheet(isPresented: $state.showSetting) {
            SettingsView()
        }
        
        .environmentObject(state)
    }
    
    func playerBoard(life: Binding<Int>) -> some View {
        ZStack {
            lifeNumbers(life: life.wrappedValue)
            plusMinusBoard(life: life)
            plusMinusFiveBoard(life: life)
        }
    }
    
    func lifeNumbers(life: Int) -> some View {
        VStack {
            Text("\(life)")
                .foregroundColor(.white)
                .font(.system(size: 180))
                .minimumScaleFactor(0.1)
                .padding(.horizontal, 30)
                .padding(.top, 30)
                .frame(maxWidth: .infinity)
                .overlay(
                    Image(systemName: "minus").foregroundColor(.white).imageScale(.small).padding().padding(.top, 20),
                    alignment: .leading
                )
                .overlay(
                    Image(systemName: "plus").foregroundColor(.white).imageScale(.small).padding().padding(.top, 20),
                    alignment: .trailing
                )
            Spacer()
        }
    }
    
    func plusMinusBoard(life: Binding<Int>) -> some View {
        HStack {
            Button(action: {
                UISelectionFeedbackGenerator().selectionChanged()
                life.wrappedValue -= 1
            }) { Color.clear }
            Button(action: {
                UISelectionFeedbackGenerator().selectionChanged()
                life.wrappedValue += 1
            }) { Color.clear }
        }
    }
    
    func plusMinusFiveBoard(life: Binding<Int>) -> some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    life.wrappedValue -= 5
                }) {
                    Text("-5").foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .overlay(
                            Capsule()
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                Spacer().frame(width: 30)
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    life.wrappedValue += 5
                }) {
                    Text("+5").foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .overlay(
                            Capsule()
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
    
    var settings: some View {
        HStack {
            if state.canUndo {
                Button(action: {
                    UISelectionFeedbackGenerator().selectionChanged()
                    state.undo()
                }, label: {
                    Image(systemName:"clock.arrow.2.circlepath")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                })
            } else if state.canReset {
                Button(action: {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    state.resetHealth()
                }, label: {
                    Image(systemName:"arrow.triangle.2.circlepath")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                })
            } else {
                Image(systemName:"arrow.triangle.2.circlepath")
                    .font(.system(size: 40))
                    .foregroundColor(.white.opacity(0.4))
            }
            
            Button(action: {
                UISelectionFeedbackGenerator().selectionChanged()
            }, label: {
                Image(systemName: "dice")
                    .font(.system(size: 40))
                    .foregroundColor(.white)

            })
            
            Button(action: {
                UISelectionFeedbackGenerator().selectionChanged()
                state.showSetting = true
            }, label: {
                Image(systemName: "gearshape.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.white)

            })
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
