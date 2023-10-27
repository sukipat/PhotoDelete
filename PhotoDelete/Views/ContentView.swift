//
//  ContentView.swift
//  PhotoDelete
//
//  Created by Suki on 10/24/23.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @EnvironmentObject var viewModel: PhotoPickerViewModel
    
    var body: some View {
        VStack{
            MenuBarView()
            PhotoView()
            Spacer()
        }
        .onAppear(perform: {
            viewModel.checkAuthandGet()
        })
    }
}


#Preview {
    ContentView()
}
