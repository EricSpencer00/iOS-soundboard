//
//  SoundData.swift
//  Soundboard
//
//  Created by Eric Spencer on 8/10/25.
//

import Foundation

class SoundData: ObservableObject {
    @Published var allSounds: [SoundItem] = []
    
    init() {
        loadSounds()
    }
    
    private func loadSounds() {
        // First 45 sounds are free (we'll start with 15 and add more)
        let freeSounds = [
            SoundItem(name: "applause", fileName: "applause.mp3", displayName: "👏 Applause"),
            SoundItem(name: "bell", fileName: "bell.mp3", displayName: "🔔 Bell"),
            SoundItem(name: "boing", fileName: "boing.mp3", displayName: "🪀 Boing"),
            SoundItem(name: "pop", fileName: "pop.mp3", displayName: "💥 Pop"),
            SoundItem(name: "whoosh", fileName: "whoosh.mp3", displayName: "💨 Whoosh"),
            SoundItem(name: "click", fileName: "click.mp3", displayName: "👆 Click"),
            SoundItem(name: "beep", fileName: "beep.mp3", displayName: "📻 Beep"),
            SoundItem(name: "ding", fileName: "ding.mp3", displayName: "🛎 Ding"),
            SoundItem(name: "buzz", fileName: "buzz.mp3", displayName: "🐝 Buzz"),
            SoundItem(name: "chime", fileName: "chime.mp3", displayName: "🎵 Chime"),
            SoundItem(name: "horn", fileName: "horn.mp3", displayName: "📯 Horn"),
            SoundItem(name: "tick", fileName: "tick.mp3", displayName: "⏰ Tick"),
            SoundItem(name: "swoosh", fileName: "swoosh.mp3", displayName: "🌊 Swoosh"),
            SoundItem(name: "ping", fileName: "ping.mp3", displayName: "🏓 Ping"),
            SoundItem(name: "thud", fileName: "thud.mp3", displayName: "🥊 Thud")
        ]
        
        // Add premium sounds (locked by default)
        let premiumSounds = [
            SoundItem(name: "snap", fileName: "snap.mp3", displayName: "👌 Snap", isLocked: true)
            // We can add more premium sounds later
        ]
        
        allSounds = freeSounds + premiumSounds
    }
    
    func getFreeSounds() -> [SoundItem] {
        return allSounds.filter { !$0.isLocked }
    }
    
    func getPremiumSounds() -> [SoundItem] {
        return allSounds.filter { $0.isLocked }
    }
    
    func unlockPremiumSounds() {
        for index in allSounds.indices {
            allSounds[index] = SoundItem(
                name: allSounds[index].name,
                fileName: allSounds[index].fileName,
                displayName: allSounds[index].displayName,
                isLocked: false
            )
        }
    }
}
