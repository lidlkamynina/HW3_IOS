import SwiftUI
import AVKit

struct VideoView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack() {
            HStack() {
                ViewTitleText(text: "minestagram")
                    .foregroundColor(.black)
            }
        .padding(EdgeInsets(top: 120, leading: 0, bottom: 10, trailing: 0))
        .background(Color.yellow)
            
            List {
                ForEach(viewModel.videoUrls ?? [], id: \.self) { url in
                    HStack {
                        VideoPlayerView(player: AVPlayer(url: URL(string: url)!)) { player in
                            let playerViewController = AVPlayerViewController()
                            playerViewController.player = player
                            
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                  let window = windowScene.windows.first else {
                                return
                            }
                            
                            window.rootViewController?.present(playerViewController, animated: true, completion: {
                                player.play()
                            })
                        }
                        .frame(width: 125, height: 125)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                        Text("\(URL(string: url)?.lastPathComponent ?? "")")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchVideoUrls(owner: "ioslekcijas", repo: "faili")
        }
        .edgesIgnoringSafeArea(.top)
    }
}
