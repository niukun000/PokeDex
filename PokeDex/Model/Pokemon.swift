
//
//  Pokemon.swift
//  MoviewMVC
//
//  Created by Kun Niu on 11/11/22.
//

import Foundation

struct PageResult : Decodable{
    let count : Int
    let next : URL?
    let previous : URL?
    let results : [NameLink]
    
}

struct Pokemon : Decodable{
//    let pokemon: Pokemon
    let abilities : [Abilities]
    let baseExperience : Int
    let forms : [NameLink]
    let gameIndices : [GameIndices]
    let height : Int
    let heldItems : [HeldItems]
    let id : Int
    let isDefault : Bool
    let locationAreaEncounters : URL?
    let moves : [Moves]
    let name : String
    let order : Int
//    let past_types : []
    let species : NameLink
    let sprites : Sprites
//    let stats : []
    let types : [Types]
    let weight : Int
}

//struct Pokemon : Decodable {
//
//    let previous : String
//    let next : String
//    let results : [NameLink]
//
//}

struct Abilities : Decodable {
    let ability : NameLink
    let isHidden : Bool
    let slot : Int
    
    
}

struct GameIndices : Decodable{
    let gameIndex : Int
    let version : NameLink
    
}

struct HeldItems: Decodable{
    let item : NameLink
    let versionDetails : [VersionDetails]
    
}

struct VersionDetails : Decodable{
    let rarity : Int
    let version : NameLink
}

struct Moves: Decodable{
    let move : NameLink
    let versionGroupDetails : [VersionGroupDetail]
}

struct VersionGroupDetail: Decodable{
    let levelLearnedAt : Int
    let moveLearnMethod : NameLink
    let versionGroup : NameLink
}

struct Sprites : Decodable{
    let BackDefault : URL?
    let BackFemale : URL?
    let BackShiny : URL?
    let backShinyFemale : URL?
    let frontDefault : URL?
    let frontFemale : URL?
    let frontShiny : URL?
    let frontShinyFemale : URL?
//    let other : Other
    let versions : Versions
}

struct Other : Decodable{
//    let dreamWorld : URL?
    let home : Home
    let officialArtwork : OfcialArtwork
}

struct Home : Decodable{
    let frontDefault : URL?
    let frontFemale : URL?
    let frontShiny : URL?
    let frontShinyFemale : URL?
}

struct OfcialArtwork: Decodable{
    let frontDefault : URL?
}

struct Versions : Decodable{
    let generationV : GenerationV?
        enum CodingKeys: String, CodingKey{
            case generationV = "generation-v"
        
    }
}
struct GenerationV : Decodable{
    let blackWhite : BlackWhite
    enum CodingKeys: String, CodingKey{
        case blackWhite = "black-white"
    }
}
struct BlackWhite : Decodable{
    let animated : Animated
    let BackDefault : URL?
    let BackFemale : URL?
    let BackShiny : URL?
    let backShinyFemale : URL?
    let frontDefault : URL?
    let frontFemale : URL?
    let frontShiny : URL?
    let frontShinyFemale : URL?
}

struct Animated : Decodable{
    let BackDefault : URL?
    let BackFemale : URL?
    let BackShiny : URL?
    let backShinyFemale : URL?
    let frontDefault : URL?
    let frontFemale : URL?
    let frontShiny : URL?
    let frontShinyFemale : URL?
}
struct Types : Decodable{
    let slot : Int
    let type : NameLink
}

struct NameLink : Decodable{
    let name : String
    let url : URL?
}
