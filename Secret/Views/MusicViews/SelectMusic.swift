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
                    .font(.largeTitle)
                    .padding(.top, 30)
                    .foregroundStyle(.cream)
                Text("(theres only 3 srry)")
                    .foregroundStyle(.cream)
                List {
                    ForEach(audioManager.AudioFiles) { file in
                        Button{
                            router.navigateTo(route: .mainView)
                            audioManager.currentSong = file
                        } label: {
                            HStack{
                                Text(file.songTitle)
                                 
                                Spacer()
                                Image(systemName: "arrow.forward")
                                  
                            }
                        }.foregroundStyle(.white)
                    }
                }
                .scrollContentBackground(.hidden)
                
            }
        }
    }
}

#Preview {
    SelectMusic(audioManager: AudioPlayerManager())
        .environment(Router())
}
