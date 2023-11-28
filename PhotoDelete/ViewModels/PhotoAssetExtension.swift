//
//  PhotoAssetExtension.swift
//  PhotoDelete
//
//  Created by Suki on 10/26/23.
//

import Foundation
import PhotosUI
import Combine

// MARK: - PHAsset Extension
extension PHAsset {
    func getThumbnailImage() -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        manager.requestImage(for: self, targetSize: CGSize(width:500, height: 500), contentMode: .aspectFit, options: option) {(result, info) -> Void in
            thumbnail = result!
        }
        return thumbnail
    }
}
