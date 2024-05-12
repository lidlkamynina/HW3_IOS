import Foundation

class UserRepository {
    init() {
    }
 
    func getPhotos() -> [UserInfo] {
        return downloadUsers().filter { user in return user.type == .photo}
    }
    
    func getVideos() -> [UserInfo] {
        return downloadUsers().filter { user in return user.type == .video}
    }
}

private func downloadUsers() -> [UserInfo] {
        let thanos = UserInfo(userName: "Thanos",
                          description: "A native of the planet Titan, Thanos saw the danger his people were in from overpopulation and suggested a severe solution—the elimination of half the population, at random and without prejudice, in order to make life better for the planet as a whole. He was shunned as a madman, but his planet did indeed eventually die, lacking the resources needed to keep up with the demands. Firmly believing that the universe at large was in the same danger as Titan, Thanos grew to power as a force bringing death and destruction from planet to planet, with untold legions of soldiers and servants at his beck and call. Infamous for annihilating entire races in service of depopulating what he believes to be an overcrowded universe, he most often works through surrogates to achieve his goals, but has been known to take a personal hand in special circumstances. More than once, Thanos took a child from a galactic species he’d decimated and raised them as his own. Some of these children have been tutored in the arts of assassination and war, making them among the deadliest killers imaginable. Thanos has also given powerful artifacts to individuals who he believes will use them to spread the cause of death in certain important spots among the galaxies.Thanos went on to have a great interest in acquiring the Infinity Stones, six objects of immense power scattered throughout the universe, and has had the Infinity Gauntlet built in order to harness their power.",
                                abilities: ["Super strenght", "Psychic abiilities", "Immortality"],
                                type: .video)
        
        let ironMan = UserInfo(userName: "Iron Man",
                                description: "Genius inventor Tony Stark continued his father Howard Stark’s weaponry business after his parents’ untimely deaths and flew it to even greater heights of innovation. While in Afghanistan to demonstrate a new missile for the U.S. military, Stark’s convoy came under fire by a terrorist group known as the Ten Rings and he was severely wounded. Taken prisoner by the group, Stark awoke in their headquarters to learn that shrapnel near his heart had nearly cost him his life, but swift action by scientist and fellow prisoner Ho Yinsen—who had inserted a powerful electromagnet in Stark’s chest—would prolong it temporarily. Stalling his captors after they demanded he build them a new weapon, Stark replaced the magnet with the RT, a miniature version of a device originally designed by his father, the Arc Reactor. Furthermore, he and Yinsen created a crude suit of armor which could provide them the means with which to escape. The suit worked as planned, though Yinsen sacrificed himself in order to allow Tony enough time to power it up to fight their terrorist captors.",
                                abilities: ["Collection of armor", "360 vision", "Energy blasts"],
                                type: .photo)
        
        let ultron = UserInfo(userName: "Ultron",
                                description: "Tony Stark initially sees Ultron as a form of A.I. that could keep peace on a global scale, essentially acting as a suit of armor around the whole world, protecting it from large scale threats like the Chitauri. However, he is unable to complete it until he discovers a living computer system inside of Loki's Scepter. Working in secret with Bruce Banner, Stark uses this newly discovered artificial intelligence to finish his defense program. When Ultron wakes up, though, he finds his creators lacking. He instantly makes moves to wipe the Avengers—and most of humanity—off the map, to evolve life on the planet to the next step.",
                                abilities: ["Intelligence", "Eye blasts", "Robotic form"],
                                type: .video)
        
        let hawkeye = UserInfo(userName: "Hawkeye",
                                description: "Very little is known about the S.H.I.E.L.D. agent known as Hawkeye or his origins. An accomplished combatant and weapons master, he was present for Thor’s arrival on Earth, and was impressed with the God of Thunder. He was also instrumental in bringing over Natasha Romanoff, AKA Black Widow, to the side of S.H.I.E.L.D, sparing her life and offering her a path to redemption. For his extraordinary abilities, he was recruited by Nick Fury to be part of the Avengers Initiative. Unfortunately, in his first mission with the Avengers, he initially worked against them, thanks his mind being controlled by Loki, the Asgardian God of Mischief. After being broken free, however, the horrified Clint did work alongside his fellow Super Heroes to bring down the trickster god. Since then, he has managed to put his talents to good use against the Chitauri, Ultron, HYDRA, and even his fellow Avengers when it seemed necessary.",
                                abilities: ["Unique arraows", "Archery", "Hand-to-hand combat"],
                                type: .photo)
        
        return [thanos, ironMan, ultron, hawkeye]
    }

