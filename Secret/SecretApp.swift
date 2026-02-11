//
//  SecretApp.swift
//  Secret
//
//  Created by Maria Reyna on 2/3/26.
//

import SwiftUI

@main
struct SecretApp: App {
    @State var audioManager = AudioPlayerManager()
    @State var memoryVM = MemoryViewModel()
    var body: some Scene {
        WindowGroup {
           NavigationRootView(audioManager: audioManager, memoryVM: memoryVM)
        }
    }
}
