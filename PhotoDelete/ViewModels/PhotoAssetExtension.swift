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
    
    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)) async {
            if self.mediaType == .image {
                let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
                options.isNetworkAccessAllowed = true
                options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                    return true
                }
                self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                    completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
                })
            } else if self.mediaType == .video {
                let options: PHVideoRequestOptions = PHVideoRequestOptions()
                options.version = .original
                options.isNetworkAccessAllowed = true
                PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                    if let urlAsset = asset as? AVURLAsset {
                        let localVideoUrl: URL = urlAsset.url as URL
                        completionHandler(localVideoUrl)
                    } else {
                        completionHandler(nil)
                    }
                })
            }
        
    }
}
