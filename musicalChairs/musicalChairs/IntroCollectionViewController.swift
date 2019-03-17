//
//  IntroCollectionViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/17/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class IntroCollectionViewController: UICollectionViewController {
    
    // deifine snap layout
    let flowLayout = IntroCollectionViewFlowLayout()
    
    // define UI label for title
    var titleUILabel: UILabel!
    
    // define instructions array
    var instructions: [String] = ["waiting for other players", "object of the game, occupy a bottom as fast as possible", "dont let anyone steal your button", "practice occupying a button by clicking on the circle below"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title
        titleUILabel = UILabel(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 40))
        titleUILabel.textAlignment = .center
        titleUILabel.text = "Mobile Lab Musical Chairs"
        self.view.addSubview(titleUILabel)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // set up collection view
        guard let introCollectionView = collectionView else { fatalError() }
        introCollectionView.collectionViewLayout = flowLayout
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.contentView.backgroundColor = .white
        var pageUILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        pageUILabel.textAlignment = .center
        pageUILabel.text = instructions[indexPath.item]
        cell.addSubview(pageUILabel)
        print(indexPath)
        print(indexPath.item)
        
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
