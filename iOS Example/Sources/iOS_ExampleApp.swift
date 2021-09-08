//
//  iOS_ExampleApp.swift
//  iOS Example
//
//  Created by Mehdi Sohrabi on Sep 8, 2021.
//

import SwiftUI

@main
struct iOS_ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environmentObject(AnimeListBloc(.initial))
        }
    }
}
