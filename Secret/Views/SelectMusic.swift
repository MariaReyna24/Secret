//
//  SelectMusic.swift
//  Secret
//
//  Created by Maria Reyna on 2/5/26.
//

import SwiftUI

struct SelectMusic: View {
    @Environment(Router.self) var router
    @State private var showDetails = false
    @State var audioManager: AudioPlayerManager
    var body: some View {
        ZStack{
            Color.clear.overlay(
                Image(.mainBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Pick a song")
                List {
                    ForEach(audioManager.AudioFiles) { file in
                        Button{
                            router.navigateTo(route: .mainView)
                            audioManager.currentSong = file
                        } label: {
                            HStack{
                                Text(file.songTitle)
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "arrow.forward")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }.scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    SelectMusic(audioManager: AudioPlayerManager())
        .environment(Router())
}
