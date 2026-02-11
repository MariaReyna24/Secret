//
//  DataModel.swift
//  Secret
//
//  Created by Maria Reyna on 2/5/26.
//

import Foundation
import SwiftUI

struct AudioFile: Identifiable, Hashable {
    var id = UUID()
    var songTitle: String
    var fileName: String
    let fileExtension: String = "m4a"
    var recordImage: String
    
    var url: URL? {
          Bundle.main.url(forResource: fileName, withExtension: fileExtension)
      }
}
