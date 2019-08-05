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
    
    
    
    var scene: GameScene?
    
    fileprivate func createScene() {
        scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        scene?.scaleMode = .aspectFill
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -0.2)
        scene?.physicsBody = SKPhysicsBody.init(edgeLoopFrom: scene!.frame)
        skView.presentScene(scene!)
    }
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createScene()
        loadEntities()
    }
    
    
    
    
    
    fileprivate func loadEntities() {
        
//        let enemy = Personagem(type: .enemy)
//        scene?.entityManager.add(entity: enemy)
//        enemy.component(ofType: RenderComponent.self)
//
        let player = Personagem(type: .player)
        scene?.entityManager.add(entity: player)
        
        
        
     
        //player.component(ofType: PostionComponent.self)?.xxx()

        
        
    }
}



