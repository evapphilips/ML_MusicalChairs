//
//  IntroCollectionViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/17/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

//assign a random button color to each player
let r: CGFloat = .random()
let g: CGFloat = .random()
let b: CGFloat = .random()

class IntroCollectionViewController: UICollectionViewController, MultipeerServiceDelegate {
    
    @IBOutlet weak var playerCountLabel: UILabel!
    var multipeerService: MultipeerService?
    
    // Popup for entering username.
    var alert : UIAlertController!
    // Display name.
    //    var username = ""
    var username : String?

    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Prompt user to input username and start P2P communication.
        restart()
        
    }
    
    // Show popup for entering username, P2P servic will start when name entered.
    func restart() {
        print("restart")
        // Create alert popup.
        alert = UIAlertController(title: "Enter your player name", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Player name..."
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        })
        
        // Create action on Ready press.
        let action = UIAlertAction(title: "Ready", style: .default, handler: { action in
            if let name = self.alert.textFields?.first?.text {
                // Save username and set to title.
                self.username = name
            }
            
            // NLAM: Start multipeer server here.
            if let name = self.username {
                // NLAM: Create and start multipeerService.
                self.multipeerService = MultipeerService(dispayName: name)
                
                // Set delegate to self.
                self.multipeerService?.delegate = self
                
                // Set number to 1 to count our self.
                self.playerCountLabel.text = "Number of players: 1"
            }
        })
        action.isEnabled = false
        alert.addAction(action)
        
        // Show alert popup.
        self.present(alert, animated: true)
    }
    
    // Disable okay button when text field is empty.
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        alert.actions[0].isEnabled = sender.text!.count > 0
    }
    
    // Dismisses keyboard when done is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // NLAM: Delegate methods
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        DispatchQueue.main.async {
            print("ReadyViewController: connectedDevices: \(connectedDevices)")
            
            // NLAM: Get player count and process.
            
            // ... add 1 to include yourself.
            playerCount = connectedDevices.count + 1
            
            // ... display number of players.
            self.playerCountLabel.text = "Number of players: \(playerCount)"
            
            
            // ... start once you reached a set number.
            if playerCount == 4 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
                
                // NLAM: IMPORTANT: Pass multipeerService object down to GameViewController.
                vc.multipeerService = self.multipeerService
                
                vc.playerName = self.username
                
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func receivedMsg(manager: MultipeerService, msg: String) {
        DispatchQueue.main.async {
            print("ReadyViewController: receivedMsg")
        }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! IntroCollectionViewCell
    
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
//        cell.myLabel.text = myStrings[indexPath.row]
//        return cell
        
        // Configure the cell
        cell.contentView.backgroundColor = .white
        cell.layer.cornerRadius = 10
        
        // add instructions in each collection view page
        if(indexPath.row < 3){  // for the first three pages
            // set frame for beginning pages
            cell.pageLabel.frame = CGRect(x: 25, y: 25, width: 200, height: 300)
            // hide button
            cell.pageButton.isHidden = true
            
        } else{  // for the last page
            // set frame for last page
            cell.pageLabel.sizeToFit()
            // show button
            cell.pageButton.isHidden = false
            cell.pageButton.frame = CGRect(x: 75, y: 150, width: 100, height: 100)
            
            cell.pageButton.layer.borderWidth = 3
            cell.pageButton.layer.borderColor = UIColor.black.cgColor
            cell.pageButton.layer.cornerRadius = 50
            
            
        }
        cell.pageLabel.textAlignment = .center
        cell.pageLabel.lineBreakMode = .byWordWrapping
        cell.pageLabel.numberOfLines = 4
        cell.pageLabel.text = instructions[indexPath.row]
        

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

//generate random CGFloat number for player color
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
