//
//  SoundboardView.swift
//  Soundboard
//
//  Created by Eric Spencer on 8/10/25.
//

import SwiftUI

struct SoundboardView: View {
    @StateObject private var soundData = SoundData()
    @StateObject private var audioService = AudioService()
    @StateObject private var purchaseService = PurchaseService()
    @State private var showingSettings = false
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(visibleSounds) { sound in
                        SoundButton(
                            sound: sound,
                            audioService: audioService,
                            isPremiumUnlocked: purchaseService.hasPurchasedPremium
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Soundboard")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gear")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(purchaseService: purchaseService)
            }
            .onReceive(purchaseService.$hasPurchasedPremium) { isPremium in
                if isPremium {
                    soundData.unlockPremiumSounds()
                }
            }
        }
    }
    
    private var visibleSounds: [SoundItem] {
        if purchaseService.hasPurchasedPremium {
            return soundData.allSounds
        } else {
            return soundData.getFreeSounds()
        }
    }
}

struct SoundButton: View {
    let sound: SoundItem
    let audioService: AudioService
    let isPremiumUnlocked: Bool
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            if !sound.isLocked || isPremiumUnlocked {
                audioService.playSound(fileName: sound.fileName)
            }
        }) {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(buttonColor)
                        .frame(height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(strokeColor, lineWidth: 2)
                        )
                    
                    if sound.isLocked && !isPremiumUnlocked {
                        Image(systemName: "lock.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    } else {
                        Text("▶")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                
                Text(sound.displayName)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
            }
        }
        .opacity(sound.isLocked && !isPremiumUnlocked ? 0.6 : 1.0)
    }
    
    private var buttonColor: Color {
        if sound.isLocked && !isPremiumUnlocked {
            return Color.gray
        } else {
            return Color.blue
        }
    }
    
    private var strokeColor: Color {
        if sound.isLocked && !isPremiumUnlocked {
            return Color.gray.opacity(0.5)
        } else {
            return Color.blue.opacity(0.3)
        }
    }
}

#Preview {
    SoundboardView()
}
