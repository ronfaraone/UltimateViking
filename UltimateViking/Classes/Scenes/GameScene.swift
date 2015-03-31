//
//  GameScene.swift
//  UltimateViking
//
//  Created by Ronaldo Faraone on 3/30/15.
//  Copyright (c) 2015 Fiap. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class GameScene: CCScene {
	
    // MARK: - Public Objects
    var physicsWorld:CCPhysicsNode = CCPhysicsNode()
    var canPlay:Bool = true
    var isTouching:Bool = true
	
    // MARK: - Private Objects
	private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    private var canTap:Bool = true
	
	// MARK: - Life Cycle
	override init() {
		super.init()

        self.userInteractionEnabled = true
        
        self.createSceneObjects()
        
		
	}

    func createSceneObjects(){
        
        // Define o mundo
        //debugdraw para ver area de colisao
        //self.physicsWorld.debugDraw = true
        self.physicsWorld.collisionDelegate = self
        self.physicsWorld.gravity = CGPointZero
        self.addChild(self.physicsWorld, z:ObjectsLayers.Background.rawValue)
        
        // Create a background
        let background:CCSprite = CCSprite(imageNamed: "bgCenario-iphone.png")
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        background.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(background)
        
        
        // Back button
        let backButton:CCButton = CCButton(title: "[ Back ]", fontName: "Verdana-Bold", fontSize: 28.0)
        backButton.position = CGPointMake(screenSize.width, screenSize.height)
        backButton.anchorPoint = CGPointMake(1.0, 1.0)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
        
        // Configura o heroi na tela
        let player:CCSprite = CCSprite(imageNamed: "player-ipad.png")
        player.anchorPoint = CGPointMake(0.5, 0.5)
        player.position = CGPointMake(screenSize.width/96*10, screenSize.height/2)
        self.addChild(player)
    }
    
    func createEnemy() {
        if (!self.canPlay) {
            return
        }
        
        let inimigo:Piratas = Piratas(imageNamed:"Pirata\(arc4random_uniform(100) + 50).png")
        inimigo.gameSceneRef = self // Envia propria referencia para controlar os disparos que ficaram nesta classe
        inimigo.anchorPoint = CGPointMake(0.5, 0.5)
        let minScreenX:CGFloat = inimigo.boundingBox().size.width
        let maxScreenX:UInt32 = UInt32(screenSize.width - (inimigo.boundingBox().size.width + minScreenX))
        var xPosition:CGFloat = minScreenX + CGFloat(arc4random_uniform(maxScreenX))
        inimigo.position = CGPointMake(xPosition, screenSize.height + inimigo.boundingBox().size.height)
        self.physicsWorld.addChild(inimigo, z:ObjectsLayers.Foes.rawValue)
        
        let enemySpeed:CCTime = CCTime(arc4random_uniform(6)) + 5.0 // De 5s a 10s
        inimigo.runAction(CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(enemySpeed, position:CGPointMake(inimigo.position.x, inimigo.boundingBox().size.height * -2)) as CCActionFiniteTime, two: CCActionCallBlock.actionWithBlock({ _ in
            inimigo.removeFromParentAndCleanup(true)
        }) as CCActionFiniteTime) as CCAction)
        var delay:CCTime = (CCTime(arc4random_uniform(101)) / 100.0) + 0.5 // De 0.5s a 1.5s
        DelayHelper.sharedInstance.callFunc("createEnemy", onTarget: self, withDelay: delay)
    }
    
    // MARK: - Public Methods
    func enemyShotAtPosition(anPosition:CGPoint) {
        let shot:PlayerShot = PlayerShot(imageNamed: "tiro-ipad.png", andDamage:CGFloat((arc4random_uniform(5) + 3)))
        shot.anchorPoint = CGPointMake(0.5, 0.5)
        shot.position = anPosition
        
        // Movimenta o disparo ateh a posicao do player
        shot.runAction(CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(2.4, position:CGPointMake(screenSize.width/96*10, screenSize.height/2)) as CCActionFiniteTime, two: CCActionCallBlock.actionWithBlock({ () -> Void in
            shot.removeFromParentAndCleanup(true)
        }) as CCActionFiniteTime) as CCAction)
        self.physicsWorld.addChild(shot, z:ObjectsLayers.Shot.rawValue)
    }
    
	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
        
        // Inicia a geracao de inimigos apos 3s de inicio de jogo
        DelayHelper.sharedInstance.callFunc("createEnemy", onTarget: self, withDelay: 3.0)
	}

	// Tick baseado no FPS
	override func update(delta: CCTime) {
		//...
	}

	// MARK: - Private Methods

	// MARK: - Public Methods
	
	// MARK: - Delegates/Datasources
	
	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
	}
}
