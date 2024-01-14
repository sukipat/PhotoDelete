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
    var assetCollection: PHAssetCollection? = nil
    var showingPreview:Bool = false

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
        let fetchOptions = PHFetchOptions()
        let albumName = "Photo Delete"
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        if let firstObject = albums.firstObject{
                self.assetCollection = firstObject
                return true
            }
        return false
    }
    
    func addToAlbum() async {
        PHPhotoLibrary.shared().performChanges {
            if let assetToAdd = self.asset {
                if let collection = self.assetCollection {
                    let addAssetRequest = PHAssetCollectionChangeRequest(for: collection)
                    addAssetRequest?.addAssets([assetToAdd] as NSFastEnumeration)
                }
            }
        } completionHandler: { success, error in
            if !success { print("Error creating the asset: \(String(describing: error))") }
            if success { self.getRandomAsset() }
        }
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
    }
}
