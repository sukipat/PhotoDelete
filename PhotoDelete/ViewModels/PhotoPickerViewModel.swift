//
//  PhotoPicker.swift
//  PhotoDelete
//
//  Created by Suki on 10/24/23.
//

import SwiftUI
import PhotosUI
import Combine

// MARK: - Properties
@Observable
class PhotoPickerViewModel: ObservableObject {
    private var assets: PHFetchResult<PHAsset>? = nil
    private let photoAuthorizer = PhotoAuthorizer()
    var asset: PHAsset? = nil
    var assetURL: URL? = nil
    private var assetCollection: PHAssetCollection? = nil

    init() {
        self.photoAuthorizer.checkAuth()
        self.setupCustomAlbum()
    }
}

// MARK: - Public Auth Functions
extension PhotoPickerViewModel {
    func checkAuthandGet() {
        self.photoAuthorizer.checkAuth()
        if self.photoAuthorizer.getAuthStatus() != .notPermitted {
            self.getAssets()
        }
    }
    
    func getAuthStatus() -> AuthStatusCodes {
        return self.photoAuthorizer.getAuthStatus()
    }
}

// MARK: - Album Creation and Modification
extension PhotoPickerViewModel {
    private func setupCustomAlbum() {
        if albumExists() { return }
        PHPhotoLibrary.shared().performChanges {
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: "Photo Delete")
        } completionHandler: { success, error in
            if !success { print("Error creating album: \(String(describing: error)).") }
        }
        if albumExists() { return }
    }
    
    private func albumExists() -> Bool {
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: .none)
        let albumsCount = 0..<albums.count
        for index in albumsCount {
            let album = albums.object(at: index)
            if album.localizedTitle == "Photo Delete" {
                print("Found the album!!")
                self.assetCollection = album
                return true
            }
        }
        return false
    }
    
    func addToAlbum() async {
        await self.asset?.getURL(completionHandler: { responseURL in
            if let url = responseURL {
                let urlString = String(url.absoluteString.dropFirst(7))
                self.assetURL = URL(string: urlString)
                print(urlString)
                PHPhotoLibrary.shared().performChanges {
                    if let url = self.assetURL {
                        let creationRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
                        if let collection = self.assetCollection {
                            let addAssetRequest = PHAssetCollectionChangeRequest(for: collection)
                            addAssetRequest?.addAssets([creationRequest?.placeholderForCreatedAsset!] as NSArray)
                        }
                        self.assetURL = nil
                    }
                } completionHandler: { success, error in
                    if !success { print("Error creating the asset: \(String(describing: error))") }
                    if success { print("ADDED TO ALBUM YAY")}
                }
            }
        })
    }
}

// MARK: - Asset Fetching
extension PhotoPickerViewModel {
    private func getAssets() {
        if photoAuthorizer.getAuthStatus() == .notPermitted { return }
        let fetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        assets = fetchResult
    }
    
    func getRandomAsset() {
        if assets == nil {
            return
        }
        let randomIndex = Int.random(in: 0..<assets!.count)
        asset = assets?.object(at: randomIndex)
//        await self.asset?.getURL(completionHandler: { responseURL in
//            if let url = responseURL {
//                let urlString = String(url.absoluteString.dropFirst(7))
//                self.assetURL = URL(string: urlString)
//                print(urlString)
//            }
//        })
    }
}
