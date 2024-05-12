import SwiftUI

class TabController: ObservableObject {
    @Published var activeTab = Tab.photo
    
    func open(_ tab: Tab) {
        activeTab = tab
    }
}

enum Tab {
    case photo
    case video
    case map
}
