//
//  PreviewView.swift
//  PhotoDelete
//
//  Created by Suki on 10/25/23.
//

import QuickLook
import SwiftUI

struct PreviewController: UIViewControllerRepresentable {
    @EnvironmentObject var viewModel: PhotoPickerViewModel
    @State var assetURL: URL?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = QLPreviewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

class Coordinator: QLPreviewControllerDataSource {
    let parent: PreviewController
    
    init(parent: PreviewController) {
        self.parent = parent
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        if let url = parent.assetURL {
            return url as NSURL
        }
        return URL(string: "https://apple.com")! as NSURL
    }
}
