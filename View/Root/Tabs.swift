import SwiftUI

class Tabs: ObservableObject {
    @Published var activeTab = Tab.profile

    func open(_ tab: Tab) {
        activeTab = tab
    }
}

enum Tab {
    case profile
    case images
    case videos
    case map
}
