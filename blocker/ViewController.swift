//
//  ViewController.swift
//  blocker
//
//  Created by Evan Conrad on 3/20/18.
//  Copyright © 2018 Evan Conrad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let blockerItems : BlockerItemManager
    
    required init?(coder aDecoder: NSCoder) {
        self.blockerItems = BlockerItemManager()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ReturnPressed(_ sender: UITextField, forEvent event: UIEvent) {
        guard let text = sender.text else {
            return
        }
        
        print(text) // TODO: create new BlockerDataSource, add it to the blocker item manager
    }
    
}

