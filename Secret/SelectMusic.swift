//
//  SelectMusic.swift
//  Secret
//
//  Created by Maria Reyna on 2/5/26.
//

import SwiftUI

struct SelectMusic: View {
    @State private var showDetails = false
    @Binding var song: AudioFile
    @State var audioManager = AudioPlayerManager()
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(audioManager.AudioFiles) { file in
                        Button{
                            showDetails.toggle()
                        } label: {
                            Text(file.fileName)
                        }
                    } .navigationDestination(isPresented: $showDetails) {
                        ContentView(song: song)
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    SelectMusic(song: .constant(AudioFile(fileName: "fade")))
}
