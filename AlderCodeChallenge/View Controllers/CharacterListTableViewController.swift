//
//  CharacterListTableViewController.swift
//  AlderCodeChallenge
//
//  Created by Taylor Bills on 6/1/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import UIKit

class CharacterListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if StarWarsCharacterPersistence.shared.characterList.count == 0 {
            StarWarsCharacterNetworkController.shared.fetchCharacterList { (success) in
                print("Characters Fetched")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StarWarsCharacterPersistence.shared.characterList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterCellTableViewCell else { return UITableViewCell() }
        let character = StarWarsCharacterPersistence.shared.characterList[indexPath.row]
        guard let firstName = character.firstName else { return UITableViewCell() }
        guard let characterImageData = StarWarsCharacterPersistence.shared.imageDictionary[firstName] else { return UITableViewCell() }
        cell.characterPhoto = UIImage(data: characterImageData)
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
