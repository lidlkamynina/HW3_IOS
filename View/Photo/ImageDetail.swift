import SwiftUI

struct ImageDetail: View {
    let url: String
    
    var body: some View {
            VStack() {
                HStack() {
                    ViewTitleText(text: "minestagram")
                        .foregroundColor(.black)
                }
            .padding(EdgeInsets(top: 120, leading: 0, bottom: 10, trailing: 0))
            .background(Color.yellow)
                
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 35, trailing: 0))
                        .padding(10)
                case .failure(let error):
                    Text(error.localizedDescription)
                @unknown default:
                    ProgressView()
                }
            }
                Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {

                })
            }
        }
    }
    
        @Environment(\.presentationMode) var presentationMode
    
}
