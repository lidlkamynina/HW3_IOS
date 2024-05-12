import SwiftUI
import Foundation
import Firebase

class ViewModel: ObservableObject {
    @Published var profile: Profile?
    @Published var imageUrls: [String]?
    @Published var videoUrls: [String]?
    @Published var showWarning = false
    
    init() {
        fetchProfile { profile in
            DispatchQueue.main.async {
                self.profile = profile
            }
        }
        Task {
            await loadConfig()
        }
    }
    
    private func loadConfig() async {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        do {
            let config = try await remoteConfig.fetchAndActivate()
            
            switch config {
            case .successFetchedFromRemote:
                DispatchQueue.main.async {
                    self.showWarning = remoteConfig.configValue(forKey: "showWarning").boolValue
                }
            case .successUsingPreFetchedData:
                DispatchQueue.main.async {
                    self.showWarning = remoteConfig.configValue(forKey: "showWarning").boolValue
                }
            case .error:
                print("Error fetching remote config")
            @unknown default:
                fatalError()
            }
        } catch{
            print ("Error fetching remote config: \(error.localizedDescription)")
        }
    }
    
    func fetchImageUrls(owner: String, repo: String) {
        let url = "https://api.github.com/repos/\(owner)/\(repo)/contents/"
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let files = try JSONDecoder().decode([GitHubFile].self, from: data)
                let jpgFiles = files.filter { $0.name.hasSuffix(".jpg") }
                let urls = jpgFiles.map { $0.downloadUrl }
                
                DispatchQueue.main.async {
                    self.imageUrls = urls
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchVideoUrls(owner: String, repo: String) {
        let url = "https://api.github.com/repos/\(owner)/\(repo)/contents/"
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let files = try JSONDecoder().decode([GitHubFile].self, from: data)
                let mp4Files = files.filter { $0.name.hasSuffix(".mp4") || $0.name.hasSuffix(".mkv") }
                let urls = mp4Files.map { $0.downloadUrl }
                
                DispatchQueue.main.async {
                    self.videoUrls = urls
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
