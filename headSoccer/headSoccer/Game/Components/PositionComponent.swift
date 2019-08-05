//
//  PositionComponent.swift
//  headSoccer
//
//  Created by Guilherme Rangel on 02/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import GameplayKit


final class PostionComponent: GKComponent {

    var node: SKNode
    

    init(node: SKNode, type: Elements) {
        self.node = node
        super.init()
      
        switch type {
        case .player:
            node.position = CGPoint(x: -250,
                                    y: (0 - ((node.position.y) / 2) * 0.5))
        case .enemy:
            node.position = CGPoint(x: 250,
                                    y: (0 - ((node.position.y) / 2) * 0.5))
        
        case .ball:
            node.position = .zero
        }
      
     
        

        

//        node.position = CGPoint(x: (0 - ((node.position.x) / 2) * 0.8),
//                                y: (0 - ((node.position.y) / 2) * 0.5))

        //MARK - AJUSTAR CONFORME A SCENE
       
    }
    
    func setPositionPlayer(node: SKNode){
     
       
    }
    
    func setPositionHud (){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
