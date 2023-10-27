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
    @State private var showingPreview = false
    
    var body: some View {
        if let asset = viewModel.asset {
            Image(uiImage: asset.getThumbnailImage())
        } else {
            Text("Failed to get Image")
        }
    }
}

#Preview {
    PhotoView()
}
