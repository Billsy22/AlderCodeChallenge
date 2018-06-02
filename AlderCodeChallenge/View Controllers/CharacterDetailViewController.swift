//
//  CharacterDetailViewController.swift
//  AlderCodeChallenge
//
//  Created by Taylor Bills on 6/1/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    // MARK: -  Properties
    
    var image: UIImage?
    var character: StarWarsCharacter?
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var forceSensitiveLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    
    // MARK: -  Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let backgroundImage = UIImage(named: "Starry Background") else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        guard let image = image, let character = character else { return }
        guard let firstName = character.firstName, let lastName = character.lastName, let forceSensitive = character.forceSensitive, let affiliation = character.affiliation else { return }
        profilePictureImageView.image = image
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        forceSensitiveLabel.text = "\(forceSensitive)"
        affiliationLabel.text = affiliation
    }
}
