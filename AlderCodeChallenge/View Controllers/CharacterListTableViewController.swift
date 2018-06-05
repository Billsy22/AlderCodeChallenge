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
        guard let pictureURL = character.profilePicture else { return UITableViewCell() }
        if !StarWarsCharacterPersistence.shared.imageDictionary.keys.contains(pictureURL) {
            StarWarsCharacterNetworkController.shared.fetchProfilePicture(for: character) { (image) in
                DispatchQueue.main.async {
                    cell.characterPhoto = image
                    self.tableView.reloadData()
                }
            }
        } else {
            guard let imageData = StarWarsCharacterPersistence.shared.imageDictionary[pictureURL], let image = UIImage(data: imageData) else { return UITableViewCell() }
            DispatchQueue.main.async {
                cell.characterPhoto = image
                self.tableView.reloadData()
            }
            print("No need to fetch!!!")
        }
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let character = StarWarsCharacterPersistence.shared.characterList[indexPath.row]
            guard let pictureURL = character.profilePicture else { return }
            guard let image = StarWarsCharacterPersistence.shared.imageDictionary[pictureURL] else { return }
            guard let characterDetailViewController = segue.destination as? CharacterDetailViewController else { return }
            characterDetailViewController.image = UIImage(data: image)
            characterDetailViewController.character = character
        }
    }
}
