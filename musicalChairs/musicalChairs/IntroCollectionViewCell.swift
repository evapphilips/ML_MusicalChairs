//
//  IntroCollectionViewCell.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/18/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit

class IntroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var pageButton: UIButton!
    
    @IBAction func buttonClicked(_ sender: UIButton) {
//        pageButton.backgroundColor = UIColor.red
        pageButton.layer.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0).cgColor
        

    }
    
}
