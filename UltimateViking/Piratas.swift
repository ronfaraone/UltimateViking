//
//  Piratas.swift
//  UltimateViking
//
//  Created by Ronaldo Faraone on 3/30/15.
//  Copyright (c) 2015 Fiap. All rights reserved.
//

import Foundation

// MARK: - Class Definition
class Piratas : CCSprite {
    
    // MARK: - Public Objects
    
    var gameSceneRef:GameScene?
    
    // MARK: - Private Objects
    var numShots:Int = 5
    var shootDelayCount:Int = 0
    private var spritePirataPerneta:CCSprite?
    private var spritePirataPeixe:CCSprite?
    
    // MARK: - Life Cycle
    override init() {
        super.init()
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
        
        // Cria o sprite do pirata perneta
        self.spritePirataPerneta = self.gerarAnimacaoSpriteWithName("Enemy", aQtdFrames: 18)
        self.spritePirataPerneta!.anchorPoint = CGPointMake(0.5, 0.5);
        self.spritePirataPerneta!.position = CGPointMake(0.0, 0.0);
        self.addChild(self.spritePirataPerneta, z:2)
        
        // Cria o sprite do pirata perneta
        self.spritePirataPeixe = self.gerarAnimacaoSpriteWithName("Enemy", aQtdFrames: 18)
        self.spritePirataPeixe!.anchorPoint = CGPointMake(0.5, 0.5);
        self.spritePirataPeixe!.position = CGPointMake(0.0, 0.0);
        self.addChild(self.spritePirataPeixe, z:1)

        
        // Configuracoes default
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Kinematic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.1
        self.physicsBody.mass = 100.0
        self.physicsBody.density = 100.0
        self.physicsBody.collisionType = "Enemy"
        self.physicsBody.collisionCategories = ["Enemy"]
        self.physicsBody.collisionMask = ["PlayerShot"]
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // Cada nave tem 40% de atirar a cada tick ateh um limite de 5x
    override func update(delta: CCTime) {
        self.shootDelayCount++
        if (self.shootDelayCount >= 35 && self.numShots > 0 && (arc4random_uniform(101) > 60)) {
            self.shootDelayCount = 0
            self.numShots--
            self.gameSceneRef!.enemyShotAtPosition(self.position)
        }
    }
    
    // MARK: - Private Methods
    func gerarAnimacaoSpriteWithName(aSpriteName:String, aQtdFrames:Int) -> CCSprite {
        // Carrega os frames da animacao dentro do arquivo passado dada a quantidade de frames
        var animFrames:Array<CCSpriteFrame> = Array()
        for (var i = 1; i <= aQtdFrames; i++) {
            let name:String = "\(aSpriteName)\(i).png"
            animFrames.append(CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name))
        }
        // Cria a animacao dos frames montados
        let animation:CCAnimation = CCAnimation(spriteFrames: animFrames, delay: 0.1)
        // Cria a acao com a animacao dos frames
        let animationAction:CCActionAnimate = CCActionAnimate(animation: animation)
        // Monta a repeticao eterna da animacao
        let actionForever:CCActionRepeatForever = CCActionRepeatForever(action: animationAction)
        // Monta o sprite com o primeiro quadro
        var spriteRet:CCSprite = CCSprite(imageNamed: "\(aSpriteName)\(1).png")
        // Executa a acao da animacao
        spriteRet.runAction(actionForever)
        
        // Retorna o sprite para controle na classe
        return spriteRet
    }
    
    internal func stopAllSpriteActions() {
        self.stopAllActions()
        self.stopAllActions()
    }
    
    internal func width() -> CGFloat {
        return self.boundingBox().size.width
    }
    
    internal func height() -> CGFloat {
        return self.boundingBox().size.height
    }
    
    // MARK: - Death Cycle
    deinit {
        // Chamado no momento de desalocacao
    }

}