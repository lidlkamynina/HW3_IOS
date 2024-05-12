import Foundation

final class ContentViewModel: ObservableObject {
    @Published var showWarning = false
    
    init() {
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
                showWarning = remoteConfig.configValue(forKey: "showWarning").boolValue
            case .successUsingPreFetchedData:
                showWarning = remoteConfig.configValue(forKey: "showWarning").boolValue
            case .error:
                print("Error fetching remote config")
            @unknown default:
                fatalError()
            }
        } catch {
            print ("Error fetching remote config: \(error.localizedDescription)")
        }
    }
}


