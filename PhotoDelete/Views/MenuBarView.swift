//
//  MenuBarView.swift
//  PhotoDelete
//
//  Created by Suki on 10/24/23.
//

import SwiftUI

struct MenuBarView: View {
    @EnvironmentObject var viewModel: PhotoPickerViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                print("Trash Button Pressed")
            }, label: {
                Image(systemName: "square.stack")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
            })
            Spacer()
            Button(action: {
                viewModel.getRandomAsset()
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:30)
            })
            Spacer()
            Button(action: {
                print("Setting Button Pressed")
            }, label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28)
            })
        }
        .padding()
        Divider()
    }
}

#Preview {
    MenuBarView()
}
