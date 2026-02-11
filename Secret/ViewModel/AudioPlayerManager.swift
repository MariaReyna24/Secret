//
//  AudioPlayerManager.swift
//  Secret
//
//  Created by Maria Reyna on 2/4/26.
//


import AVFoundation
import Combine

@Observable
class AudioPlayerManager {
     var AudioFiles: [AudioFile] = [
        AudioFile(songTitle: "Fade Into you", fileName: "Fade", recordImage: "record"),
        AudioFile(songTitle: "Kiss Me",fileName: "KissMe", recordImage: "kissMeRecord"),
        AudioFile(songTitle: "Champagne Coast",fileName: "Champ", recordImage: "bloodOrange")
      ]
    var currentSong =  AudioFile(songTitle: "Fade Into you", fileName: "Fade", recordImage: "record")
    var audioPlayer: AVAudioPlayer?
    var isPlaying: Bool = false
    
    func playAudio(track: AudioFile) {
           guard let url = track.url else {
               print("Error: Audio file not found for \(track.fileName)")
               return
           }

           do {
               audioPlayer = try AVAudioPlayer(contentsOf: url)
               audioPlayer?.play()
               self.isPlaying = true
           } catch {
               print("Error playing audio: \(error.localizedDescription)")
           }
       }
    
    func stopSound() {
        audioPlayer?.stop()
        isPlaying = false
    }
    
    func pauseSound() {
        audioPlayer?.pause()
        isPlaying = false
    }
}
