//
//  CloudkitModel.swift
//  Secret
//
//  Created by Maria Reyna on 2/11/26.
//

import Foundation
import CloudKit
import UIKit
class CloudKitService {
    
    enum CloudKitServiceError: Error {
        case recordNotInDatabase
        case assetMissing
        case assetLoadFailed
    }
    
    private let container = CKContainer(identifier: "iCloud.com.mariareyna.memories")
    private lazy var database = container.publicCloudDatabase
    
    public func saveOff(_ memory: Memory) async throws {
        let record = CKRecord(recordType: "Memory", recordID: .init(recordName: memory.id))
        
        record["name"] = memory.name
        record["description"] = memory.description
        record["date"] = memory.date
        // Save image as CKAsset if present
        if let image = memory.image,
           let data = image.jpegData(compressionQuality: 0.9) {
            // Use a unique filename to avoid collisions.
            let filename = UUID().uuidString + ".jpg"
            guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(filename)
                    
            else {
                // If for some reason we can't get a URL, just save the record without an image.
                try await database.save(record)
                return
            }
            
            do {
                try data.write(to: url, options: .atomic)
                let asset = CKAsset(fileURL: url)
                record["image"] = asset
            } catch {
                print("Failed writing image to temp file: \(error)")
            }
        }
        
        _ = try await database.save(record)
    }
    
    public func fetchMemory() async throws -> [Memory] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Memory", predicate: predicate)
        // this line can sort by date when i make a change to add date as of rn no
        
        
        let (matchResults, _) = try await database.records(matching: query)
        let results = matchResults.map { $0.1 }
        let records = results.compactMap { try? $0.get() }
        
        let memories: [Memory] = records.compactMap { record in
            let id = record.recordID.recordName
            guard let name = record["name"] as? String,
                  let description = record["description"] as? String,
                  let date = record["date"] as? Date else {
                
                // If the record is malformed, provide a safe fallback so the list still renders.
                return Memory(id: id, name: "N/A", image: UIImage(named: "defaultImage") ?? .default, description: "N/A", date: Date.now)
            }
            
            var image: UIImage? = nil
            if let asset = record["image"] as? CKAsset,
               let fileURL = asset.fileURL {
                do {
                    let data = try Data(contentsOf: fileURL)
                    image = UIImage(data: data)
                } catch {
                    print("Failed to load CKAsset data for record \(id): \(error)")
                }
            }
            
            return Memory(id: id, name: name, image: image ?? .default, description: description, date: date)
        }
        return memories
    }
    
    public func addNewMemory(_ memory: Memory) async throws {
        guard let fetchedRecord = try? await database.record(for: .init(recordName: memory.id)) else {
            throw CloudKitServiceError.recordNotInDatabase
        }
        // Update in place to avoid losing server fields (like system fields).
        fetchedRecord["name"] = memory.name
        fetchedRecord["description"] = memory.description
        fetchedRecord["date"] = memory.date
        
        if let image = memory.image,
           let data = image.jpegData(compressionQuality: 0.9) {
            let filename = UUID().uuidString + ".jpg"
            if let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(filename) {
                do {
                    try data.write(to: url, options: .atomic)
                    fetchedRecord["image"] = CKAsset(fileURL: url)
                } catch {
                    print("Failed writing image for update: \(error)")
                }
            }
        }
        
        _ = try await database.modifyRecords(saving: [fetchedRecord], deleting: [])
    }
    
    public func deleteMemory(_ memory: Memory) async throws {
        print("Memory id: \(memory.id)")
        guard let fetchedRecord = try? await database.record(for: .init(recordName: memory.id)) else {
            throw CloudKitServiceError.recordNotInDatabase
        }
        _ = try await database.modifyRecords(saving: [], deleting: [fetchedRecord.recordID])
    }
    
   
}

