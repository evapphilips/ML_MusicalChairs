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
var status: Bool = false;

////////////////////////////////////////////////////////////////////
// NOTE: Update to unique name.
// Service type must be a unique string, at most 15 characters long
// and can contain only ASCII lowercase letters, numbers and hyphens.
let ServiceType = "musical-chairs"


class GameViewController: UIViewController, MultipeerServiceDelegate {
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var playerSymbolView: UIView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet var buttons : [UIButton]!
    
    // Popup for entering username.
    var alert : UIAlertController!
    
    // Service for handling P2P communication.
    var multipeerService: MultipeerService?
    var playerName: String?
    
    //assign at Ready pressed in ReadyViewController
    let r: CGFloat = .random()
    let g: CGFloat = .random()
    let b: CGFloat = .random()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyRoundCorner(playerSymbolView)
        playerSymbolView.layer.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0).cgColor
        
        self.applyRoundCorner(testButton)
        testButton.layer.borderColor = UIColor.black.cgColor
        testButton.layer.borderWidth = 2
        
        buttons.forEach {
            self.applyRoundCorner($0)
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 2
        }
        
        if let name = playerName {
            // Start P2P.
            print(name)
            //self.startMultipeerService(displayName: name)
            //playerNameLabel.text = name;
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        restart()
        
    }
    
    @IBAction func handleTestButton(_ sender: Any) {
        testButton.layer.backgroundColor = UIColor.red.cgColor
        testButton.setTitle(playerName, for: .normal)
        testButton.setTitleColor(.black, for: .normal)
    }
    
    
    @IBAction func buttonsTapped(_ sender: UIButton){
        let index = buttons.index(of: sender)!
        buttons[index].layer.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0).cgColor
        buttons[index].setTitle(playerName, for: .normal)
        buttons[index].setTitleColor(.black, for: .normal)
        buttons.forEach{
            $0.isEnabled = false
        }
        //get index of button tapped
        print("index:"+"\(index)")
        
        multipeerService?.send(msg: "\(index),\(playerName!),\(r),\(g),\(b)")
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
            let msgArray = msg.components(separatedBy: ",")
            let name = msgArray[1]
            if let i = Int(msgArray[0]){
                self.buttons[i].setTitle(name, for: .normal)
                self.buttons[i].isEnabled = false
                guard let rd = NumberFormatter().number(from: msgArray[2]) else {return}
                guard let gr = NumberFormatter().number(from: msgArray[3]) else {return}
                guard let bl = NumberFormatter().number(from: msgArray[4]) else {return}
                self.buttons[i].layer.backgroundColor = UIColor(red: CGFloat(truncating: rd), green: CGFloat(truncating: gr), blue: CGFloat(truncating: bl), alpha: 1.0).cgColor
            }
        }
    }
    
    func applyRoundCorner(_ object:AnyObject){
        object.layer.cornerRadius = object.frame.size.width/2
        object.layer?.masksToBounds = true
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
                self.playerName = name
                self.playerNameLabel.text = name;
                self.startMultipeerService(displayName: name)
            }
        })
        action.isEnabled = false
        alert.addAction(action)
        
        // Show alert popup.
        self.present(alert, animated: true)
    }
    
    // Disable ready button when text field is empty.
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        alert.actions[0].isEnabled = sender.text!.count > 0
    }
    
    // Dismisses keyboard when done is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}



