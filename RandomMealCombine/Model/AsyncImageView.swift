//
//  AsyncImageView.swift
//  RandomMealCombine
//
//  Created by Maxim Macari on 21/10/2020.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    
    @StateObject private var imageLoader = ImageLoader()
    
    
    @Binding var urlString: String?
    
    init(urlString: Binding<String?>){
        self._urlString = urlString
    }
    
    var body: some View {
        Group{
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .padding(5)
                    
            } else {
                Text("No image")
            }
        }
        .onChange(of: urlString, perform : { value in
            if let urlString = urlString, let url = URL(string: urlString){
                imageLoader.url = url
                imageLoader.load()
            }
        })
        
    }
}

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    var url: URL?
    
    func load() {
        guard let url = url else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data)}
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$image)
    }
    
    
}
