import Foundation

enum Type {
    case photo, video
}

struct UserInfo: Identifiable {
    let id = UUID()
    let userName: String
    let description: String
    let abilities: [String]
    let type: Type
    //let profileImageName: String
}
