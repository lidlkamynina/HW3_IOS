import SwiftUI
import MapKit

struct MapId: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @ObservedObject private var locationManager = MapLocation()
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Title
                ViewTitleText(text: "minestagram")
                    .foregroundColor(.black)
                    .padding(.top, 120)
                    .background(Color.yellow)
                
                Map(selection: $locationManager.selectedMarkerId) {
                    UserAnnotation()
                    ForEach(locationManager.locations) { location in
                        Marker(location.name, coordinate: location.coordinate)
                    }
                }

                VStack {
                    if let userLocation = locationManager.userLocation {
                        infoView(text: "Lat: \(userLocation.latitude) | Long: \(userLocation.longitude)")
                    }
                    if let selectedMarkerId = locationManager.selectedMarkerId,
                       let selectedMarker = locationManager.locations.first(where: { $0.id == selectedMarkerId }) {
                        infoView(text: "Selected marker: \(selectedMarker.name)")
                    }
                }
            }
        }
                    }
        @ViewBuilder func infoView(text: String) -> some View {
            Text(text)
                .padding()
                .background(Color.white.opacity(0.85))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }

#Preview {
    ContentView()
}
    
