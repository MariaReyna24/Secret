//
//  MemoriesView.swift
//  Secret
//
//  Created by Maria Reyna on 2/11/26.
//

import SwiftUI

struct MemoriesView: View {
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    @State var isShowingSheet = false
    @Environment(Router.self) var router
    @State var memoryvm: MemoryViewModel
    var body: some View {
        ZStack{
            Color.clear.overlay(
                Image(.mainBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Our Memories")
                    .font(.largeTitle)
                    .foregroundStyle(.cream)
                switch memoryvm.appState {
                case .loading:
                   WaitingView()
                    Text("Updating Our Memories...")
                        .font(.largeTitle)
                        .task {
                            try? await memoryvm.fetchMemories()
                        }
                case .loaded:
                    ScrollView{
                        VStack{
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(memoryvm.listOfMemories){ memory in
                                    Button{
                                        router.navigateTo(route: .memoryDetailView(memory: memory))
                                    }label: {
                                        Image(uiImage: memory.image ?? .default)
                                            .resizable()
                                            .scaledToFit()
                                            .border(.white, width: 4)
                                            .padding()
                                    }
                                }.foregroundStyle(.white)
                            }
                           
                        }
                        
                    }.refreshable {
                        try? await memoryvm.fetchMemories()
                    }
                    .task {
                        try? await memoryvm.fetchMemories()
                    }
                    Button{
                        isShowingSheet.toggle()
                    }label: {
                        Text("Add New Memory")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .sheet(isPresented: $isShowingSheet) {
                        AddMemorySheet(memoryVM: memoryvm)
                    }
                case .failed(let error):
                    Text("Something bad happened oops: \(error.localizedDescription)")
                        .padding(.bottom)
                    Button{
                        Task{
                            try? await memoryvm.fetchMemories()
                        }
                    } label: {
                        Text("Retry")
                    }
                }
                
            }
        }
    }
}
#Preview {
    MemoriesView(memoryvm: MemoryViewModel())
        .environment(Router())
}
