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
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack{
            MenuBarView()
            PhotoView()
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { offset in
                            if offset.translation.width < 10 {
                                Task {
                                    await viewModel.addToAlbum()
                                }
                            }
    
                            if offset.translation.width > 10 {
                                viewModel.getRandomAsset()
                            }
                            dragAmount = .zero
                        }
                )
                .animation(.bouncy, value: dragAmount)
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
