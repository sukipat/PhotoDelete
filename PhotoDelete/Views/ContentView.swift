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
    @State private var dragAmount = CGSize.zero
    @State private var opacity = 1.0
    
    var body: some View {
        VStack{
            MenuBarView()
            PhotoView()
                .offset(dragAmount)
                .opacity(opacity)
                .gesture(
                    DragGesture()
                        .onChanged {
                            dragAmount = $0.translation
                            opacity = 1.0 - (UIScreen.main.bounds.width/(2*abs($0.translation.width)))
                        }
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
                            opacity = 1.0
                        }
                )
                .animation(.bouncy, value: dragAmount)
                .animation(.easeInOut, value: opacity)
            Spacer()
        }
        .task {
            viewModel.checkAuthandGet()
        }
        .sheet(isPresented: $viewModel.showingPreview) {
            AlbumView()
        }
    }
}


#Preview {
    ContentView()
}
