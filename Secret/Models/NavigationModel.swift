//
//  NavigationModel.swift
//  Secret
//
//  Created by Maria Reyna on 2/10/26.
//

import SwiftUI

@Observable
class Router {
    var navigationPath = NavigationPath()
    
    func navigateTo(route: Route) {
           navigationPath.append(route)
       }
    enum Route:Hashable {
        case selectionView
        case selectMusic
        case mainView
    }
}
