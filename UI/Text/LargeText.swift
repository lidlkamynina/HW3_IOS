import SwiftUI

struct LargeText: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.largeTitle)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            Spacer()
        }.foregroundStyle(.white)
    }
}
