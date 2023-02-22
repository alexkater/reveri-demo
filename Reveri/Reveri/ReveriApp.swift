//
//  ReveriApp.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 21/2/23.
//

import SwiftUI

@main
struct ReveriApp: App {

    var body: some Scene {
        WindowGroup {
            ProductListView(viewModel: .init())
        }
    }
}
