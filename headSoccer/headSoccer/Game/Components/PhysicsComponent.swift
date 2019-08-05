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
    
    
    
    init(nodePhysics: SKNode, type: Personagem.PersonagemSelected, nodeTexture: SKTexture, multiplier: CGFloat = 1) {
        self.node = nodePhysics
        super.init()
        
        
        switch type {
        case .player:
            let size = CGSize(width: nodeTexture.size().width * multiplier, height: nodeTexture.size().height * multiplier)
                        node.physicsBody = SKPhysicsBody(texture: nodeTexture, alphaThreshold: 0, size: size)
                        node.physicsBody?.affectedByGravity = true
                        node.physicsBody?.isDynamic = true
                        node.physicsBody?.categoryBitMask = 0b1
                        node.physicsBody?.contactTestBitMask = UInt32.max
      
        
        case .enemy:
            let size = CGSize(width: nodeTexture.size().width * multiplier, height: nodeTexture.size().height * multiplier)
            node.physicsBody = SKPhysicsBody(texture: nodeTexture, alphaThreshold: 0, size: size)
            node.physicsBody?.affectedByGravity = true
            node.physicsBody?.isDynamic = true
            node.physicsBody?.categoryBitMask = 0b1
            node.physicsBody?.contactTestBitMask = UInt32.max
        }
    }
        
        
        
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    
}
