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
    
    //hud elements
    var scoreLabelTimer: SKLabelNode!
    var scoreLabelPlayer: SKLabelNode!
    var scoreLabelEnemy: SKLabelNode!
    
    var score = 90 {
        didSet {
            scoreLabelTimer.text = "\(score)"
        }
    }
    
    var scorePlayer1 = 0 {
        didSet {
            scoreLabelPlayer.text = "\(scorePlayer1)"
        }
    }
    
    var scoreEnemy = 0 {
        didSet {
            scoreLabelEnemy.text = "\(scoreEnemy)"
        }
    }
    
    //player
    var player = SKSpriteNode(imageNamed: "player")
    var playerTexture = SKTexture(imageNamed: "player")
    var playerFrames: [SKTexture] = []
    
    
    
    
    
    var enemy = SKSpriteNode(imageNamed: "enemy")
    
    
    var ball = SKSpriteNode(imageNamed: "bola00")
   
 
    
    var ground = SKSpriteNode(imageNamed: "campo07")
    
     var menuSuperior = SKSpriteNode(imageNamed: "placarAndTime")
    
    var menuInferior = SKSpriteNode(imageNamed: "terra1")
    
    var goleiraEsq = SKSpriteNode(imageNamed: "goleiraEsq")
    var goleiraDir = SKSpriteNode(imageNamed: "goleiraDir")
    
    
    override func didMove(to view: SKView) {
       physicsWorld.contactDelegate = self
        addElements()
        
        
    }
    
    func addElements(){
        createSceneContents()
        createBackground()
        
       // createFaixa()
        createGoleiraEsq()
        createGoleirasDir()
        createMenuSuperior()
        createScroreTimer()
        createScrorePlayer()
        createScroreEnemy()
        
        createPlayer()
        createEnemy()
        createBall()
        decreseTimer()
        
    }
    
    func decreseTimer(){
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.score -= 1
            if self.score == 0 {
                self.endGame()
            }
           
           
        })
    }
    
    var canJump = true
    func controlJump() {
        canJump = false
        let timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { timer in
            self.canJump = true
        })
    }
    //HUDS
    func createScroreTimer() {
        scoreLabelTimer = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabelTimer.text = "90"
        scoreLabelTimer.fontSize = 18
        scoreLabelTimer.horizontalAlignmentMode = .center
        scoreLabelTimer.position = CGPoint(x: .zero, y: (scene?.size.height)! - (scene?.size.height)! * 0.71  )
        scoreLabelTimer.zPosition = 11
        addChild(scoreLabelTimer)
    }
    func createScrorePlayer() {
        scoreLabelPlayer = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabelPlayer.text = "0"
        scoreLabelPlayer.horizontalAlignmentMode = .center
        scoreLabelPlayer.position = CGPoint(x: .zero - 75, y: (scene?.size.height)! - (scene?.size.height)! * 0.70  )
        scoreLabelPlayer.zPosition = 11
        addChild(scoreLabelPlayer)
    }
    func createScroreEnemy() {
        scoreLabelEnemy = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabelEnemy.text = "0"
        scoreLabelEnemy.horizontalAlignmentMode = .center
        scoreLabelEnemy.position = CGPoint(x: .zero + 75, y: (scene?.size.height)! - (scene?.size.height)! * 0.70  )
        scoreLabelEnemy.zPosition = 11
        addChild(scoreLabelEnemy)
    }
    func createBackground(){
        ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ground.position = .zero
        ground.size = CGSize(width: (scene?.size.width)!, height: (scene?.size.height)! * 1.55)
        ground.name = "ground"
        ground.zPosition = 0
        addChild(ground)
    }
    
    func createFaixa(){
         menuInferior.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuInferior.position = CGPoint(x: .zero, y: (scene?.size.height)! - (scene?.size.height)! * 1.5  )
        menuInferior.size = CGSize(width: (scene?.size.width)!, height: (scene?.size.height)! * 0.3)
        menuInferior.zPosition = 1
        addChild(menuInferior)
    }
    
    func createMenuSuperior(){
        menuSuperior.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuSuperior.position = CGPoint(x: .zero, y: (scene?.size.height)! - (scene?.size.height)! * 0.66 )
        menuSuperior.size = CGSize(width: (scene?.size.width)! / 4, height: (scene?.size.height)! / 5 )
        menuSuperior.zPosition = 10
        addChild(menuSuperior)
    }
    
    func createGoleiraEsq(){
        goleiraEsq.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        goleiraEsq.position = CGPoint(x: -(scene?.size.width)! * 0.45, y: (scene?.size.height)! - (scene?.size.height)! * 1.15  )
        goleiraEsq.size = CGSize(width: 100, height: 200)
        goleiraEsq.zPosition = 4
        
        goleiraEsq.name = "goleiraEsq"
        
        goleiraEsq.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: goleiraEsq.size.width - (goleiraEsq.size.width) * 0.2, height: goleiraEsq.size.height))
        goleiraEsq.physicsBody?.affectedByGravity = false
        goleiraEsq.physicsBody?.allowsRotation = false
        goleiraEsq.physicsBody?.isDynamic = false
        goleiraEsq.physicsBody?.categoryBitMask = 0b1000
        goleiraEsq.physicsBody?.collisionBitMask = 0
        addChild(goleiraEsq)
    }
    
    func createGoleirasDir(){
        goleiraDir.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        goleiraDir.position = CGPoint(x: (scene?.size.width)! * 0.45, y: (scene?.size.height)! - (scene?.size.height)! * 1.15  )
        goleiraDir.size = CGSize(width: 100, height: 200)
        goleiraDir.zPosition = 4
        
        goleiraDir.name = "goleiraDir"
        
        goleiraDir.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: goleiraEsq.size.width - (goleiraEsq.size.width) * 0.2, height: goleiraEsq.size.height))
        goleiraDir.physicsBody?.affectedByGravity = false
        goleiraDir.physicsBody?.allowsRotation = false
        goleiraDir.physicsBody?.isDynamic = false
        goleiraDir.physicsBody?.categoryBitMask = 0b1000
        goleiraDir.physicsBody?.collisionBitMask = 0
        addChild(goleiraDir)
    }
    
    
    
    //MARK CREATE
    func createPlayer(){
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: -(scene?.size.width)! * 0.3, y: 0  )
        player.size = CGSize(width: 100, height: 100)
        player.name = "player"
      
        player.physicsBody = SKPhysicsBody(texture: playerTexture, alphaThreshold: 0, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        
        player.physicsBody?.categoryBitMask = 0b1
        player.physicsBody?.contactTestBitMask =  0b10
        player.physicsBody?.collisionBitMask = 0b10000
        player.physicsBody?.allowsRotation = false
        player.zPosition = 3
        addChild(player)
    }
    
    func createEnemy(){
        enemy.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        enemy.position = CGPoint(x: (scene?.size.width)! * 0.3, y: 0  )
        enemy.size = CGSize(width: 100, height: 100)
        enemy.name = "enemy"
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.affectedByGravity = true
        enemy.physicsBody?.isDynamic = true
        enemy.zPosition = 3
        enemy.physicsBody?.categoryBitMask = 0b1
        enemy.physicsBody?.contactTestBitMask =  0b10
        enemy.physicsBody?.collisionBitMask = 0b10000
        enemy.physicsBody?.allowsRotation =  false
//        addChild(enemy)
    }
    
    func createBall(){
        ball.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ball.position = CGPoint(x: 0, y: 0  )
        ball.size = CGSize(width: 35, height: 35)
        ball.name = "ball"
         ball.physicsBody = SKPhysicsBody(circleOfRadius: 17.5)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.categoryBitMask = 0b10
        ball.physicsBody?.contactTestBitMask =  0b1 | 0b1000
        ball.physicsBody?.collisionBitMask = 0b1 | 0b10000
        ball.zPosition = 3
        ball.physicsBody?.allowsRotation = true
        addChild(ball)
    }
    
    func createSceneContents() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)

        guard let rect = scene?.frame else { return }
        let rectCustom = CGRect(x: rect.origin.x, y: rect.origin.y + 50, width: rect.size.width, height: rect.size.height)
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom:  rectCustom)
        self.physicsBody?.categoryBitMask = 0b10000
        
    
    }
    
    
  
  
    
    //MARK EDIT ELEMENTS
    
    func editScore(){
        
    }
    
    func endGame(){
        
    }
    
    func spawnElements(){
        ball.position = .zero
        player.position = CGPoint(x: -(scene?.size.width)! * 0.3, y: 0)
        enemy.position = CGPoint(x: (scene?.size.width)! * 0.3, y: 0)
    }
    
    var time: Double = 0.0
    override func update(_ currentTime: TimeInterval) {
        
         if time + 5 <= currentTime {
            
        }
        
        // Called before each frame is rendered
    }
    
    
    
    var firstTouch: CGPoint?
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        firstTouch = touches.first?.location(in: self)
        
        if firstTouch!.x >= 0{
        
            player.physicsBody?.allowsRotation = true
            let shoot = SKAction.rotate(byAngle: .pi/2, duration: 0.2)
            player.run(shoot)
        }
      
        player.zRotation = 0
        

    }
    
    //MARK: MOVIMENTOS
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let location = touches.first?.location(in: self){
            //print(location)
            if location.x < 0 {
                if location.x < firstTouch!.x{
                    print("FOI PRA ESQUERDA")
                    player.physicsBody?.applyImpulse(CGVector(dx: -3, dy: 0))
                }
                if location.x > firstTouch!.x{
                    print("FOI PRA DIREITA")
                    player.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
                }
                if location.y > firstTouch!.y + 150 && canJump{
                    print("FOI PRA DIREITA")
                    player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 125))
                    controlJump()
                }
            }
     
        }
    }
    
    //MARK CONTATATOS
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else { return}
        
        if((nodeA.name == "player" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "player")){
          ball.physicsBody?.applyForce(CGVector(dx: 2, dy: 1))

        }
        
        if((nodeA.name == "player" && nodeB.name == "enemy") ||
            (nodeA.name == "enemy" && nodeB.name == "player")){
            print("player colidiu com enemy")
            
        }
        
        if((nodeA.name == "enemy" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "enemy")){
            print("enemy colidiu com bola")
            
        }
        
        if((nodeA.name == "goleiraEsq" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "goleiraEsq")){
            print("enemy colidiu com bola")
            scoreEnemy += 1
            spawnElements()
        }
        if((nodeA.name == "goleiraDir" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "goleiraDir")){
            print("enemy colidiu com bola")
            scorePlayer1 += 1
            spawnElements()
        }
        
        if((nodeA.name == "" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "enemy")){
            print("enemy colidiu com bola")
            
        }
    }

}
