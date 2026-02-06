//
//  ContentView.swift
//  Secret
//
//  Created by Maria Reyna on 2/3/26.
//

import SwiftUI
import Combine


struct ContentView: View {
    @State var rotation = 0.0
    @State var isShowingText = false
    @State var scale = 1.0
    @State var isShowingBackground = false
    @State var isRotating = false
    var audioManager = AudioPlayerManager()

    // Timer for driving the rotation animation
    let timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.4, green: 0.0, blue: 0.1),
                        Color(red: 0.7, green: 0.05, blue: 0.2),
                        Color(red: 0.95, green: 0.4, blue: 0.5)
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .ignoresSafeArea()
                VStack {
                    Button {
                        if isRotating == false {
                            isRotating = true
                            audioManager.playSound(soundName: "Fade", fileType: ".m4a")
                            withAnimation(.linear(duration: 2.0)) {
                                isShowingText.toggle()
                                isShowingBackground.toggle()
                            }
                        } else if isRotating == true {
                            withAnimation(.easeIn(duration: 1)) {
                                isRotating = false
                                audioManager.pauseSound()
                                isShowingText.toggle()
                                isShowingBackground.toggle()
                            }
                        }
                    } label: {
                        Image(.record)
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(.degrees(rotation))
                            .onReceive(timer) { _ in
                                if isRotating {
                                    rotation += 1.5
                                    if rotation >= 360 { rotation -= 360 }
                                }
                            }
                    }
                    withAnimation(.easeIn(duration: 1)) {
                        Image(isShowingBackground ? .background : .kitty )
                            .resizable()
                            .scaledToFit()
                    }
                }
               
            }
            .navigationTitle("What is this???")
            
        }
    }
}

#Preview {
    ContentView()
}
