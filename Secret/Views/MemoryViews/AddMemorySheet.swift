//
//  AddMemorySheet.swift
//  Secret
//
//  Created by Maria Reyna on 2/11/26.
//

import SwiftUI
import PhotosUI
struct AddMemorySheet: View {
    @State private var isShowingError = false
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
                    .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                    .shadow(radius: Theme.shadowRadius)
                    .transition(.opacity.combined(with: .scale))
                
                PhotosPicker("Upload a photo", selection: $pickerItem, matching: .images)
                    .foregroundStyle(.white)
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .onChange(of: pickerItem) {
                        Task {
                            if let identifier = pickerItem?.itemIdentifier,
                               let asset = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil).firstObject {
                                memory.date = asset.creationDate ?? asset.addedDate
                                memoryVM.addedImage.toggle()
                            }

                            selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
                            selectedPhotoData = try? await pickerItem?.loadTransferable(type: Data.self)
                            selectedPhotoURL = try? await pickerItem?.loadTransferable(type: URL.self)
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
                    memoryVM.isShowingWaitingScreen.toggle()
                }label: {
                    Text("Add Memory")
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .disabled(memory.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

            }
            .onAppear {
                memoryVM.photoAuthorization()
            }
            .animation(.easeInOut(duration: 0.4), value: selectedImage != nil)
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
