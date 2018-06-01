//
//  StarWarsCharacter.swift
//  AlderCodeChallenge
//
//  Created by Taylor Bills on 6/1/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation
import UIKit

struct StarWarsCharacter: Codable, Equatable {
    
    // MARK: -  Properties
    let id: Int?
    let firstName: String?
    let lastName: String?
    let birthdate: String?
    let profilePicture: String?
    let forceSensitive: Bool?
    let affiliation: String?
    
    // MARK: -  Coding Keys
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case birthdate
        case profilePicture
        case forceSensitive
        case affiliation
    }
}

struct CharacterList: Codable {
    let individuals: [StarWarsCharacter]
}
