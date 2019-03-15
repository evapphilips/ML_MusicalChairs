//
//  GameViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/14/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit

////////////////////////////////////////////////////////////////////
// NOTE: Update to unique name.
// Service type must be a unique string, at most 15 characters long
// and can contain only ASCII lowercase letters, numbers and hyphens.
let ServiceType = "musical-chairs"


class GameViewController: UIViewController, MultipeerServiceDelegate {
    
    // Service for handling P2P communication.
    var multipeerService: MultipeerService?
    

    

    // Start multipeer service with display name.
    func startMultipeerService(displayName: String) {
        self.multipeerService = nil
        self.multipeerService = MultipeerService(dispayName: displayName)
        self.multipeerService?.delegate = self
        
    }
    
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        DispatchQueue.main.async {
            print("\(connectedDevices)")
            
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
        ///////////////////////////////////////////////////////
        // NOTE: Start P2P.
        self.startMultipeerService(displayName: "ada")
        ///////////////////////////////////////////////////////
        
        playerSymbolView.layer.cornerRadius = 5;

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
