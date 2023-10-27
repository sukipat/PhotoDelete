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
    var assets: PHFetchResult<PHAsset>? = nil
    private let photoAuthorizer = PhotoAuthorizer()
    var asset: PHAsset? = nil

    init() {
        self.photoAuthorizer.checkAuth()
    }
}

// MARK: - Public Functions
extension PhotoPickerViewModel {
    func checkAuthandGet() {
        self.photoAuthorizer.checkAuth()
        if self.photoAuthorizer.getAuthStatus() != .notPermitted {
            self.getAssets()
            self.getRandomAsset()
        }
    }
}

// MARK: - Asset Fetching
extension PhotoPickerViewModel {
    private func getAssets() {
        if photoAuthorizer.getAuthStatus() == .notPermitted { return }
        let fetchResult = PHAsset.fetchAssets(with: nil)
        assets = fetchResult
    }
    
    func getRandomAsset() {
        if assets == nil {
            asset = nil
            return
        }
        let randomIndex = Int.random(in: 0..<assets!.count)
        asset = assets?.object(at: randomIndex)        
    }
}
