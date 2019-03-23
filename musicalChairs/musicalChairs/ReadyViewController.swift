//
//  ViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/14/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit



class ReadyViewController: UIViewController, MultipeerServiceDelegate {
    
    @IBOutlet weak var playerCountLabel: UILabel!
    var multipeerService: MultipeerService?
    
    // Popup for entering username.
    var alert : UIAlertController!
    // Display name.
//    var username = ""
    var username : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

