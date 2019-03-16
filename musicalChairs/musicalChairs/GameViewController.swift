//
//  GameViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/14/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit
// player variables
var connectedPlayers: Int = 0
var playerCount: Int = 0
let playerTotal: Int = 3

////////////////////////////////////////////////////////////////////
// NOTE: Update to unique name.
// Service type must be a unique string, at most 15 characters long
// and can contain only ASCII lowercase letters, numbers and hyphens.
let ServiceType = "musical-chairs"


class GameViewController: UIViewController, MultipeerServiceDelegate {
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var playerSymbolView: UIView!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    // Service for handling P2P communication.
    var multipeerService: MultipeerService?
    var playerName: String?
    
    
//    @IBAction func handelTestButton(_ sender: Any) {
//
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = playerName {
            // Start P2P.
            print(name)
            self.startMultipeerService(displayName: name)
            playerNameLabel.text = name;
        }
        
        playerSymbolView.layer.cornerRadius = playerSymbolView.frame.size.width/2
        playerSymbolView.clipsToBounds = true
        playerSymbolView.layer.backgroundColor = UIColor.red.cgColor

    }
    
    
    // Start multipeer service with display name.
    func startMultipeerService(displayName: String) {
        self.multipeerService = nil
        self.multipeerService = MultipeerService(dispayName: displayName)
        self.multipeerService?.delegate = self
    }
    
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        DispatchQueue.main.async {
            connectedPlayers = connectedDevices.count
            playerCount = connectedPlayers+1
            print("player count:"+"\(playerCount)")
        }
    }
    
    func receivedMsg(manager: MultipeerService, msg: String) {
        DispatchQueue.main.async {
            print("hi")
        }
    }
}
