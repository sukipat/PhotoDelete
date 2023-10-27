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
    @State private var showingPreview = false
    @State private var url: URL?
    
    var body: some View {
        VStack{
            MenuBarView()
            PhotoView()
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.width < 10 {
                            viewModel.addToAlbum()
                            viewModel.getRandomAsset()
                            viewModel.assetURL = nil
                        }
                        
                        if value.translation.width > 10 {
                            DispatchQueue.global().async {
                                viewModel.getRandomAsset()
                                viewModel.assetURL = nil
                            }
                        }
                    }))
            Text(viewModel.assetURL?.absoluteString ?? "No URL")
            Spacer()
        }
        .task {
            viewModel.checkAuthandGet()
        }
        .sheet(isPresented: $showingPreview) {
            PreviewController()
        }

    }
}


#Preview {
    ContentView()
}
