import Foundation

struct User: Codable {
    let id: Int
    let avatarURL: String?
    let name, company, bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
        case name, company, bio
    }
}

func getUser() -> User? {
    return User(id: 63356850,
                avatarURL: "https://picsum.photos/128/128", name: "Albus Percival Wulfric Brian Dumbledore", company: "Hogwarts School of Witchcraft and Wizardy", bio: "Headmaster of Hogwarts")
}
