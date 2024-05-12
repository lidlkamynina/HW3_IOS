import UIKit

struct Profile: Codable {
    var avatar_url: String
    var name: String?
    var bio: String?
    var company: String?
    var location: String?
    
    var avatarImage: UIImage? {
        guard let url = URL(string: avatar_url) else {
            return nil
        }
        
        var image: UIImage?
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                image = UIImage(data: data)
            }
            semaphore.signal()
        }.resume()
        
        // Wait for the data task to finish loading the image
        _ = semaphore.wait(timeout: .distantFuture)
        
        return image
    }

    
    var workInfo: [String] {
        var info: [String] = []
        
        if let company = company {
            info.append(company)
        }
        
        if let location = location {
            info.append(location)
        }
        
        return info
    }
}

func fetchProfile(completion: @escaping (Profile?) -> Void) {
    guard let url = URL(string: "https://api.github.com/users/ioslekcijas") else {
        print("Invalid URL")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let profile = try decoder.decode(Profile.self, from: data)
                DispatchQueue.main.async {
                    completion(profile)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        } else if let error = error {
            print(error)
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    task.resume()
}
