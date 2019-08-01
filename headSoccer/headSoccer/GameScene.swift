//
//  GameScene.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 01/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    var player = SKSpriteNode(imageNamed: "meninaSaia")
    
    override func didMove(to view: SKView) {
        
        createSceneContents()
        
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        player.position = CGPoint(x: 0, y: 0  )
        player.size = CGSize(width: 100, height: 300)
        addChild(player)
     
    }
 

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    func createSceneContents() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.2)
        
        //esse linha controla a tela
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
         print(self.size)
        
    }
    
}
