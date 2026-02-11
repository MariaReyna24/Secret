//
//  Memory.swift
//  Secret
//
//  Created by Maria Reyna on 2/9/26.
//

import Foundation
import SwiftUI
import UIKit
struct Memory: Identifiable, Hashable {
    var id: String
    var name: String
    var image: UIImage?
    var description: String
    var date: Date
    
    init(id: String = UUID().uuidString, name: String, image: UIImage, description: String, date: Date) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.date = date
        
    }

    static func == (lhs: Memory, rhs: Memory) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.description == rhs.description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
    }
}
