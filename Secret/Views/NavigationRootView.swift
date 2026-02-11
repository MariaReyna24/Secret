//
//  NavigationRootView.swift
//  Secret
//
//  Created by Maria Reyna on 2/10/26.
//

import SwiftUI

struct NavigationRootView: View {
    @State private var router = Router()
    @State var audioManager: AudioPlayerManager
    var body: some View {
        NavigationStack(path: $router.navigationPath ) {
            SelectionView(audioManager: audioManager)
                .environment(router)
                .navigationDestination(for: Router.Route.self) { route in
                    switch route {
                    case .mainView:
                        ContentView(audioManager: audioManager)
                            .environment(router)
                    case .selectionView:
                        SelectionView(audioManager: audioManager)
                            .environment(router)
                    case .selectMusic:
                        SelectMusic(audioManager: audioManager)
                            .environment(router)
                    }
                }
        }
    }
}

#Preview {
    NavigationRootView(audioManager: AudioPlayerManager())
}
