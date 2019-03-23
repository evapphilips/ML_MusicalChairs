//
//  GameViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/14/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit
// player variables
var playerCount: Int = 0
var playerStatus: Bool = false
let buttonTotal: Int = 3   //button Total < playerTotal
var buttonCount: Int = 0

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
    
    @IBOutlet weak var buttonCountLabel: UILabel!
    
    // Popup for entering username.
    var alert : UIAlertController!
    
    // Popup for entering username.
    var gameOverAlert:UIAlertController!
    
    // Service for handling P2P communication.
    var multipeerService: MultipeerService?
    var playerName: String?
    
    //assign at Ready pressed in ReadyViewController
    let r: CGFloat = .random()
    let g: CGFloat = .random()
    let b: CGFloat = .random()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = playerName {
            print(name)
            playerNameLabel.text = name
        }
        
        self.applyRoundCorner(playerSymbolView)
        playerSymbolView.layer.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0).cgColor
        
//        self.applyRoundCorner(testButton)
//        testButton.layer.borderColor = UIColor.black.cgColor
//        testButton.layer.borderWidth = 0
        
        buttons.forEach {
            self.applyRoundCorner($0)
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 2
        }
        
        // NLAM: Set the delegate here.
        multipeerService?.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func handleTestButton(_ sender: Any) {
        testButton.layer.backgroundColor = UIColor.red.cgColor
        testButton.setTitle(playerName, for: .normal)
        testButton.setTitleColor(.black, for: .normal)
    }
    
    
    @IBAction func buttonsTapped(_ sender: UIButton){
        //set the button title and color to this player's name and color
        let index = buttons.index(of: sender)!
        buttons[index].layer.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0).cgColor
        buttons[index].setTitle(playerName, for: .normal)
        buttons[index].setTitleColor(.black, for: .normal)
        
        //send message to peers
        multipeerService?.send(msg: "\(index),\(playerName!),\(r),\(g),\(b)")
        
        //disable all the buttons for this player
        buttons.forEach{
            $0.isEnabled = false
        }
        
        //player won
        playerStatus = true
        //print("i won")
        
        //increment occupied buttons
        buttonCount = buttonCount + 1
        //debug: printing buttonCount on buttonCountLabel
        self.buttonCountLabel.text = ("\(buttonCount) buttons occupied")
        
        //present gameOverAlert if this player occupies the last button
        if buttonCount == buttonTotal {
            gameover()
        }
    }
    
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        DispatchQueue.main.async {
//            playerCount = connectedDevices.count+1
//            print("player count:"+"\(playerCount)")
            print("connectedDevicesChanged")
        }
    }
    
    func receivedMsg(manager: MultipeerService, msg: String) {
        DispatchQueue.main.async {
            //split msg into msgArray [index, playerName, r, g, b]
            let msgArray = msg.components(separatedBy: ",")
            if let i = Int(msgArray[0]){
                //disable occupied buttons and set title and color from received msg
                self.buttons[i].isEnabled = false
                self.buttons[i].setTitle(msgArray[1], for: .normal)
                guard let rd = NumberFormatter().number(from: msgArray[2]) else {return}
                guard let gr = NumberFormatter().number(from: msgArray[3]) else {return}
                guard let bl = NumberFormatter().number(from: msgArray[4]) else {return}
                self.buttons[i].layer.backgroundColor = UIColor(red: CGFloat(truncating: rd), green: CGFloat(truncating: gr), blue: CGFloat(truncating: bl), alpha: 1.0).cgColor
            }
            
            //increment occupied buttons
            buttonCount = buttonCount + 1
            //debug: printing buttonCount on label
            self.buttonCountLabel.text = ("\(buttonCount) buttons occupied")
            
            //present gameOverAlert when all the buttons occupied
            if buttonCount == buttonTotal {
                self.gameover()
            }
        }
    }

    
    // Show popup for game result
    func gameover() {
        // Create gameover alert popup.
        if playerStatus == true {
            gameOverAlert = UIAlertController(title: "Game Over! You Won!", message: nil, preferredStyle: .alert)
        } else {
            gameOverAlert = UIAlertController(title: "Game Over! You Lost!", message: nil, preferredStyle: .alert)
        }
        
        // Create action on Restart press, go back to ReadyViewController
        let action = UIAlertAction(title: "Restart", style: .default, handler: { action in
            print("restarted")
        })
        action.isEnabled = false
        gameOverAlert.addAction(action)
        
        // Show alert popup.
        self.present(gameOverAlert, animated: true)
    }
    
    
    func applyRoundCorner(_ object:AnyObject){
        object.layer.cornerRadius = object.frame.size.width/2
        object.layer?.masksToBounds = true
    }
}



//generate random CGFloat number for player color
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}



