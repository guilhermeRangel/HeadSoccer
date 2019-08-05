//
//  PersonagemEntity.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 02/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import GameplayKit
import SpriteKit



final class Personagem: GKEntity {
    
    
    
    
    var spriteComponent: SpriteComponent?
    var spritePhysics: PhysicsComponent?
    var positionComponent : PostionComponent?
    
    convenience init(type: Elements) {
        self.init()
        
        let renderComponent = RenderComponent(node: SKNode())
        addComponent(renderComponent)
        let scaleComponent = ScaleComponent(node: renderComponent.node)
        
        
        
        switch type {
        case .enemy:
            spriteComponent = SpriteComponent(imageNamed: "enemy")
            spriteComponent?.spriteNode.name = "enemy"
            positionComponent = PostionComponent(node: renderComponent.node, type: Elements.enemy)
            spritePhysics = PhysicsComponent(nodePhysics: spriteComponent!.spriteNode, type: Elements.enemy, nodeTexture: spriteComponent!.spriteNodeTexture)
            spriteComponent?.spriteNode.size = CGSize(width: (spriteComponent?.spriteNode.size.width)! / 5, height: (spriteComponent?.spriteNode.size.height)! / 5)
            
        case .player:
            spriteComponent = SpriteComponent(imageNamed: "player")
            spriteComponent?.spriteNode.name = "player"
             positionComponent = PostionComponent(node: renderComponent.node, type: Elements.player)
            spritePhysics = PhysicsComponent(nodePhysics: spriteComponent!.spriteNode, type: Elements.player, nodeTexture: spriteComponent!.spriteNodeTexture)
            spriteComponent?.spriteNode.size = CGSize(width: (spriteComponent?.spriteNode.size.width)! / 5, height: (spriteComponent?.spriteNode.size.height)! / 5)
            
        case .ball:
            spriteComponent = SpriteComponent(imageNamed: "ball")
            spriteComponent?.spriteNode.name = "ball"
            positionComponent = PostionComponent(node: renderComponent.node, type: Elements.ball)
            spritePhysics = PhysicsComponent(nodePhysics: spriteComponent!.spriteNode, type: Elements.ball, nodeTexture: spriteComponent!.spriteNodeTexture)
            spriteComponent?.spriteNode.size = CGSize(width: (spriteComponent?.spriteNode.size.width)! / 8, height: (spriteComponent?.spriteNode.size.height)! / 8)
            
        }

      
       
        addComponent(positionComponent!)
        addComponent(spritePhysics!)
        addComponent(spriteComponent!)
        
        renderComponent.node.addChild(spriteComponent!.spriteNode)
       
        
        addComponent(scaleComponent)
      
}
}
