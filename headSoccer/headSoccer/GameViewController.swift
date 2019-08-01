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

 
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let scene = GameScene(size: view.bounds.size)
            let skView = view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
            
        }
        
   
    }



