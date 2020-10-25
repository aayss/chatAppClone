//
//  SplashScreen.swift
//  messangerapp
//
//  Created by Ays  on 25.10.2020.
//  Copyright © 2020 AyseCengiz. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {

  var timer: Timer?
    var runCount = 0
       
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    

     @objc func fireTimer() {
           
           runCount += 1

           if runCount == 2 {
               
               runCount = 0
               timer?.invalidate()
               
               performSegue(withIdentifier: "splashToMainSegue", sender: nil)
             
           }
       }
}
