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
    
    var playerCountLabel: UILabel!
    var progressBar: UIProgressView!
    var titleUILabel: UILabel!
    // Popup for entering username.
    var alert : UIAlertController!
    
    // start multipeer serview
    var multipeerService: MultipeerService?
    
    // Display name.
    var username : String?
    
    // deifine snap layout
    let flowLayout = IntroCollectionViewFlowLayout()

    // define instructions array
    var instructions: [String] = ["Waiting for other players. Swipe to view the instructions", "Occupy a circle as fast as possible.", "Each player can only occupy one circle.", "Practice occupying a circle by clicking on the circle below."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set title
        //titleUILabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.height/15, width: self.view.frame.width, height: 40))
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
       
        //progress bar
        self.progressBar = UIProgressView(progressViewStyle: .default)
        self.progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - self.view.frame.width/6, height: 20)
        self.progressBar.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 60)
        self.progressBar.trackTintColor = .white
        self.progressBar.progressTintColor = .gray
        //increase height of progressBar
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        self.progressBar.transform = transform
        //apply rounded corner
        self.progressBar.layer.masksToBounds = true
        self.progressBar.layer.cornerRadius = progressBar.frame.height/2.0
        self.view.addSubview(self.progressBar)
        
        //playerCountLabel
        self.playerCountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        self.playerCountLabel.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - self.view.frame.height/10)
        self.playerCountLabel.textAlignment = .center
        self.view.addSubview(self.playerCountLabel)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Prompt user to input username and start P2P communication.
        restart()
    }
    
    // Show popup for entering username, P2P servic will start when name entered.
    func restart() {
        multipeerService = nil
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
            
            // Start multipeer server here.
            if let name = self.username {
                // Create and start multipeerService.
                self.multipeerService = MultipeerService(dispayName: name)
                self.multipeerService?.delegate = self
            }
            
            //show playerCountLabel and progressBar for the first player
            if playerCount == 0 {
                self.playerCountLabel.text = "Number of players: 1 "
                self.progressBar.setProgress(Float(1)/Float(playerTotal), animated: true)
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
    
    //Delegate methods
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        DispatchQueue.main.async {
            print("ReadyViewController: connectedDevices: \(connectedDevices)")
            
            //Get player count and process... + 1 to include yourself.
            playerCount = connectedDevices.count + 1
            
            //update number of players.
            self.playerCountLabel.text = "Number of players: \(playerCount)"
            //update progressbar
            self.progressBar.setProgress(Float(playerCount)/Float(playerTotal), animated: true)

            // ... start once you reached a set number.
//            if playerCount == playerTotal {
            if connectedDevices.count + 1 == playerTotal {
                print("mod: \((connectedDevices.count + 1) % playerTotal)")
            //once the last player is ready, wait for 5 seconds and instantiate GameViewController
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController

                    //IMPORTANT: Pass multipeerService object down to GameViewController.
                    self.multipeerService?.stopMatchmaking()
                    
                    vc.multipeerService = self.multipeerService
                    vc.playerName = self.username

                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    func receivedMsg(manager: MultipeerService, msg: String) {
        DispatchQueue.main.async {
            print("ReadyViewController: receivedMsg")
        }
    }

    
    //Configure collection view
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
            
            cell.pageButton.layer.borderWidth = 1
            cell.pageButton.layer.borderColor = UIColor.black.cgColor
            cell.pageButton.layer.cornerRadius = 50
        }
        
        cell.pageLabel.textAlignment = .center
        cell.pageLabel.lineBreakMode = .byWordWrapping
        cell.pageLabel.numberOfLines = 4
        cell.pageLabel.text = instructions[indexPath.row]
        
        return cell
    }
}

//generate random CGFloat number for player color
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
