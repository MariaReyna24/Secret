//
//  AddMemorySheet.swift
//  Secret
//
//  Created by Maria Reyna on 2/11/26.
//

import SwiftUI
import PhotosUI
struct AddMemorySheet: View {
    @State private var isShowingError = true
    @Environment(\.dismiss) var dismiss
    @State var memory = Memory(name: "", image: .default, description: "", date: Date.now)
    @State var selectedImage: Image?
    @State private var pickerItem: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    @State var selectedPhotoURL: URL?
    @State var memoryVM: MemoryViewModel
   
    var body: some View {
        ZStack {
            Color.clear.overlay(
                Image(.mainBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                selectedImage?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 100)
                    .padding()
                
                PhotosPicker("Upload a photo", selection: $pickerItem, matching: .images)
                    .foregroundStyle(.white)
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .onChange(of: pickerItem){
                        Task{
                            selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
                            guard
                                let identifer = pickerItem?.itemIdentifier,
                                let asset = PHAsset.fetchAssets(withLocalIdentifiers: [identifer], options: nil).firstObject
                               
                            else {
                                return("fail")
                            }
                            let creationDate = asset.addedDate
                            print(creationDate)
                            memoryVM.addedImage.toggle()
                            memory.date = creationDate
                           return("pass")
                            
                        }
                    }
                    .task(id: pickerItem){
                        if let data = try? await pickerItem?.loadTransferable(type: Data.self){
                            selectedPhotoData = data
                        }
                        if let url = try? await pickerItem?.loadTransferable(type: URL.self){
                            selectedPhotoURL = url
                        }
                        
                    }
                
                Group{
                    TextField("Enter Name", text: $memory.name)
                    TextField("Add Description", text: $memory.description)
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                
//                DatePicker(selection: $memory.date, in: ...Date.now, displayedComponents: .date) {
//                    Text("Select a date")
//                        .padding()
//                }
                Button {
                    addMemory()
                    dismiss()
                    memoryVM.isShowingWaitingScreen.toggle()
                }label: {
                    Text("Add Memory")
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .disabled(memory.name == "" && memory.description == "")

            }.onAppear {
                memoryVM.photoAuthorization()
            }
        }
    }
    func addMemory(){
        Task {
            do {
                let pickedImage: UIImage
                if let data = selectedPhotoData, let uiImage = UIImage(data: data) {
                    pickedImage = uiImage
                } else {
                    pickedImage = .default
                }
                
                try await memoryVM.saveNewMemory(withName: memory.name, image: pickedImage, description: memory.description, date: memory.date)
                print(memory.date)
                dismiss()
            } catch {
                isShowingError = true
            }
        }
    }

}
#Preview {
    AddMemorySheet(memoryVM: MemoryViewModel())
}
