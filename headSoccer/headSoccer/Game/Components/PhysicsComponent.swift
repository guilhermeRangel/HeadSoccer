//
//  PhysicsComponent.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 02/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import GameplayKit


final class PhysicsComponent: GKComponent {
    
    var node : SKNode
    
    
    
    init(nodePhysics: SKNode, type: Elements, nodeTexture: SKTexture) {
        self.node = nodePhysics
        super.init()
        
        let size = CGSize(width: nodeTexture.size().width / 5, height: nodeTexture.size().height / 5)
        
        switch type {
        case .player:
      
            node.physicsBody = SKPhysicsBody(texture: nodeTexture, alphaThreshold: 0, size: size)
            node.physicsBody?.affectedByGravity = true
            node.physicsBody?.isDynamic = true
            node.physicsBody?.categoryBitMask = 0b1
            node.physicsBody?.contactTestBitMask = UInt32.max
      
        
        case .enemy:
        
            node.physicsBody = SKPhysicsBody(texture: nodeTexture, alphaThreshold: 0, size: size)
            node.physicsBody?.affectedByGravity = true
            node.physicsBody?.isDynamic = true
            node.physicsBody?.categoryBitMask = 0b1
            node.physicsBody?.contactTestBitMask = UInt32.max
            
            
        case .ball:
            let sizee = CGSize(width: nodeTexture.size().width / 8, height: nodeTexture.size().height / 8)
            
            
            node.physicsBody = SKPhysicsBody(texture: nodeTexture, alphaThreshold: 0, size: sizee)
            node.physicsBody?.affectedByGravity = true
            node.physicsBody?.isDynamic = true
            node.physicsBody?.categoryBitMask = 0b10
            node.physicsBody?.contactTestBitMask = 0b1
        }
        
      
    }
        
        
        
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    
}
