//
//  PhotoAuth.swift
//  PhotoDelete
//
//  Created by Suki on 10/26/23.
//

import Foundation
import PhotosUI

// MARK: - PhotoAuthorizer
class PhotoAuthorizer {
    private var authStatus: AuthStatusCodes = .notPermitted
    
    func checkAuth() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case PHAuthorizationStatus.authorized:
                self.authStatus = .permitted
            case PHAuthorizationStatus.limited:
                self.authStatus = .limited
            case PHAuthorizationStatus.restricted:
                self.authStatus = .notPermitted
            case PHAuthorizationStatus.denied:
                self.authStatus = .notPermitted
            case PHAuthorizationStatus.notDetermined:
                self.authStatus = .notPermitted
            @unknown default:
                break
            }
        }
    }
    
    func getAuthStatus() -> AuthStatusCodes {
        return self.authStatus
    }
    
}

// MARK: - AuthStatusCodes
enum AuthStatusCodes {
    case permitted
    case limited
    case notPermitted
}
