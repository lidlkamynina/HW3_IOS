import SwiftUI

struct TabView: View {
    TabView(selection: $tabController.activeTab) {
        ContentView()
            .tag(Tab.home)
            .tabItem {
                Label("", systemImage: "person.fill")
            }
        PhotoView()
            .tag(Tab.photo)
            .tabItem {
                Label("", sytemImage: "photo")
            }
        VideoView()
            .tag(Tab.video)
            .tabItem {
                Label("", sytemImage: "video")
            }
        MapView()
            .tag(Tab.map)
            .tabItem {
                Label("", systemImage: "map.fill")
            }
    }
}

#Preview {
    TabView()
}

