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
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.forestGreen, lineWidth: 4)
                    )
                    .shadow(radius: 8)
                Text(memory.description)
                    .font(.title)
                    .padding()
                    .foregroundStyle(.cream)
                Text(memory.date.formatted(date: .numeric, time: .complete))
                    .font(.title)
                    .padding()
                    .foregroundStyle(.cream)
            }
            .animation(.easeInOut(duration: 0.4), value: memory.name)
        }
    }
}

#Preview {
    MemoryDetailView(memory: Memory(name: "Placeholder", image: .default, description: "This is my placeholder text", date: Date.now))
    
}

