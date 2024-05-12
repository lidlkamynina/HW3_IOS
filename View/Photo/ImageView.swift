import SwiftUI

struct ImageView: View {
    @StateObject var viewModel: ViewModel
    @StateObject var imageModel = ImageModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    HStack() {
                        ViewTitleText(text: "minestagram")
                            .foregroundColor(.black)
                    }
                .padding(EdgeInsets(top: 120, leading: 0, bottom: 10, trailing: 0))
                .background(Color.yellow)
                    
                    ForEach(imageModel.imageUrls, id: \.self) { imageUrl in
                        NavigationLink(destination: ImageDetail(url: imageUrl)) {
                            VStack(spacing: 0) {
                                HStack(alignment: .center) {
                                    AsyncImage(url: URL(string: viewModel.profile?.avatar_url ?? "")) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        case .failure(let error):
                                            Text(error.localizedDescription)
                                        @unknown default:
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())

                                    VStack(alignment: .leading) {
                                        Text(viewModel.profile?.name ?? "")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                                AsyncImage(url: URL(string: imageUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    case .failure(let error):
                                        Text(error.localizedDescription)
                                    @unknown default:
                                        ProgressView()
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .cornerRadius(8)
                                .padding()
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                        }
                    }
                }
            }
            .onAppear {
                imageModel.fetchImageUrls(owner: "ioslekcijas", repo: "faili")
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

