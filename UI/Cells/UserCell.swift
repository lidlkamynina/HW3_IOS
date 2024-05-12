import SwiftUI

struct CharacterCell: View {
    let charachter: Character
    
    var body: some View {
        HStack {
            VStack {
                LargeText(text: .userName)
                if let mainAbility = charachter.abilities.first {
                    FootnoteText(text: mainAbility)
                }
            }
            Image(charachter.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        }
        .frame(maxHeight: 80)
        .listRowBackground(Color.black)
    }
}
