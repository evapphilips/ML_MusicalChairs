//
//  ViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/14/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit

// Global Variables
struct playerData {
    var playerName: String
    var playerColor: [Int]
    var playerStatus: Bool
}
var players: [Struct];


class ReadyViewController: UIViewController, MultipeerServiceDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        <#code#>
    }
    
    func receivedMsg(manager: MultipeerService, msg: String) {
        <#code#>
    }
    

    


}

