//
//  Faixa.swift
//  PiratasViking
//
//  Created by Flavio Mitsuyoshi Tamanaha Ota on 03/04/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation
// MARK: - Class Definition
class Faixa : CCSprite {
    
    // MARK: - Public Objects
    var life:CGFloat = 3.0
    var fundo:CCSprite = CCSprite()
    
    // MARK: - Private Objects
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.fundo = CCSprite(imageNamed: "energiaAmarela-ipad.png")
        self.fundo.position = CGPointMake(0.0, 0.0)
        self.fundo.anchorPoint = CGPointMake(0.0, 0.0)
        self.fundo.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height)
        self.addChild(fundo, z:5)
        
        
    }
    
    override init(CGImage image: CGImage!, key: String!) {
        super.init(CGImage: image, key: key)
    }
    
    override init(spriteFrame: CCSpriteFrame!) {
        super.init(spriteFrame: spriteFrame)
    }
    
    override init(texture: CCTexture!) {
        super.init(texture: texture)
    }
    
    override init(texture: CCTexture!, rect: CGRect) {
        super.init(texture: texture, rect: rect)
    }
    
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) {
        super.init(texture: texture, rect: rect, rotated: rotated)
    }
    
    override init(imageNamed imageName: String!) {
        super.init(imageNamed: imageName)
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Kinematic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.1
        self.physicsBody.mass = 100.0
        self.physicsBody.density = 100.0
        self.physicsBody.collisionType = "Faixa"
        self.physicsBody.collisionCategories = ["Faixa"]
        self.physicsBody.collisionMask = ["PirataPerneta", "PirataPeixe"]
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Private Methods
    
    // MARK: - Public Methods
    func verificaLife() {
        if (self.life < 2) {
            self.fundo = CCSprite(imageNamed: "energiaVermelha-ipad.png")
            self.addChild(fundo, z:5)
        } else if (self.life < 3) {
            self.fundo = CCSprite(imageNamed: "energiaAmarela-ipad.png")
            self.addChild(fundo, z:5)
        }
    }
    
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    deinit {
        // Chamado no momento de desalocacao
    }
}
