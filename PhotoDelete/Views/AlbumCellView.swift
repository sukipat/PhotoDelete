//
//  AlbumCellView.swift
//  PhotoDelete
//
//  Created by Suki on 11/29/23.
//

import SwiftUI
import PhotosUI

struct AlbumCellView: View {
    var asset: PHAsset?
    var body: some View {
        if let imageAsset = asset {
            Image(uiImage: imageAsset.getThumbnailImage(imageWidth: 160, imageHeight: 160))
                .resizable()
                .scaledToFit()
                .clipShape(Rectangle())
                .frame(width: 160, height: 160)
        }
    }
}

#Preview {
    AlbumCellView()
}
