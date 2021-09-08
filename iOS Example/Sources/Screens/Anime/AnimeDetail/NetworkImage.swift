//
//  NetworkImage.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/31/21.
//

import Combine
import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct NetworkImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var imageData: Data?
    let height: CGFloat

    init(withURL url: String, height: CGFloat) {
        self.height = height
        imageLoader = ImageLoader(urlString: url)
    }

    var body: some View {
        Group {
            if let imageData = imageData {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: height)
                    .clipped()
            } else {
                ProgressView()
            }
        }
        .onReceive(imageLoader.didChange) { data in
            self.imageData = data
        }
    }
}
