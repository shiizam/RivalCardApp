////
////  CardsGridView.swift
////  Rivals
////
////  Created by Cody hancock on 2/24/24.
////
//
//import SwiftUI
//
//import SwiftUI
//import SwiftData
//import FirebaseStorage
//
//
//struct CardsGridView: View {
//    @Environment(\.modelContext) private var modelContext
//    @AppStorage("lastFetched") private var lastFetched: Double = Date.now.timeIntervalSince1970
//    @Query(sort: \Card.id) private var cards: [Card]
//    @State private var searchText: String = ""
//    var filteredCards: [Card] {
//        guard searchText.isEmpty else { return cards }
//        return cards.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
//    }
//    
//    @StateObject var gridColumns = ClansGridViewModel()
//    @State private var imageURLs: [URL] = []
//    @State private var loadedImageCount = 0
//    @StateObject private var imageCache = ImageCache()
//
//    private let storageRef = Storage.storage().reference(withPath: "cards/") // Get images from Firebase
//    private let maxImagesPerPage = 15 // Adjust the number of images to load per page
//    
//    
//    var body: some View {
//        NavigationStack {
//            
//            ZStack {
//                BackgroundView()
//                VStack {
//                    if imageURLs.isEmpty {
//                        Text("Loading...")
//                    } else {
//                        ScrollView {
//                            LazyVGrid(columns: gridColumns.columns, spacing: 20) {
//                           
//                                ForEach(imageURLs.prefix(loadedImageCount), id: \.self) { url in
//                                    if let image = imageCache[url] {
//                                        Image(uiImage: image)
//                                            .resizable()
//                                            .frame(width: 315, height: 450)
//                                            .cornerRadius(10)
////                                        Text("\(cards[$0].name)")
////                                            .foregroundStyle(.white)
////                                            .bold()
//                                    } else {
//                                        ProgressView()
//                                            .onAppear {
//                                                downloadImage(url)
//                                            }
//                                    }
//                                }
//                                if loadedImageCount < imageURLs.count {
//                                    ProgressView()
//                                        .onAppear(perform: loadMoreImagesIfNeeded)
//                                }
//                            }
//                            .padding()
//
//                            .searchable(text: $searchText, prompt: "Search Cards")
//                        }
//                    }
//                }
//                .onAppear {
//                    fetchImageURLs()
//                }
//
//            }
//            .navigationTitle("VTM: Rivals")
//            .task {
//                do {
//                    if hasExceededLimit() || cards.isEmpty {
//                        clearCardData()
//                        try await fetchCardData()
//                        print(cards)
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
//
//    func fetchImageURLs() {
//        storageRef.listAll { result, error in
//            if let error = error {
//                print("Error listing files: \(error)")
//                return
//            }
//            
//            guard let result = result else { return }
//            
//            let imageRefs = result.items
//            var urls: [URL] = []
//            
//            for imageRef in imageRefs {
//                imageRef.downloadURL { url, error in
//                    if let error = error {
//                        print("Error getting download URL: \(error)")
//                        return
//                    }
//                    if let url = url {
//                        urls.append(url)
//                        if urls.count == imageRefs.count {
//                            imageURLs = urls.sorted { $0.lastPathComponent < $1.lastPathComponent }
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    func loadMoreImagesIfNeeded() {
//        let remainingImages = imageURLs.count - loadedImageCount
//        let imagesToLoad = min(maxImagesPerPage, remainingImages)
//        if imagesToLoad > 0 {
//            loadedImageCount += imagesToLoad
//        }
//    }
//    
//    func downloadImage(_ url: URL) {
//        let _ = storageRef.child(url.lastPathComponent).getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if let error = error {
//                print("Error downloading image: \(error)")
//                return
//            }
//            if let data = data, let image = UIImage(data: data) {
//                // Store the downloaded image in the cache
//                imageCache[url] = image
//            }
//        }
//    }
//}
//
//
//
//#Preview {
//    CardsGridView()
//        .modelContainer(for: [Card.self])
//}
//
//extension CardsGridView {
//    
//    func fetchCardData() async throws {
//        let url = URL(string: "http://10.0.0.244:8000/cards")!
//        let request = URLRequest(url: url)
//        let (data, _) = try await URLSession.shared.data(for: request)
//        
//        let cards = try JSONDecoder().decode([Card].self, from: data)
//        
//        cards.forEach { modelContext.insert($0) }
//        
//        lastFetched = Date.now.timeIntervalSince1970
//    }
//    
//    
//    func hasExceededLimit() -> Bool {
//        let timeLimit = 86400
//        let currentTime = Date.now
//        let lastFetchedTime = Date(timeIntervalSince1970: lastFetched)
//        
//        guard let differenceInMins = Calendar.current.dateComponents([.second], from: lastFetchedTime, to: currentTime).second else {
//            return false
//        }
//        
//        return differenceInMins >= timeLimit
//    }
//    
//    func clearCardData() {
//        _ = try? modelContext.delete(model: Card.self)
//    }
//}
