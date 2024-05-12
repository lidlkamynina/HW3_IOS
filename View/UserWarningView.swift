import SwiftUI

struct UserWarningView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var nightModeManager: NightModeManager
    @State var isNightModeEnabled = false // Local state to control night mode

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .padding()
            }
            
            ViewTitleText(text: "What's New in the App:")
                .padding()
            
            FeatureRow(imageName: "photo", title: "Local Image Assets", description: "Explore a wide range of stunning images to enhance your app.")
            FeatureRow(imageName: "play.circle", title: "Local Video Assets", description: "Discover new video content within a library of engaging videos for more entertainment.")
            FeatureRow(imageName: "map", title: "Map with Points of Interest", description: "Check out the map for points of interest where the loaded assets have been captured.")
            FeatureRow(imageName: "flame", title: "Firebase Remote Config", description: "Experience new features and improvements powered by Firebase Remote Config.")
            
            Spacer()
            
            Button(action: {
                            isNightModeEnabled.toggle() // Toggle night mode
                            nightModeManager.isNightModeEnabled = isNightModeEnabled // Update NightModeManager
                        }) {
                            Text(isNightModeEnabled ? "Switch to Light Mode" : "Switch to Dark Mode")
                                .padding()
                                .foregroundColor(.white)
                                .background(isNightModeEnabled ? Color.blue : Color.gray)
                                .cornerRadius(10)
                        }
                        .padding()
        }
        .padding()
        .foregroundColor(isNightModeEnabled ? Color.white : Color.black) // Adjust text color based on night mode
        .background(isNightModeEnabled ? Color.black : Color.white) // Adjust background based on night mode
        .onAppear {
            isNightModeEnabled = nightModeManager.isNightModeEnabled // Initialize night mode state
        }
    }
}

struct FeatureRow: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.title)
                .padding()
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                FootnoteText(text: description)
            }
            
            Spacer()
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct UserWarningView_Previews: PreviewProvider {
    static var previews: some View {
        UserWarningView()
    }
}
