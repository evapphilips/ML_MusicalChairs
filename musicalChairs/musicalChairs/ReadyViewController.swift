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


class ReadyViewController: UIViewController, UIScrollViewDelegate {
    
    // Alert variables
    // Popup for entering username.
    var alert : UIAlertController!
    // Display name.
    var username = ""
    
    
    // set up scroll view for instructions
    @IBOutlet weak var instructionsScrollView: UIScrollView!
    // set up page control
    @IBOutlet weak var pageControl: UIPageControl!
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    
    
    
//    // Popup for entering username.
//    var alert : UIAlertController!
//    // Service for handling P2P communication.
//    var multipeerService: MultipeerService?
//    // Display name.
//    var username = ""
    
//    var players: [String] = []

//    // player variables
//    var playerCount: Int = 0;
//    let playerTotal: Int = 3;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Prompt user to input username and start P2P communication.
//        restart()
        
        // instructions carousel
        configurePageControl()
        instructionsScrollView.delegate = self
        instructionsScrollView.isPagingEnabled = true
        instructionsScrollView.layer.cornerRadius = 10;
        for index in 0..<4 {
    
            frame.origin.x = self.instructionsScrollView.frame.size.width * CGFloat(index)
            frame.size = self.instructionsScrollView.frame.size
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.instructionsScrollView.addSubview(subView)
        }
        self.instructionsScrollView.contentSize = CGSize(width:self.instructionsScrollView.frame.size.width * 4,height: self.instructionsScrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        restart()

    }
    
    // Username alert pop up
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
    
    // Carousel intrstructions
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = 4
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
    }
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * instructionsScrollView.frame.size.width
        instructionsScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }


    



}

