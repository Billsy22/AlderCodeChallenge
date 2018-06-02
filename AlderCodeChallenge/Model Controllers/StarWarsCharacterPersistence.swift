//
//  StarWarsCharacterPersistence.swift
//  AlderCodeChallenge
//
//  Created by Taylor Bills on 6/1/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation
import UIKit

class StarWarsCharacterPersistence {
    
    // MARK: -  Properties
    
    static let shared = StarWarsCharacterPersistence()
    var characterList: [StarWarsCharacter] = []
    var imageDictionary: [String : Data] = [:]
    
    // MARK: -  Initializer
    
    init() {
        self.characterList = loadCharacterListFromPersistence()
        self.imageDictionary = loadImagesFromPersistence()
    }
    
    // MARK: -  Add to local arrays
    
    // Add Character
    func addCharacterWith(id: Int, firstName: String, lastName: String, birthdate: String, profilePicture: String, forceSensitive: Bool, affilitation: String) {
        let newCharacter = StarWarsCharacter(id: id, firstName: firstName, lastName: lastName, birthdate: birthdate, profilePicture: profilePicture, forceSensitive: forceSensitive, affiliation: affilitation)
        if !characterList.contains(newCharacter) {
            characterList.append(newCharacter)
        }
        saveToPersistence()
    }
    
    // Add Image
    func addImage(image: UIImage, for character: StarWarsCharacter) {
        guard let firstName = character.firstName else { return }
        guard let imageData = UIImagePNGRepresentation(image) else { return }
        if !imageDictionary.keys.contains(firstName) {
            imageDictionary.updateValue(imageData, forKey: firstName)
        }
        saveToPersistence()
    }
    
    // MARK: -  Loading/Saving
    
    // Find local save location for characterList
    func charactersFileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "starWarsCharacters.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    // Find local save location for imageDictionary
    //Save Location
    func imagesFileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "imageDictionary.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    // Save to persistence
    func saveToPersistence() {
        let jsonEncoder = JSONEncoder()
        do {
            let characterData = try jsonEncoder.encode(characterList)
            try characterData.write(to: charactersFileURL())
            let imageData = try jsonEncoder.encode(imageDictionary)
            try imageData.write(to: imagesFileURL())
        } catch let error {
            print("Error saving to disk: \(error.localizedDescription)")
        }
    }
    
    // Load Characters
    func loadCharacterListFromPersistence() -> [StarWarsCharacter] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: charactersFileURL())
            let characterList = try jsonDecoder.decode([StarWarsCharacter].self, from: data)
            return characterList
        } catch let error {
            print("Error loading characters from disk: \(error.localizedDescription), \(#file)")
            return []
        }
    }
    
    // Load Images
    func loadImagesFromPersistence() -> [String : Data] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: imagesFileURL())
            let images = try jsonDecoder.decode([String : Data].self, from: data)
            return images
        } catch let error {
            print("Error loading images from disk: \(error.localizedDescription), \(#file)")
            return[:]
        }
    }
}
