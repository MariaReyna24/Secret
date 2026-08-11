//
//  NavigationModel.swift
//  Secret
//
//  Created by Maria Reyna on 2/10/26.
//

import Foundation
import SwiftUI

@Observable
class Router {
    var navigationPath = NavigationPath()
    
    func navigateTo(route: Route) {
           navigationPath.append(route)
       }
    // .memoryDetailView now requires a Memory object for detail display.
    enum Route: Hashable {
        case selectionView
        case selectMusic
        case mainView
        case memoryView
        case memoryDetailView(memory:Memory)
    }
}

