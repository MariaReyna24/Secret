//
//  MemoryViewModek.swift
//  Secret
//
//  Created by Maria Reyna on 2/11/26.
//

import Foundation
import PhotosUI
import CloudKit
import UserNotifications

@Observable
@MainActor
class MemoryViewModel {
    enum AppState {
        case loading, loaded, failed(Error)
    }
    var currentCreationDate = Date.now
    var isShowingWaitingScreen = false
    var addedImage = false
    private let ckService = CloudKitService()
    var appState: AppState = .loaded
    var listOfMemories: [Memory] = []
    
    func photoAuthorization() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch authorizationStatus {
        case .authorized:
            print("Authorized")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                print("Status: \(status)")
            }
        case .denied, .restricted:
            print("Denied")
        default:
            print("user did not select one")
        }
    }
    
    func fetchMemories() async throws {
        do {
            self.listOfMemories = try await ckService.fetchMemory()
            appState = .loaded
        } catch {
            appState = .failed(error)
        }
    }
    
    func saveNewMemory(withName name: String, image: UIImage, description: String, date: Date) async throws {
        appState = .loading
        do {
            let mem = Memory(name: name,image: image, description: description, date: date)
            try await ckService.saveOff(mem)
            listOfMemories.append(mem)
            appState = .loaded
        } catch {
            appState = .failed(error)
        }
    }
    
    func delete(_ memoryToRemove: Memory) async throws {
        appState = .loading
        do {
            try await ckService.deleteMemory(memoryToRemove)
            listOfMemories = listOfMemories.filter { storedMem in
                return storedMem.id != memoryToRemove.id
            }
            appState = .loaded
        } catch {
            appState = .failed(error)
        }
    }
    
    func update(_ updateMem: Memory) async throws {
        appState = .loading
        do {
            try await ckService.addNewMemory(updateMem)
            var updatedMem = listOfMemories.filter { storedMem in
                return storedMem.id != updateMem.id
            }
            updatedMem.append(updateMem)
            self.listOfMemories = updatedMem
            appState = .loaded
            
        } catch {
            appState = .failed(error)
        }
    }
}
