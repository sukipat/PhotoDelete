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
    func getThumbnailImage() -> UIImage{
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        manager.requestImage(for: self, targetSize: CGSize(width:400, height: 400), contentMode: .aspectFit, options: option) {(result, info) -> Void in
            thumbnail = result!
        }
        return thumbnail
    }
    
    func requestAssetUrl() -> AnyPublisher<URL, Error> {
            Future { [self] promise in
                if self.mediaType == .image {
                    self.requestContentEditingInput(with: nil) { input, info in
                        if let input = input, let url = input.fullSizeImageURL {
                            promise(.success(url))
                        } else {
                            promise(.failure(Errors.urlNotAvailable))
                        }
                    }
                } else if self.mediaType == .video {
                    let options: PHVideoRequestOptions = PHVideoRequestOptions()
                    options.version = .original
                    PHImageManager.default().requestAVAsset(forVideo: self, options: options) { asset, audio, info in
                        if let urlAsset = asset as? AVURLAsset {
                            let localVideoUrl = urlAsset.url
                            promise(.success(localVideoUrl))
                        } else {
                            promise(.failure(Errors.urlNotAvailable))
                        }
                    }
                } else {
                    promise(.failure(Errors.mediaNotSupported))
                }
            }.eraseToAnyPublisher()
        }
    
      enum Errors: Error {
          case urlNotAvailable
          case mediaNotSupported
      }
}

