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
    var instructions: [String] = ["Waiting for other players. Swipe to view the instructions", "The object of the game is to occupy a circle as fast as possible.", "But dont let anyone steal your circle before the time is up.", "Practice occupying a circle by clicking on the circle below."]

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
        return instructions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        
        // Configure the cell
        cell.contentView.backgroundColor = .white
        // add instructions in each collection view page
        let pageUILabel = UILabel(frame: CGRect(x: 25, y: 25, width: 200, height: 300))
        pageUILabel.textAlignment = .center
        pageUILabel.lineBreakMode = .byWordWrapping
        pageUILabel.numberOfLines = 4
        pageUILabel.text = instructions[indexPath.row]
        cell.addSubview(pageUILabel)
//        if(indexPath.row == 0){
//        pageUILabel.text = instructions[0]
//        cell.addSubview(pageUILabel)
//        }
//        if(indexPath.row == 1){
//            pageUILabel.text = instructions[1]
//            cell.addSubview(pageUILabel)
//        }
//        if(indexPath.row == 3){
//            pageUILabel.text = instructions[3]
//            cell.addSubview(pageUILabel)
//        }
        
        
        
        
    
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
