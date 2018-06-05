//
//  CharacterListTableViewController.swift
//  AlderCodeChallenge
//
//  Created by Taylor Bills on 6/1/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import UIKit

class CharacterListTableViewController: UITableViewController {
    
    // MARK: -  Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsCharacterNetworkController.shared.fetchCharacterList { (characters) in
            print("Characters Fetched")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
//            if StarWarsCharacterPersistence.shared.imageDictionary.keys.count != StarWarsCharacterPersistence.shared.characterList.count {
//                guard let characters = characters else { return }
//                for character in characters {
//                    StarWarsCharacterNetworkController.shared.fetchProfilePicture(for: character, completion: { (image) in
//                        print("Image Fetched")
//                        DispatchQueue.main.sync {
//                            self.tableView.reloadData()
//                        }
//                    })
//                }
//            }
        }
        self.tableView.rowHeight = 200
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Starry Background"))
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StarWarsCharacterPersistence.shared.characterList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterCellTableViewCell else { return UITableViewCell() }
        let character = StarWarsCharacterPersistence.shared.characterList[indexPath.row]
        if StarWarsCharacterPersistence.shared.imageDictionary.keys.count != StarWarsCharacterPersistence.shared.characterList.count {
        StarWarsCharacterNetworkController.shared.fetchProfilePicture(for: character) { (image) in
            DispatchQueue.main.sync {
                cell.characterPhoto = image
                self.tableView.reloadData()
            }
        }
        } else {
            print("No need to fetch!!!")
        }
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let character = StarWarsCharacterPersistence.shared.characterList[indexPath.row]
            guard let firstName = character.firstName else { return }
            guard let image = StarWarsCharacterPersistence.shared.imageDictionary[firstName] else { return }
            guard let characterDetailViewController = segue.destination as? CharacterDetailViewController else { return }
            characterDetailViewController.image = UIImage(data: image)
            characterDetailViewController.character = character
        }
    }
}
