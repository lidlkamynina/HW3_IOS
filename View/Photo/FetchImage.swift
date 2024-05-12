//
//  FetchImage.swift
//  HW3
//
//  Created by LIDZIYA KAMYNINA  on 04/05/2024.
//

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
                    
                    // Fetch GPS coordinates
                    if let coordinates = self?.getGpsCoordinates(fromURL: fileUrl){
                        print("Latitude: \(coordinates.latitude), Longitude: \(coordinates.longitude)")
                    }
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

