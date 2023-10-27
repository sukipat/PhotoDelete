//
//  PhotoDeleteApp.swift
//  PhotoDelete
//
//  Created by Suki on 10/24/23.
//

import SwiftUI

@main
struct PhotoDeleteApp: App {
    @State private var photoPickerViewModel = PhotoPickerViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(photoPickerViewModel)
        }
    }
}
