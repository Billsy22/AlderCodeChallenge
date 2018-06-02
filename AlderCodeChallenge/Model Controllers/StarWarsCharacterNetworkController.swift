//
//  StarWarsCharacterController.swift
//  AlderCodeChallenge
//
//  Created by Taylor Bills on 6/1/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation
import UIKit

class StarWarsCharacterNetworkController {
    
    // MARK: -  Properties
    
    static let shared = StarWarsCharacterNetworkController()
    let baseURL = URL(string: "https://starwarstest16.herokuapp.com/api/characters")!
    
    // MARK: - Network Calls
    
    // Fetch Characters
    func fetchCharacterList(completion: @escaping([StarWarsCharacter]?) -> Void) {
        let component = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        guard let url = component?.url else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { print("No Data \(#file)"); return }
                let characterListDictionary = try JSONDecoder().decode(CharacterList.self, from: data)
                let characterList = characterListDictionary.individuals.compactMap({ $0 })
                StarWarsCharacterPersistence.shared.characterList = characterList
                for character in StarWarsCharacterPersistence.shared.characterList {
                    guard let id = character.id, let firstName = character.firstName, let lastName = character.lastName, let birthdate = character.birthdate, let profilePicture = character.profilePicture, let forceSensitive = character.forceSensitive, let affiliation = character.affiliation else { return }
                    StarWarsCharacterPersistence.shared.addCharacterWith(id: id, firstName: firstName, lastName: lastName, birthdate: birthdate, profilePicture: profilePicture, forceSensitive: forceSensitive, affilitation: affiliation)
                    print("Character \(character.firstName), added")
                }
                completion(characterList)
            } catch let error {
                print("Error occured fetching Character List: \(error), \(error.localizedDescription), \(#file)")
                completion(nil)
                return
            }
        }.resume()
    }
    
    // Fetch Profile Picture
    func fetchProfilePicture(for character: StarWarsCharacter, completion: @escaping(UIImage?) -> Void) {
        guard let urlString = character.profilePicture else { print("No URL for Character's profile picture \(#file)"); return }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { print("No Data \(#file)"); return }
                guard let profilePic = UIImage(data: data) else { return }
                StarWarsCharacterPersistence.shared.addImage(image: profilePic, for: character)
                completion(profilePic)
            } catch let error {
                print("Error occured fetching Character List: \(error.localizedDescription), \(#file)")
                completion(nil)
                return
            }
        }.resume()
    }
}
