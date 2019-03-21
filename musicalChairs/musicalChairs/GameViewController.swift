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
var playerCount = connectedPlayers + 1
let playerTotal: Int = 3
var state: Bool = false

////////////////////////////////////////////////////////////////////
// NOTE: Update to unique name.
// Service type must be a unique string, at most 15 characters long
// and can contain only ASCII lowercase letters, numbers and hyphens.
let ServiceType = "musical-chairs"

protocol GameViewControllerDelegate: class {
    func startService()
}

class GameViewController: UIViewController, MultipeerServiceDelegate {
    weak var delegate: GameViewControllerDelegate?
    var startService: (() -> Void)?
    
    @IBOutlet weak var testButton: UIButton!
    
    // Service for handling P2P communication.
    var multipeerService: MultipeerService?
    var playerName: String?
    
    

    // Start multipeer service with display name.
    func startMultipeerService(displayName: String) {
        self.multipeerService = nil
        self.multipeerService = MultipeerService(dispayName: displayName)
        self.multipeerService?.delegate = self
        self.delegate?.startService()
        print("started")
    }
    
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        DispatchQueue.main.async {
            connectedPlayers = connectedDevices.count
//            print("player count:"+"\(playerCount)")
            
        }
    }
    
    func receivedMsg(manager: MultipeerService, msg: String) {
        DispatchQueue.main.async {
            print("hi")
        }
    }
    
    // user name color symbol
    @IBOutlet weak var playerSymbolView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = playerName {
            print(name)
//            // Start P2P.
////            print("here")
//            self.startMultipeerService(displayName: name)
        }
        playerSymbolView.layer.cornerRadius = 5;
    }

}


