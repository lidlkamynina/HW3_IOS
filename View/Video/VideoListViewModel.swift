import Foundation

extension VideoView {
    @MainActor
    class VideoViewModel: ObservableObject {
        let repo = UserRepository()
        
        @Published var helloText = ""
        
        init() {
        }
        
        func loadData() {
            if let name = repo.getVideos().first?.userName {
                helloText = "Hello, \(name)"
            }
        }
    }
}
