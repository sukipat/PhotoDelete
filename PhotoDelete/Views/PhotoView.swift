//
//  PhotoView.swift
//  PhotoDelete
//
//  Created by Suki on 10/24/23.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    @EnvironmentObject var viewModel: PhotoPickerViewModel
    @State private var image: Image?
    
    var body: some View {
        ZStack {
            if let thumbnailImage = viewModel.asset?.getThumbnailImage() {
                Image(uiImage: thumbnailImage)
            } else {
                ProgressView()
            }
        }
        .task {
            await getRandomAsset()
        }
    }
}

extension PhotoView {
    func getRandomAsset() async {
        viewModel.getRandomAsset()
    }
}

#Preview {
    PhotoView()
}
