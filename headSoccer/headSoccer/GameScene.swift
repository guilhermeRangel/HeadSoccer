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
    
    
    var player = SKSpriteNode(imageNamed: "player")
    var playerTexture = SKTexture(imageNamed: "player")
    
    
    override func didMove(to view: SKView) {
        createSceneContents()
        createPlayer()
        
        
        
    }
    
    func createPlayer(){
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: 0, y: 0  )
        player.size = CGSize(width: 100, height: 100)
        player.name = "player"
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.description
        player.physicsBody?.categoryBitMask = 0b1
        player.physicsBody?.contactTestBitMask =  UInt32.max
        player.physicsBody = SKPhysicsBody(texture: playerTexture, alphaThreshold: 0, size: player.size)
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
        
        
    }
    
    
    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self){
            
            if location.x < player.position.x {
                
                player.physicsBody?.applyImpulse(CGVector(dx: -30, dy: 0))
                print("esq")
            }
            else {
                player.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 0))
                print("dir")
            }
            
            if location.y > player.position.y + 120 {
                player.physicsBody?.applyImpulse(CGVector(dx: 120, dy: 0))
                print("pular")
            }
        }
    }
    
    
}
