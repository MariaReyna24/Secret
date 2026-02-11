//
//  ContentView.swift
//  Secret
//
//  Created by Maria Reyna on 2/3/26.
//

import SwiftUI
import Combine


struct ContentView: View {
    @Environment(Router.self) var router
    @State var rotation = 0.0
    @State var isShowingText = false
    @State var scale = 1.0
    @State var isShowingBackground = false
    @State var isRotating = false
    @State var audioManager: AudioPlayerManager
    let timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()
    var body: some View {
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
                Text("Happy Valentine's Day ❤️")
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(20)
                Button {
                    if isRotating == false {
                        isRotating = true
                        audioManager.playAudio(track: audioManager.currentSong)
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
                    Image(audioManager.currentSong.recordImage)
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
            }.onDisappear {
                audioManager.stopSound()
            }
        }
    }
}

#Preview {
    ContentView(audioManager: AudioPlayerManager())
        .environment(Router())
}
