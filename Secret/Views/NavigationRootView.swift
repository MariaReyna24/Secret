//
//  NavigationRootView.swift
//  Secret
//
//  Created by Maria Reyna on 2/10/26.
//

// Note: The navigation route must now supply a Memory object when navigating to .memoryDetailView.

import SwiftUI

struct NavigationRootView: View {
    @State var router = Router()
    @State var audioManager: AudioPlayerManager
    @State var memoryVM: MemoryViewModel
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
                    case .memoryView:
                        MemoriesView(memoryvm: memoryVM)
                            .environment(router)
                    case let .memoryDetailView(memory:memory):
                        MemoryDetailView(memory: memory)
                            .environment(router)
                    }
                }
        }
    }
}

#Preview {
    NavigationRootView(audioManager: AudioPlayerManager(), memoryVM: MemoryViewModel())
}
