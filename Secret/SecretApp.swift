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
    var body: some Scene {
        WindowGroup {
           NavigationRootView(audioManager: audioManager)
        }
    }
}
