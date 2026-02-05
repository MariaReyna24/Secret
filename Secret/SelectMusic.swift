//
//  SelectMusic.swift
//  Secret
//
//  Created by Maria Reyna on 2/5/26.
//

import SwiftUI

struct SelectMusic: View {
    @Binding var song: AudioFile
    @State var audioManager = AudioPlayerManager()
    var body: some View {
        VStack {
            Picker("Select a song", selection: $song) {
                ForEach(audioManager.AudioFiles) { file in
                    Text("\(file.fileName)")
                }
            }
            //.pickerStyle(.navigationLink)
                //.pickerStyle(.navigationLink)

            
        }
    }
}

#Preview {
    SelectMusic(song: .constant(AudioFile(fileName: "fade")))
}
