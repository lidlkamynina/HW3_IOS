import SwiftUI

struct ContentView: View {
    @StateObject private var tabController = Tabs()
    @ObservedObject var viewModel = ViewModel()
    
        var body: some View {
            TabView(selection: $tabController.activeTab) {
                // MARK: Profile View
                ProfileView(viewModel: viewModel)
                    .tag(Tab.profile)
                    .tabItem { Label("", systemImage: "person") }
                // MARK: Image View
                ImageView(viewModel: viewModel)
                    .tag(Tab.images)
                    .tabItem { Label("", systemImage: "photo") }
                // MARK: Video View
                VideoView(viewModel: viewModel)
                    .tag(Tab.videos)
                    .tabItem { Label("", systemImage: "video") }
                MapView(viewModel: viewModel)
                    .tag(Tab.map)
                    .tabItem { Label("", systemImage: "map") } 
            }
            .environmentObject(tabController)
            .sheet(isPresented: $viewModel.showWarning) {
                UserWarningView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
