//
//  SecretApp.swift
//  Secret
//
//  Created by Maria Reyna on 2/3/26.
//

import SwiftUI

@main
struct SecretApp: App {
    @State private var song = AudioFile(fileName: "fade")
    var body: some Scene {
        WindowGroup {
            ContentView(song: song)
        }
    }
}
