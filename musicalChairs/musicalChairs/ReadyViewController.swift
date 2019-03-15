//
//  ViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/14/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit


//// Global Variables
//struct playerData {
//    var playerName: String
//    var playerColor: [Int]
//    var playerStatus: Bool
//}
//var players: [playerData] = []


<<<<<<< HEAD
class ReadyViewController: UIViewController, MultipeerServiceDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // attach collection view controller
    @IBOutlet weak var collectionView: UICollectionView!


=======
class ReadyViewController: UIViewController {
>>>>>>> f82603b20a10a838e31eb31b0216890dda0d3b99
    // Popup for entering username.
    var alert : UIAlertController!
    // Display name.
    var username = ""
    
    
//    // Popup for entering username.
//    var alert : UIAlertController!
//    // Service for handling P2P communication.
//    var multipeerService: MultipeerService?
//    // Display name.
//    var username = ""
    
//    var players: [String] = []

    // player variables
    var playerCount: Int = 0;
    let playerTotal: Int = 3;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
 //       let vc = GameViewController(nibName: "GameViewController", bundle: nil)
 //       vc.delegate = self
=======
>>>>>>> f82603b20a10a838e31eb31b0216890dda0d3b99
        // Prompt user to input username and start P2P communication.
//        restart()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
                self.navigationItem.title = name
            
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

<<<<<<< HEAD
    
    // peer to peer protocol
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        
        DispatchQueue.main.async {
            print(connectedDevices)
//            self.players.append("\(connectedDevices)")
//            print(self.players)
        }
    }
    
    func receivedMsg(manager: MultipeerService, msg: String) {
        DispatchQueue.main.async {
        }
    }
    
    // collection view protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCollectionViewCell", for: indexPath) as! TextCollectionViewCell
        
        cell.collectionViewCellText.text = "hi"
        
        return cell
    
    }
    
=======

>>>>>>> f82603b20a10a838e31eb31b0216890dda0d3b99

}

