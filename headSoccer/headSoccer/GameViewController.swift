//
//  GameViewController.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 01/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var menuScene: MenuScreen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as! SKView
        
        menuScene = MenuScreen(size: view.bounds.size)
        menuScene?.scaleMode = .aspectFit
        skView.presentScene(menuScene)
        
        
        
       
        
        
    }
    
    
}



