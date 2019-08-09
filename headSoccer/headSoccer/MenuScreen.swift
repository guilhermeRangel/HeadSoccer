//
//  GameInit.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 07/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//


import SpriteKit
import AVFoundation

import UIKit

class MenuScreen: SKScene{
    
    let background2 = SKSpriteNode(imageNamed: "BGcapa")
    let btnInit = SKSpriteNode(imageNamed: "btnSingle")
    
    let btnMultiplayer = SKSpriteNode(imageNamed: "btnMultiplayer")
    let btnOthers = SKSpriteNode(imageNamed: "others")
    let trofeuG = SKSpriteNode(imageNamed: "trofeu1")
    let trofeuP = SKSpriteNode(imageNamed: "trofeu2")
    var buttomPointsSingle: CGRect?
    var buttomPointsMultiplayer: CGRect?
    var buttomPointsOther: CGRect?
    var skView : SKView?
    var gameScene : GameScene!
    let backgroundSound = SKAudioNode(fileNamed: "SupermassiveBlackHole")
    override func didMove(to view: SKView) {
      
         skView = view as! SKView
       gameScene = GameScene(size: view.bounds.size)
        

        skView?.showsFPS = false
        skView?.showsNodeCount = false
        skView?.showsPhysics = false
        skView?.ignoresSiblingOrder = true
        gameScene.scaleMode = .aspectFill
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        background2.anchorPoint = .zero
        background2.position = .zero
        background2.size.width = gameScene.size.width
        background2.size.height = gameScene.size.height
        background2.zPosition = 0
        addChild(background2)
        
        print(gameScene.size)
        
        
        btnInit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        btnInit.size = CGSize(width: btnInit.size.width * 1.6 , height: btnInit.size.height * 0.8)
        btnInit.position = CGPoint(x: (gameScene?.size.width)! / 2 + 10, y: (gameScene.size.height / 2) + 5)
        btnInit.zPosition = 1
        buttomPointsSingle = btnInit.calculateAccumulatedFrame()
        addChild(btnInit)
        
        
        btnMultiplayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        btnMultiplayer.size = CGSize(width: btnMultiplayer.size.width * 1.6, height: btnMultiplayer.size.height * 0.8)
        btnMultiplayer.position = CGPoint(x: (gameScene?.size.width)! / 2 + 10, y: (gameScene.size.height / 2) - 50)
        btnMultiplayer.zPosition = 1
        buttomPointsMultiplayer = btnMultiplayer.calculateAccumulatedFrame()
        addChild(btnMultiplayer)

        btnOthers.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        btnOthers.size = CGSize(width: btnOthers.size.width , height: btnInit.size.height * 0.8)
        btnOthers.position = CGPoint(x: (gameScene?.size.width)! / 2 + 10, y: (gameScene.size.height / 2) - 100)
        btnOthers.zPosition = 1
        buttomPointsOther = btnOthers.calculateAccumulatedFrame()
        addChild(btnOthers)
        
        trofeuG.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        trofeuG.size = CGSize(width: trofeuG.size.width , height: trofeuG.size.height)
        trofeuG.position = CGPoint(x: (gameScene?.size.width)! / 2 + 10, y: (gameScene.size.height / 2) - 100)
        trofeuG.zPosition = 1
       
       // addChild(trofeuG)
        
       createSoundBackground()
        
    }
    
    func createSoundBackground(){
       
        backgroundSound.run(SKAction.play())
        addChild(backgroundSound)
        
    }
    
    
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var firstTouch = touches.first?.location(in: self)
        
        if firstTouch!.x > buttomPointsSingle!.minX && firstTouch!.y > buttomPointsSingle!.minY && firstTouch!.x < buttomPointsSingle!.maxX && firstTouch!.y < buttomPointsSingle!.maxY{
            
            backgroundSound.run(SKAction.pause())
            skView?.presentScene(gameScene)
         
           
            
        }
        
        }
    
  
}
