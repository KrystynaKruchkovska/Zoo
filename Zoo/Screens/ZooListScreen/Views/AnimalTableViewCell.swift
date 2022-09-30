//
//  AnimalTableViewCell.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {


    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
