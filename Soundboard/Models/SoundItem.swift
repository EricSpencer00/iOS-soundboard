//
//  SoundItem.swift
//  Soundboard
//
//  Created by Eric Spencer on 8/10/25.
//

import Foundation

struct SoundItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let fileName: String
    let displayName: String
    let isLocked: Bool
    
    init(name: String, fileName: String, displayName: String? = nil, isLocked: Bool = false) {
        self.name = name
        self.fileName = fileName
        self.displayName = displayName ?? name.capitalized
        self.isLocked = isLocked
    }
}
