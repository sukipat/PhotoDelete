//
//  AlbumView.swift
//  PhotoDelete
//
//  Created by Suki on 11/28/23.
//

import SwiftUI
import PhotosUI

struct AlbumView: View {
    @EnvironmentObject var viewModel: PhotoPickerViewModel
    var assets: PHFetchResult<PHAsset>? = nil
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                viewModel.showingPreview.toggle()
            }, label: {
                Text("Done")
                    .font(.system(size: 18))
            })
        }
        .padding(.top)
        .padding(.trailing)
        Divider()
        ScrollView {
            if let imageCollection = viewModel.assetCollection {
                let fetchOptions = PHFetchOptions()
                let assets = PHAsset.fetchAssets(in: imageCollection, options: fetchOptions)
                let other = print(assets.count)
                List {
                    ForEach(0..<assets.count) { index in
                        AlbumCellView(asset: assets.object(at: index))
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    AlbumView()
}
