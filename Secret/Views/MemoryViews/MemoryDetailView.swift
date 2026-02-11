//
//  MemoryDetailView.swift
//  Secret
//
//  Created by Maria Reyna on 2/11/26.
//

import SwiftUI

struct MemoryDetailView: View {
    @State var memory: Memory
    var body: some View {
        ZStack{
            Color.clear.overlay(
                Image(.mainBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
            VStack{
                Text(memory.name)
                    .font(.largeTitle)
                    .foregroundStyle(.cream)
                    .bold()
                Image(uiImage: memory.image ?? .default)
                    .resizable()
                    .scaledToFit()
                Text(memory.description)
                    .font(.title)
                    .padding()
                    .foregroundStyle(.cream)
                Text(memory.date.formatted())
                    .font(.title)
                    .padding()
                    .foregroundStyle(.cream)
            }
        }
    }
}

#Preview {
    MemoryDetailView(memory: Memory(name: "Placeholder", image: .default, description: "This is my placeholder text", date: Date.now))
    
}
