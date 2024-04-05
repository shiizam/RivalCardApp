//
//  CardsHListView.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI
import FirebaseStorage


struct CardsHListView: View {
    
    @State private var imageURLs: [URL] = []
    @State private var loadedImageCount = 0
    @StateObject private var imageCache = ImageCache()

    private let storageRef = Storage.storage().reference(withPath: "cards/")
    private let maxImagesPerPage = 15 // Adjust the number of images to load per page
    
    var body: some View {
        ZStack {
            
            BackgroundView()
            
            if imageURLs.isEmpty {
                Text("Loading...")
            } else {
                
                ScrollView(.horizontal) {
                    
                    LazyHStack(content: {
                        
                        ForEach(imageURLs.prefix(loadedImageCount), id: \.self) { url in
                            if let image = imageCache[url] {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 350)
                                    .cornerRadius(10)
                                    .padding()
                                
                            } else {
                                ProgressView()
                                    .onAppear {
                                        downloadImage(url)
                                    }
                            }
                        }
                    })
//                    .scrollTargetLayout()
                    
                    if loadedImageCount < imageURLs.count {
                        ProgressView()
                            .onAppear(perform: loadMoreImagesIfNeeded)
                    }
                }
//                .scrollTargetBehavior(.viewAligned)
//                .safeAreaPadding(.horizontal, 60)
            }
        }
        .onAppear {
            fetchImageURLs()
        }
    }
    
    func fetchImageURLs() {
        storageRef.listAll { result, error in
            if let error = error {
                print("Error listing files: \(error)")
                return
            }
            
            guard let result = result else { return }
            
            let imageRefs = result.items
            var urls: [URL] = []
            
            for imageRef in imageRefs {
                imageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    }
                    if let url = url {
                        urls.append(url)
                        if urls.count == imageRefs.count {
                            imageURLs = urls.sorted { $0.lastPathComponent < $1.lastPathComponent }
                        }
                    }
                }
            }
        }
    }
    
    func loadMoreImagesIfNeeded() {
        let remainingImages = imageURLs.count - loadedImageCount
        let imagesToLoad = min(maxImagesPerPage, remainingImages)
        if imagesToLoad > 0 {
            loadedImageCount += imagesToLoad
        }
    }
    
    func downloadImage(_ url: URL) {
        let _ = storageRef.child(url.lastPathComponent).getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                // Store the downloaded image in the cache
                imageCache[url] = image
            }
        }
    }
}

#Preview {
    CardsHListView()
}


class ImageCache: ObservableObject {
    @Published private var cache: [URL: UIImage] = [:]
    
    subscript(_ key: URL) -> UIImage? {
        get { cache[key] }
        set { cache[key] = newValue }
    }
}
