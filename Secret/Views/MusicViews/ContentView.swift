//
//  ContentView.swift
//  Secret
//
//  Created by Maria Reyna on 2/3/26.
//

import SwiftUI
import Combine

#if os(iOS)
import UIKit
private func lightTap() { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
#else
private func lightTap() {}
#endif


struct ContentView: View {
    @Environment(Router.self) var router
    @State var rotation = 0.0
    @State var scale = 1.0
    @State var isShowingBackground = false
    @State var isRotating = false
    @State var audioManager: AudioPlayerManager

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
                    .foregroundStyle(.cream)
                    .font(.title)
                    .padding(20)
                Button {
                    if isRotating == false {
                        isRotating = true
                        lightTap()
                        audioManager.playAudio(track: audioManager.currentSong)
                        withAnimation(.easeInOut(duration: 0.6)) {
                            isShowingBackground.toggle()
                        }
                    } else if isRotating == true {
                        isRotating = false
                        lightTap()
                        withAnimation(.easeInOut(duration: 0.6)) {
                            isShowingBackground.toggle()
                        }
                        audioManager.pauseSound()
                    }
                } label: {
                    Image(audioManager.currentSong.recordImage)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(isRotating ? 360 : 0))
                        .animation(isRotating ? .linear(duration: 6).repeatForever(autoreverses: false) : .default, value: isRotating)
                        .scaleEffect(isRotating ? 1.03 : 1.0)
                        .shadow(radius: 8)
                }
                ZStack {
                    if isShowingBackground {
                        Image(.background)
                            .resizable()
                            .scaledToFit()
                            .transition(.opacity.combined(with: .scale))
                    } else {
                        Image(.kitty)
                            .resizable()
                            .scaledToFit()
                            .transition(.opacity.combined(with: .scale))
                    }
                }
                .animation(.easeInOut(duration: 0.6), value: isShowingBackground)
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
