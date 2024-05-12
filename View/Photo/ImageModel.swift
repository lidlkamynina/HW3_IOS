import SwiftUI

class ImageModel: ObservableObject {
    @Published var imageUrls: [String] = []
    @Published var images: [UIImage] = []
    @Published var videoUrls: [String] = []
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func fetchImageUrls(owner: String, repo: String) {
        let urlString = "https://api.github.com/repos/\(owner)/\(repo)/contents"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  let decodedResponse = try? JSONDecoder().decode([GitHubFile].self, from: data) else {
                return
            }
            
            let jpgUrls = decodedResponse.filter { file in
                file.type == "file" && file.name.hasSuffix(".jpg")
            }.map { file in
                file.downloadUrl
            }
            
            DispatchQueue.main.async {
                self?.imageUrls = jpgUrls
            }
        }
        
        task.resume()
    }
    
    func fetchImages(completion: @escaping () -> Void) {
        let queue = DispatchQueue(label: "imageDownloadQueue", attributes: .concurrent)
        let group = DispatchGroup()
        
        for imageUrl in imageUrls {
            guard let url = URL(string: imageUrl) else {
                continue
            }
            
            // Check if the image is already in the cache
            if let imageFromCache = imageCache.object(forKey: imageUrl as NSString) {
                images.append(imageFromCache)
                continue
            }
            
            group.enter()
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                defer {
                    group.leave()
                }
                
                guard let data = data,
                      let image = UIImage(data: data) else {
                    return
                }
                
                // Save the image to a file in the documents directory
                do {
                    let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    
                    // Use the last path component of the URL as the filename
                    let fileName = url.lastPathComponent
                    
                    let fileUrl = documentsDirectory.appendingPathComponent(fileName)
                    try data.write(to: fileUrl)
                    
                    // Add the image to the cache
                    self?.imageCache.setObject(image, forKey: imageUrl as NSString)
                    
                    // Add the image to the array of downloaded images
                    DispatchQueue.main.async {
                        self?.images.append(image)
                    }
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
            
            task.resume()
        }
        
        group.notify(queue: queue) {
            completion()
        }
    }

}

struct GitHubFile: Decodable {
    let name: String
    let type: String
    let downloadUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case downloadUrl = "download_url"
    }
}
