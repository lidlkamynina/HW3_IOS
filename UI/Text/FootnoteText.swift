import SwiftUI

struct FootnoteText: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(.gray)
            Spacer()
        }
    }
}
