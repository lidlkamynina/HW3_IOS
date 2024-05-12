import SwiftUI

struct ViewTitleText: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.leading, 16)
            Spacer()
        }
    }
}
