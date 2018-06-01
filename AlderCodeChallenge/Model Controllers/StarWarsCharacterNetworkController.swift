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
                let profilePic = UIImage(data: data)
                completion(profilePic)
            } catch let error {
                print("Error occured fetching Character List: \(error.localizedDescription), \(#file)")
                completion(nil)
                return
            }
        }.resume()
    }
}
