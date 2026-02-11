//
//  SectionView.swift
//  Secret
//
//  Created by Maria Reyna on 2/9/26.
//

import SwiftUI

struct SelectionView: View {
    @Environment(Router.self) var router
    @State var audioManager: AudioPlayerManager
    var body: some View {
        ZStack{
            Color.clear.overlay(
                Image(.mainBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
            VStack{
                Text("What your vibe?")
                    .foregroundStyle(.cream)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 100)
                VStack{
                    GifImageView("dogSpinning")
                        .frame(width: 350, height: 200)
                    
                    Button{
                        router.navigateTo(route: .selectMusic)
                    } label: {
                        Text("Music")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    
                }
                VStack{
                    GifImageView("standingKitty")
                        .frame(width: 190, height: 270)
                    Button {
                        
                    } label: {
                        Text("Coming Soon")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                }
                
            }
        }
    }
}

#Preview {
    SelectionView(audioManager: AudioPlayerManager())
        .environment(Router())
}
