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
    
    let background2 = SKSpriteNode(imageNamed: "campo1")
    let btnInit = SKSpriteNode(imageNamed: "btnInit")
    var buttomPoints: CGRect?
    var skView : SKView?
    var gameScene : GameScene!
    override func didMove(to view: SKView) {
      
         skView = view as! SKView
       gameScene = GameScene(size: view.bounds.size)
        

        skView?.showsFPS = true
        skView?.showsNodeCount = true
        skView?.showsPhysics = true
        skView?.ignoresSiblingOrder = true
        gameScene.scaleMode = .aspectFill
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        background2.anchorPoint = .zero
        background2.position = .zero
        background2.size.width = gameScene.size.width
        background2.size.height = gameScene.size.height
        background2.zPosition = 0
        addChild(background2)
        
        
        
        btnInit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        btnInit.size = CGSize(width: 300, height: 50)
        btnInit.position = CGPoint(x: (gameScene?.size.width)! / 2, y: (gameScene.size.height / 2) - 20 )
        btnInit.zPosition = 1
        buttomPoints = btnInit.calculateAccumulatedFrame()
        addChild(btnInit)
    }
    
    
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var firstTouch = touches.first?.location(in: self)
        
        if firstTouch!.x > buttomPoints!.minX && firstTouch!.y > buttomPoints!.minY && firstTouch!.x < buttomPoints!.maxX && firstTouch!.y < buttomPoints!.maxY{
            
           
            skView?.presentScene(gameScene)
         
           
            
        }
        
        }
    
  
}
