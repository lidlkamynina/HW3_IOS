import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ViewModel()
    @StateObject var imageModel = ImageModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let profile = viewModel.profile {
                    VStack(alignment: .leading) {
                        HStack() {
                            ViewTitleText(text: "minestagram")
                                .foregroundColor(.black)
                        }
                    .padding(EdgeInsets(top: 120, leading: 0, bottom: 10, trailing: 0))
                    .background(Color.yellow)
                        
                        HStack {
                            Image(uiImage: profile.avatarImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                .padding(12)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Name:")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                if let name = profile.name {
                                    FootnoteText(text: name)
                                }
                                
                                Text("Company:")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                if let company = profile.company {
                                    FootnoteText(text: company)
                                }
                            }
                            
                            .padding(.top, 10)
                            
                            Spacer()
                            
                            
                        }
                        if let bio = profile.bio {
                            FootnoteText(text: bio)
                                .padding(.top, 5)
                                .padding(.horizontal, 25)
                        }
                        
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3)) {
                            
                                ForEach(imageModel.imageUrls , id: \.self) { imageUrl in
                                    NavigationLink(destination: ImageDetail(url: imageUrl)) {
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
                                    .cornerRadius(15)
                                }
                            }
                        }
                        
                        Spacer()
                        
                    }
                    
                } else {
                    
                    Text("Loading...")
                        .padding(.top, 55)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            imageModel.fetchImageUrls(owner: "ioslekcijas", repo: "faili")
        }
    }
}


