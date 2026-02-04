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
    var audioPlayer: AVAudioPlayer?
    var isPlaying: Bool = false
    
    func playSound(soundName: String, fileType: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: fileType) else {
            print("Audio file not found: \(soundName).\(fileType)")
            return
        }
        
        do {
            // Set the audio session category to allow playback
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
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