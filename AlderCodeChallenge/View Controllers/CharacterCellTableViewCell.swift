//
//  CharacterCellTableViewCell.swift
//  AlderCodeChallenge
//
//  Created by Taylor Bills on 6/1/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import UIKit

class CharacterCellTableViewCell: UITableViewCell {
    
    // MARK: -  Properties
    
    var characterPhoto: UIImage? {
        didSet {
            updateImageView()
        }
    }
    @IBOutlet weak var characterProfilePicture: UIImageView!
    
    // MARK: -  Helper Methods
    
    // Update Image View
    func updateImageView() {
        characterProfilePicture.image = characterPhoto
    }
}
