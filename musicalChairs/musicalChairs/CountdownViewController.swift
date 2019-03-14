//
//  CountdownViewController.swift
//  musicalChairs
//
//  Created by Eva Philips on 3/14/19.
//  Copyright © 2019 eva&ada. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    // set variables
    var countDown: Int = 5;
    
    // set labels
    @IBOutlet weak var countDownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // display count down number
        countDownLabel.text = String(countDown)
        
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
