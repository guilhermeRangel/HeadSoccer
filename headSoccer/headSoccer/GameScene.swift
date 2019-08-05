//
//  GameScene.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 01/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var player = SKSpriteNode(imageNamed: "player")
    var playerTexture = SKTexture(imageNamed: "player")
    
    var enemy = SKSpriteNode(imageNamed: "enemy")
    var enemyTexture = SKTexture(imageNamed: "enemy")
    
    var ball = SKSpriteNode(imageNamed: "ball")
    var ballTexture = SKTexture(imageNamed: "ball")
    
    override func didMove(to view: SKView) {
       physicsWorld.contactDelegate = self
        addElements()
        
        
    }
    
    func addElements(){
        createSceneContents()
        createPlayer()
        createEnemy()
        createBall()
    }
    
    func createPlayer(){
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: -100, y: 0  )
        player.size = CGSize(width: 100, height: 100)
        player.name = "player"
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = 0b1
        player.physicsBody?.contactTestBitMask =  0b10
        player.physicsBody = SKPhysicsBody(texture: playerTexture, alphaThreshold: 0, size: player.size)
        addChild(player)
    }
    
    func createEnemy(){
        enemy.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        enemy.position = CGPoint(x: 200, y: 0  )
        enemy.size = CGSize(width: 100, height: 100)
        enemy.name = "enemy"
        enemy.physicsBody?.affectedByGravity = true
        enemy.physicsBody?.isDynamic = true
        
        enemy.physicsBody?.categoryBitMask = 0b10
        enemy.physicsBody?.contactTestBitMask =  0b100
        enemy.physicsBody = SKPhysicsBody(texture: enemyTexture, alphaThreshold: 0, size: enemy.size)
        addChild(enemy)
    }
    
    func createBall(){
        ball.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ball.position = CGPoint(x: 0, y: 0  )
        ball.size = CGSize(width: 50, height: 50)
        ball.name = "ball"
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.categoryBitMask = 0b10
        ball.physicsBody?.contactTestBitMask =  0b1
        ball.physicsBody = SKPhysicsBody(texture: ballTexture, alphaThreshold: 0, size: ball.size)
        addChild(ball)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    func createSceneContents() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
        
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
            
            if location.y > player.position.y + 60 {
                player.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
                print("pular")
            }
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else { return}
        
        if((nodeA.name == "player" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "player")){
          print("player colidiu com a bola")

        }
        
        if((nodeA.name == "player" && nodeB.name == "enemy") ||
            (nodeA.name == "enemy" && nodeB.name == "player")){
            print("player colidiu com enemy")
            
        }
        
        if((nodeA.name == "enemy" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "enemy")){
            print("enemy colidiu com bola")
            
        }
    }

}
