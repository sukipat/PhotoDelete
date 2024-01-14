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
        GeometryReader { proxy in
            ZStack {
                if let thumbnailImage = viewModel.asset?.getThumbnailImage(imageWidth: 500, imageHeight: 500) {
                        Image(uiImage: thumbnailImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.white, lineWidth: 4)
                            )
                } else {
                    ProgressView()
                }
            }
            .task {
                getRandomAsset()
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
        }
    }
}

extension PhotoView {
    func getRandomAsset() {
        viewModel.getRandomAsset()
    }
}

#Preview {
    PhotoView()
}
