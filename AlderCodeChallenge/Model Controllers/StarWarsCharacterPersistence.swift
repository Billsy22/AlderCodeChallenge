//
//  StarWarsCharacterPersistence.swift
//  AlderCodeChallenge
//
//  Created by Taylor Bills on 6/1/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation

class StarWarsCharacterPersistence {
    
    // MARK: -  Properties
    
    static let shared = StarWarsCharacterPersistence()
    var characterList: [StarWarsCharacter] = []
    
    // MARK: -  Initializer
    
    init() {
        self.characterList = loadFromPersistentStorage()
    }
    
    // MARK: -  Add character to local array
    
    // Add Character
    func addCharacterWith(id: Int, firstName: String, lastName: String, birthdate: String, profilePicture: String, forceSensitive: Bool, affilitation: String) {
        let newCharacter = StarWarsCharacter(id: id, firstName: firstName, lastName: lastName, birthdate: birthdate, profilePicture: profilePicture, forceSensitive: forceSensitive, affiliation: affilitation)
        characterList.append(newCharacter)
    }
    
    // MARK: -  Loading/Saving
    
    // Find local save location
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "starWarsCharacters.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    // Save to persistence
    func saveToPersistence() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(characterList)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to disk: \(error.localizedDescription)")
        }
    }
    
    // Load Files
    func loadFromPersistentStorage() -> [StarWarsCharacter] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let  characterList = try jsonDecoder.decode([StarWarsCharacter].self, from: data)
            return characterList
        } catch let error {
            print("Error loading from disk \(error.localizedDescription)")
            return []
        }
    }
}
