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
    
    enum PersonagemSelected {
        case player
        case enemy
    }
    
    
    var spriteComponent: SpriteComponent?
    var spritePhysics: PhysicsComponent?
  
      //MARK: controla a escala do do personagem
    let multiplier: CGFloat = 0.2
    
    convenience init(type: PersonagemSelected) {
        self.init()
        
        let renderComponent = RenderComponent(node: SKNode())
        addComponent(renderComponent)
        
        let positionComponent = PostionComponent(node: renderComponent.node)
        
        
        switch type {
        case .enemy:
            spriteComponent = SpriteComponent(imageNamed: "enemy")
            spriteComponent?.spriteNode.name = "enemy"
          
        
        case .player:
            spriteComponent = SpriteComponent(imageNamed: "player")
            spriteComponent?.spriteNode.name = "player"
           
            
            
        }
        
        spriteComponent?.spriteNode.size = CGSize(width: spriteComponent!.spriteNode.size.width * multiplier, height: spriteComponent!.spriteNode.size.height * multiplier)
        spritePhysics = PhysicsComponent(nodePhysics: spriteComponent!.spriteNode, type: PersonagemSelected.player, nodeTexture: spriteComponent!.spriteNodeTexture, multiplier: multiplier)
      
       
        addComponent(positionComponent)
        addComponent(spritePhysics!)
        addComponent(spriteComponent!)
        
        renderComponent.node.addChild(spriteComponent!.spriteNode)
       
//        let scaleComponent = ScaleComponent(node: renderComponent.node)
//        addComponent(scaleComponent)
    }

}
