//
//  GameScene.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 01/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation
import GoogleMobileAds
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate, GADInterstitialDelegate {
    var controlFinish = false
    //hud elements
    var scoreLabelTimer: SKLabelNode!
    var scoreLabelPlayer: SKLabelNode!
    var scoreLabelEnemy: SKLabelNode!
    
    var entityy:GKEntity?
    var enemyAgente:GKAgent2D?
    var ballAgente:GKAgent2D?
    var seekBehavior:GKBehavior?
    var gkGoal: GKGoal?
    var timeStamp = 0.0
    
    var pausePoints: CGRect?
    var cenaPausada = false
    
    var gameFinished = false
    
    var score = 90 {didSet { scoreLabelTimer.text = "\(score)"}}
    var scorePlayer1 = 0 {didSet {scoreLabelPlayer.text = "\(scorePlayer1)"}}
    var scoreEnemy = 0 {didSet {scoreLabelEnemy.text = "\(scoreEnemy)"}}
    var player = SKSpriteNode(imageNamed: "player")
    var enemy = SKSpriteNode(imageNamed: "jog3-1")
    var ball = SKSpriteNode(imageNamed: "bola00")
    var ground = SKSpriteNode(imageNamed: "campo07")
    var menuSuperior = SKSpriteNode(imageNamed: "placarAndTime")
    var menuInferior = SKSpriteNode(imageNamed: "terra1")
    var goleiraEsq = SKSpriteNode(imageNamed: "goleiraEsq")
    var goleiraDir = SKSpriteNode(imageNamed: "goleiraDir")
    var emptyNodeEsq = SKNode() // goleira
    var emptyNodeDir = SKNode() // goleira
    var controleDoTimer = true
    

   var interstitial: GADInterstitial!
    
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        addElements()
        setiA()
        enemyAgente?.delegate = self
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
       interstitial = createAndLoadInterstitial()
    }
          
    
    func createSoundBackground(){
        scene?.run(SKAction.playSoundFileNamed("fundoGameSoccer", waitForCompletion: false))
        
    }
    
    func createSoundApito(){
        player.run(SKAction.playSoundFileNamed("finalGame", waitForCompletion: false))
        
        
    }
    
    
    func addElements(){
        createSceneContents()
        createBackground()
        createGoleiraEsq()
        createGoleirasDir()
        createMenuSuperior()
        createScroreTimer()
        createScrorePlayer()
        createScroreEnemy()
        createPlayer()
        createEnemy()
        createBall()
        createPause()
        controleDoTimer = true
        decreseTimer()
        createEmptyNode()
        createSoundBackground()
        scene?.isPaused = false

    }
    
    var goalFlee: GKGoal?
    
    func setiA(){
        let ballAgent =  GKAgent2D()
        ballAgent.position = vector_float2(x: Float((ball.position.x)), y: Float((-108)))
        ballAgent.radius = 0.2
        
        let enemyAgent = GKAgent2D()
        enemyAgent.position = vector_float2(x: Float((enemy.position.x)), y: Float((-108)))
        gkGoal = GKGoal(toSeekAgent: ballAgent)
        goalFlee = GKGoal(toFleeAgent: ballAgent)
        seekBehavior = GKBehavior(goals: [gkGoal!])
        
        
        
        
       
        enemyAgent.mass = 0.02
        enemyAgent.maxSpeed = 100.0
        enemyAgent.maxAcceleration = 1000.0
        enemyAgent.behavior = seekBehavior
        enemyAgent.radius = 0.8
        
        
//        seekBehavior?.remove(goalFlee!)
//
//        run(.wait(forDuration: 2.0)) {
//
//            self.seekBehavior?.setWeight(1.0, for: self.goalFlee!)
//        }
        
        
        self.ballAgente = ballAgent
        self.enemyAgente = enemyAgent
    }
    
    
    //controle do game
    
    func decreseTimer(){
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: controleDoTimer, block: { timer in
            if self.controleDoTimer{
                
                self.score -= 1
                
            }
            if self.score == 0 {
                self.controleDoTimer = false
                self.endGame()
                
            }
            
            if self.gameFinished{
                timer.invalidate()
                self.controleDoTimer = false
            }
        })
    }
    
    var canShoot = true
    var shootState = true
    func controlBotShoot() {
        canShoot = false
        shootState = false
        let timerReturn = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { timer in
            let shoot = SKAction.rotate(byAngle: .pi/2, duration: 0.2)
            self.enemy.run(shoot)
          
          //  self.enemy.zRotation = 0
        })
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { timer in
            self.canShoot = true
            self.shootState = true
        })
    }
    
    var canJump = true
    var jumpState = true
    func controlJump() {
        canJump = false
        jumpState = false
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { timer in
            self.canJump = true
            self.jumpState = true
            self.player.zRotation = 0
        })
    }
    //oculto physiscs
    
    func createEmptyNode(){
        emptyNodeEsq.name = "emptyNodeEsq"
        emptyNodeDir.name = "emptyNodeDir"
        
        emptyNodeEsq.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: goleiraEsq.size.width, height: goleiraEsq.size.height))
        emptyNodeEsq.position = CGPoint(x: -(scene?.size.width)! * 0.45, y: (scene?.size.height)! - (scene?.size.height)! * 0.7  )
        emptyNodeEsq.physicsBody?.categoryBitMask = 0b100000
        emptyNodeEsq.physicsBody?.contactTestBitMask = 0b10
        emptyNodeEsq.physicsBody?.collisionBitMask = 0
        emptyNodeEsq.physicsBody?.isDynamic = false
        emptyNodeEsq.physicsBody?.allowsRotation = false
        emptyNodeEsq.physicsBody?.affectedByGravity = false
        //-=-=-=
        emptyNodeDir.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: goleiraEsq.size.width, height: goleiraEsq.size.height))
        emptyNodeDir.position = CGPoint(x: (scene?.size.width)! * 0.45, y: (scene?.size.height)! - (scene?.size.height)! * 0.7  )
        emptyNodeDir.physicsBody?.categoryBitMask = 0b100000
        emptyNodeDir.physicsBody?.contactTestBitMask = 0b10
        emptyNodeDir.physicsBody?.collisionBitMask = 0
        emptyNodeDir.physicsBody?.isDynamic = false
        emptyNodeDir.physicsBody?.allowsRotation = false
        emptyNodeDir.physicsBody?.affectedByGravity = false
        addChild(emptyNodeEsq)
        addChild(emptyNodeDir)
    }
    
    //HUDS
    func createScroreTimer() {
       
        scoreLabelTimer = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabelTimer.text = "90"
        scoreLabelTimer.fontSize = 18
        scoreLabelTimer.horizontalAlignmentMode = .center
        scoreLabelTimer.position = CGPoint(x: .zero, y: (scene?.size.height)! - (scene?.size.height)! * 0.71  )
        scoreLabelTimer.zPosition = 11
        score = 90
        addChild(scoreLabelTimer)
    }
    
    func createPause() {
        let youWin = SKSpriteNode(imageNamed: "pause")
        youWin.anchorPoint = .zero
        youWin.position = CGPoint(x: 350, y: 100)
        youWin.size.width = 80
        youWin.size.height = 80
        youWin.zPosition = 12
        pausePoints = youWin.calculateAccumulatedFrame()
        addChild(youWin)
    }
    
    func createScrorePlayer() {
        scoreLabelPlayer = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabelPlayer.text = "0"
        scoreLabelPlayer.horizontalAlignmentMode = .center
        scoreLabelPlayer.position = CGPoint(x: .zero - 75, y: (scene?.size.height)! - (scene?.size.height)! * 0.70  )
        scoreLabelPlayer.zPosition = 11
        scorePlayer1 = 0
        addChild(scoreLabelPlayer)
    }
    func createScroreEnemy() {
        scoreLabelEnemy = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabelEnemy.text = "0"
        scoreLabelEnemy.horizontalAlignmentMode = .center
        scoreLabelEnemy.position = CGPoint(x: .zero + 75, y: (scene?.size.height)! - (scene?.size.height)! * 0.70  )
        scoreLabelEnemy.zPosition = 11
        scoreEnemy = 0
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
        menuSuperior.zPosition = 2
        addChild(menuSuperior)
    }
    
    func createGoleiraEsq(){
        goleiraEsq.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        goleiraEsq.position = CGPoint(x: -(scene?.size.width)! * 0.45, y: (scene?.size.height)! - (scene?.size.height)! * 1.15  )
        goleiraEsq.size = CGSize(width: 100, height: 200)
        goleiraEsq.zPosition = 4
        goleiraEsq.name = "goleiraEsq"
        goleiraEsq.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: goleiraEsq.size.width - (goleiraEsq.size.width) * 0.3, height: goleiraEsq.size.height * 0.9) )
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
        goleiraDir.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: goleiraEsq.size.width - (goleiraEsq.size.width) * 0.3, height: goleiraEsq.size.height * 0.9) )
        goleiraDir.physicsBody?.affectedByGravity = false
        goleiraDir.physicsBody?.allowsRotation = false
        goleiraDir.physicsBody?.isDynamic = false
        goleiraDir.physicsBody?.categoryBitMask = 0b1000
        goleiraDir.physicsBody?.collisionBitMask = 0
        addChild(goleiraDir)
    }
    
    func createPlayer(){
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: -(scene?.size.width)! * 0.3, y: 0)
        player.size = CGSize(width: 65, height: 65)
        player.name = "player"
        player.physicsBody = SKPhysicsBody(bodies: [SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height / 2), center: CGPoint(x: 0, y: -30)),
                                                    SKPhysicsBody.init(circleOfRadius: player.size.width / 4  , center: CGPoint(x: -15, y: +10))])
        // player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height), center: .zero)
        player.physicsBody?.mass = 0.25
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
        enemy.position = CGPoint(x: (scene?.size.width)! * 0.3, y: -108  )
        enemy.size = CGSize(width: 65, height: 65)
        enemy.name = "enemy"
        enemy.physicsBody = SKPhysicsBody(bodies: [SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height / 2), center: CGPoint(x: 0, y: -30)),
                                                   SKPhysicsBody.init(circleOfRadius: player.size.width / 4  , center: CGPoint(x: 15, y: +10))])
        enemy.physicsBody?.affectedByGravity = true
        enemy.physicsBody?.isDynamic = true
        enemy.zPosition = 3
        enemy.physicsBody?.categoryBitMask = 0b1
        enemy.physicsBody?.contactTestBitMask =  0b10
        enemy.physicsBody?.collisionBitMask = 0b10000
        enemy.physicsBody?.allowsRotation =  false
        addChild(enemy)
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
        ball.physicsBody?.contactTestBitMask =  0b1 | 0b1000 | 0b100000 | 0b10000
        ball.physicsBody?.collisionBitMask = 0b1 | 0b10000 | 0b100000
        ball.zPosition = 3
        ball.physicsBody?.allowsRotation = true
        ballAgente?.position.x = Float(ball.position.x)
        ballAgente?.position.y = Float(ball.position.y)
        addChild(ball)
    }
    
    func createSceneContents() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.name = "scene"
        guard let rect = scene?.frame else { return }
        let rectCustom = CGRect(x: rect.origin.x, y: rect.origin.y + 50, width: rect.size.width, height: rect.size.height)
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom:  rectCustom)
        self.physicsBody?.categoryBitMask = 0b10000
        self.physicsBody?.contactTestBitMask = 0b10
        self.physicsBody?.collisionBitMask = 0b10
    }
    
    
    var playAgainPoints: CGRect?
    var homePoints: CGRect?
    //MARK EDIT ELEMENTS
    func endGame(){
        gameFinished = true
        var playAgain = SKSpriteNode(imageNamed: "playAgain")
        var home = SKSpriteNode(imageNamed: "home")
        
        playAgain.anchorPoint = .zero
        playAgain.position = CGPoint(x: -150, y: -150)
        playAgain.size.width = (scene?.size.width)!/8
        playAgain.size.height = (scene?.size.height)!/5
        playAgain.zPosition = 4
        playAgainPoints = playAgain.calculateAccumulatedFrame()
        addChild(playAgain)
        
        home.anchorPoint = .zero
        home.position = CGPoint(x: 40, y: -160)
        home.size.width = (scene?.size.width)!/8
        home.size.height = (scene?.size.height)!/5
        home.zPosition = 5
        homePoints = home.calculateAccumulatedFrame()
        addChild(home)
        
        if scorePlayer1 > scoreEnemy {
            let youWin = SKSpriteNode(imageNamed: "youwin")
            youWin.anchorPoint = .zero
            youWin.position = CGPoint(x: -160, y: -80)
            youWin.size.width = (scene?.size.width)!/3
            youWin.size.height = (scene?.size.height)!/2
            youWin.zPosition = 6
            addChild(youWin)
        }else if scoreEnemy > scorePlayer1 {
            let youlose = SKSpriteNode(imageNamed: "youlose")
            youlose.anchorPoint = .zero
            youlose.position = CGPoint(x: -160, y: -80)
            youlose.size.width = (scene?.size.width)!/3
            youlose.size.height = (scene?.size.height)!/2
            youlose.zPosition = 6
            addChild(youlose)
        }else {
            let draw = SKSpriteNode(imageNamed: "draw")
            draw.anchorPoint = .zero
            draw.position = CGPoint(x: -160, y: -80)
            draw.size.width = (scene?.size.width)!/3
            draw.size.height = (scene?.size.height)!/2
            draw.zPosition = 6
            addChild(draw)        }
        
        
        scene?.isPaused = true
        let viewController = view?.findViewController()
        interstitial.present(fromRootViewController: viewController!)
        
    }
    
    func spawnElements(nodaA: String, nodeB: String){
        ball.removeFromParent()
        player.removeFromParent()
        enemy.removeFromParent()
        
        ball.position = .zero
        player.position = CGPoint(x: -(scene?.size.width)! * 0.3, y: -108)
        enemy.position = CGPoint(x: (scene?.size.width)! * 0.3, y: -108)
        enemyAgente?.position = vector_float2(x: Float((enemy.position.x)), y: Float((-108.0)))
        ballAgente?.position = vector_float2(x: Float((ball.position.x)), y: Float((-108)))
        addChild(ball)
        addChild(player)
        addChild(enemy)
        if nodaA == "goleiraEsq"  || nodeB == "goleiraEsq" {
            ball.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 30))
        }else if nodaA == "goleiraDir"  || nodeB == "goleiraDir" {
            ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 30))
        }
    }
    
    
    let value = 5.0 as Float
    override func update(_ currentTime: TimeInterval) {
        if scoreEnemy == 7 || scorePlayer1 == 7 || score == 0 && !controlFinish{
            controlFinish = true
            endGame()
        }
        if scene != nil {
            if timeStamp == 0.0 {
                timeStamp = currentTime
                enemyAgente?.position = vector_float2(x: Float((enemy.position.x)), y: Float((-108)))
                
            } else {
    
                ballAgente?.position = vector_float2(x: Float((ball.position.x)), y: Float((-108)))
                enemyAgente?.update(deltaTime: currentTime - timeStamp)
                timeStamp = currentTime
            }
            

            if enemy.position.x < -20 && seekBehavior!.weight(for: goalFlee!) == 0.0 {
                enemyAgente!.behavior!.setWeight(value, for: goalFlee!)
            } else if seekBehavior!.weight(for: goalFlee!) == value && enemy.position.x > 0{
                seekBehavior?.remove(goalFlee!)

              
            }
        }
        
        if player.position.y < -110{
            player.position.y = -105
        }
        
        if enemy.position.x < -30 {
            enemy.position.x = -29
        }
        
        if enemy.position.y < -110{
            player.position.y = -105
        }
        
    }
    
    
    
    var firstTouch: CGPoint?
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstTouch = touches.first?.location(in: self)
        if firstTouch!.x >= 0{

            player.physicsBody?.allowsRotation = true
            let shoot = SKAction.rotate(byAngle: .pi/2, duration: 0.2)
            player.run(shoot)
            
            let timerReturn = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { timer in
                let shoot = SKAction.rotate(byAngle: -.pi/2, duration: 0.2)
                self.player.run(shoot)
                
                //  self.enemy.zRotation = 0
            })
            
        }
        if firstTouch!.x > pausePoints!.minX && firstTouch!.y > pausePoints!.minY && firstTouch!.x < pausePoints!.maxX && firstTouch!.y < pausePoints!.maxY{
            if cenaPausada == false{
                scene?.isPaused = true
                cenaPausada = true
            }
            else if cenaPausada == true{
                scene?.isPaused = false
                cenaPausada = false
            }
        }
        player.zRotation = 0
        
        if gameFinished{
            if firstTouch!.x > homePoints!.minX && firstTouch!.y > homePoints!.minY && firstTouch!.x < homePoints!.maxX && firstTouch!.y < homePoints!.maxY{
                mainMenu()
                
            }
            if firstTouch!.x > playAgainPoints!.minX && firstTouch!.y > playAgainPoints!.minY && firstTouch!.x < playAgainPoints!.maxX && firstTouch!.y < playAgainPoints!.maxY{
                //reinicia partida
                self.removeAllChildren()
                self.removeFromParent()
                self.removeAllActions()

                controleDoTimer = false
                gameFinished = false
                addElements()
            }
            //tratar toque em new game e home
        }
    }
    
    
    func mainMenu(){
        let skView = view as! SKView
        var menuScene: MenuScreen?
        menuScene = MenuScreen(size: (view?.bounds.size)!)
        menuScene?.scaleMode = .aspectFit
        skView.presentScene(menuScene)
    }
    
    //MARK: MOVIMENTOS
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let location = touches.first?.location(in: self){
            if location.x < 0 {
                if location.x < firstTouch!.x{player.physicsBody?.applyImpulse(CGVector(dx: -3, dy: 0))}
                if location.x > firstTouch!.x{player.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))}
            }
            if location.y > firstTouch!.y + 100 && canJump{
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
                controlJump()
            }
        }
    }
    
    //MARK CONTATATOS
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else { return}
        
        //player e bola
        if((nodeA.name == "player" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "player")){
            
            if !jumpState{ball.physicsBody?.applyImpulse(CGVector(dx: 45, dy: 10))}
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 13))
            
        }
        //player e inimigo
        if((nodeA.name == "player" && nodeB.name == "enemy") ||
            (nodeA.name == "enemy" && nodeB.name == "player")){
            player.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0))
            enemy.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 0))
            
        }
        
        //goleira esq e bola
        if((nodeA.name == "goleiraEsq" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "goleiraEsq")){
            // print("enemy colidiu com bola")
            scoreEnemy += 1
            spawnElements(nodaA: nodeA.name!, nodeB: nodeB.name!)
            createSoundApito()
        }
        //goleira dir e bola
        if((nodeA.name == "goleiraDir" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "goleiraDir")){
            //print("enemy colidiu com bola")
            scorePlayer1 += 1
            spawnElements(nodaA: nodeA.name!, nodeB: nodeB.name!)
            createSoundApito()
        }
        //chute do inimigo
        if((nodeA.name == "enemy" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "enemy")){
            //print("bola colidiu com parte de cima do gol emptyNodeDir")
            //        enemy.physicsBody?.allowsRotation = true
            if canShoot{
                let shoot = SKAction.rotate(byAngle: -.pi/2, duration: 0.2)
                enemy.run(shoot)
                controlBotShoot()
            }
            
            enemy.zRotation = 0
            enemy.physicsBody?.applyImpulse(CGVector(dx: -30, dy: 20))
        }
        
        if((nodeA.name == "emptyNodeDir" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "emptyNodeDir")){
            //print("bola colidiu com parte de cima do gol emptyNodeDir")

            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 0))

        }
        
        if((nodeA.name == "emptyNodeEsq" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "emptyNodeEsq")){
            // print("bola colidiu com parte de cima do gol emptyNodeEsq")


            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 0))

            
        }
        
        if((nodeA.name == "scene" && nodeB.name == "ball") ||
            (nodeA.name == "ball" && nodeB.name == "scene")) {
            //print("bola com scene")
            let number = Int.random(in: 0 ... 10)
            if number > 8 {
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 15))
            }
            
            
            
        }
    }
    
}



extension GameScene: GKAgentDelegate{
    
    
    func agentDidUpdate(_ agent: GKAgent) {
        if let agent = agent as? GKAgent2D{
            if agent == enemyAgente {
                enemy.position = CGPoint(x: Double(agent.position.x), y: Double(agent.position.y))
            }
        }
    }
}


extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
