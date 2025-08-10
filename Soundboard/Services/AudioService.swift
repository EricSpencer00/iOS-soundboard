//
//  AudioService.swift
//  Soundboard
//
//  Created by Eric Spencer on 8/10/25.
//

import Foundation
import AVFoundation

class AudioService: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName.replacingOccurrences(of: ".mp3", with: ""), withExtension: "mp3") else {
            print("Could not find sound file: \(fileName)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
}
