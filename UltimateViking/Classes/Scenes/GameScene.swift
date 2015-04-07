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
    var canPlay:Bool = true
    var physicsWorld:CCPhysicsNode = CCPhysicsNode()
    var scoreLabel:CCLabelTTF = CCLabelTTF(string: "Score: 0", fontName: "Verdana-Bold", fontSize: 18.0)
    var scoreNum:Int = 0
    var agnar:Viking = Viking()
    var faixa:Faixa = Faixa(imageNamed: "energiaVerde-ipad.png")
    var powerUp:Bool = false
    var isTouching:Bool = false
	
    // MARK: - Private Objects
    private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    private var canTap:Bool = true
    private var score:Int = 0
    private var velPirataPerneta:CGFloat = 5.0
    private var velPirataPeixe:CGFloat = 9.0
    

	
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
        
        faixa.position = CGPointMake(0.0, 0.0)
        faixa.anchorPoint = CGPointMake(0.0, 0.0)
        self.physicsWorld.addChild(faixa, z:1)
        
        // Configura o heroi na tela
        agnar.position = CGPointMake(70, self.screenSize.height/2)
        agnar.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(agnar, z:2)
        
        scoreLabel.position = CGPointMake(self.screenSize.width/2, self.screenSize.height - 10)
        scoreLabel.anchorPoint = CGPointMake(0.5, 1.0)
        scoreLabel.color = CCColor.blackColor()
        self.addChild(scoreLabel, z:5)
        
        // Back button
        let backButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("back.png") as CCSpriteFrame)
        backButton.position = CGPointMake(screenSize.width, screenSize.height)
        backButton.anchorPoint = CGPointMake(1.0, 1.0)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
        
    }
    /*
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
    } */
    
    // MARK: - Public Methods verificar se esse método é necessario
    func enemyShotAtPosition(anPosition:CGPoint) {
        let shot:Machado = Machado(imageNamed: "tiro-ipad.png", andDamage:CGFloat((arc4random_uniform(5) + 3)))
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
        DelayHelper.sharedInstance.callFunc("generatePirata", onTarget: self, withDelay: 3.0)
	}

	// Tick baseado no FPS
	override func update(delta: CCTime) {
		//...
	}

	// MARK: - Private Methods

	// MARK: - Public Methods
    func generatePirata() {
        if (self.canPlay) {
            // Quantidade de piratas gerado por vez...
            let auxPosition:CGFloat = CGFloat(arc4random_uniform(10)+1)
            var positionY:CGFloat = screenSize.height - 150
            let positionX:CGFloat = self.screenSize.width
            switch auxPosition {
            case 1:
                positionY = positionY * auxPosition / 10 + 50
                break;
            case 10:
                positionY = positionY * auxPosition / 10 - 100
                break;
            default:
                positionY = positionY * auxPosition / 10
                break;
            }
            let auxRan:CGFloat = CGFloat(arc4random_uniform(10)+1)
            if (auxRan > 7) {
                var pirataPeixe:PirataPeixe = PirataPeixe(event: "updateScore", target: self)
                pirataPeixe.position = CGPointMake(positionX, positionY)
                pirataPeixe.name = "z"
                self.physicsWorld.addChild(pirataPeixe, z:1)
                pirataPeixe.moveMe(self.velPirataPeixe)
                println("posicao: " + auxPosition.description + " random: Peixe " + auxRan.description)
            } else {
                var pirataPerneta:PirataPerneta = PirataPerneta(event: "updateScore", target: self)
                pirataPerneta.position = CGPointMake(positionX, positionY)
                pirataPerneta.name = "z"
                self.physicsWorld.addChild(pirataPerneta, z:1)
                pirataPerneta.moveMe(self.velPirataPerneta)
                println("posicao: " + auxPosition.description + " random: Perneta " + auxRan.description)
            }
            
            // Apos geracao, registra nova geracao apos um tempo
            DelayHelper.sharedInstance.callFunc("generatePirata", onTarget: self, withDelay: 1.0)
        }
    }
    
    func doGameOver() {
        self.canPlay = false
        self.isTouching = false
        //self.createParticleAtPosition(self.heroShip.position)
        //self.heroShip.removeFromParentAndCleanup(true)
        
        // Registra o novo best score caso haja
        /*
        var scores: [Int] = NSUserDefaults.standardUserDefaults().objectForKey("scores") as [Int]
        scores.insert(self.score, atIndex: scores.count)
        scores.sort({ $0 > $1 })
        scores.removeLast()
        NSUserDefaults.standardUserDefaults().setObject(scores  , forKey: "scores")
        NSUserDefaults.standardUserDefaults().synchronize()
        println(scores)
        */
        
        // Exibe o texto game over
        let label:CCSprite = CCSprite(imageNamed: "textGameOver.png")
        label.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        label.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(label, z:5)
    }
    
    func createParticleAtPosition(aPosition:CGPoint) {
        // Config File
        var particleFile:CCParticleSystem = CCParticleSystem(file: "ShipBlow.plist")
        particleFile.position = aPosition
        particleFile.autoRemoveOnFinish = true
        self.addChild(particleFile, z:4)
    }
    
    // MARK: - CCPhysicsCollisionDelegate
    // ======= Validacao para colisoes entre a Machado e os piratas pernetas
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, PirataPerneta aPirataPerneta:PirataPerneta!, Machado aMachado:Machado!) -> Bool {
        aPirataPerneta.life -= 1
        if (aPirataPerneta.life <= 0) {
            aPirataPerneta.life = 0
            score += 3
            self.doGameOver()
        }
        
        // Explode e remove a nave
        SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXPuf)
        self.createParticleAtPosition(aPirataPerneta.position)
        aPirataPerneta.removeFromParentAndCleanup(true)
        return true
    }
    // ======= Validacao para colisoes entre a Machado e os piratas peixes
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, PirataPeixe aPirataPeixe:PirataPeixe, Machado aMachado:Machado!) -> Bool {
        aPirataPeixe.life -= 1
        if (aPirataPeixe.life <= 0) {
            aPirataPeixe.life = 0
            score += 7
            self.doGameOver()
        }
        
        // Explode e remove a nave
        SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXPuf)
        self.createParticleAtPosition(aPirataPeixe.position)
        aPirataPeixe.removeFromParentAndCleanup(true)
        
        return true
    }
    // ======= Validacao para colisoes entre a Faixa e os Piratas Perneta
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, Faixa aFaixa:Faixa!, PirataPerneta aPirataPerneta:PirataPerneta!) -> Bool {
        aFaixa.life -= 1
        if (aFaixa.life <= 0) {
            aFaixa.life = 0
            self.doGameOver()
        }
        // Remove o Pirata
        self.createParticleAtPosition(aPirataPerneta.position)
        aPirataPerneta.removeFromParentAndCleanup(true)
        // Verifica a vida da faixa
        aFaixa.verificaLife()
        return true
    }
    // ======= Validacao para colisoes entre a Faixa e os Piratas Peixe
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, Faixa aFaixa:Faixa!, PirataPeixe aPirataPeixe:PirataPeixe!) -> Bool {
        aFaixa.life -= 1
        if (aFaixa.life <= 0) {
            aFaixa.life = 0
            self.doGameOver()
        }
        // Remove o Pirata
        self.createParticleAtPosition(aPirataPeixe.position)
        aPirataPeixe.removeFromParentAndCleanup(true)
        // Verifica a vida da faixa
        aFaixa.verificaLife()
        return true
    }

	
	// MARK: - Delegates/Datasources
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        if (self.canPlay) {
            self.isTouching = true
            let locationInView:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touch)
            var dano:CGFloat = 1.0
            if (self.powerUp) { dano = 3.0 }
            let machado:Machado = Machado(imageNamed:"tiro-ipad.png", andDamage: dano)
            machado.anchorPoint = CGPointMake(0.5, 0.5)
            machado.position = CGPointMake(self.agnar.position.x + 50, self.agnar.position.y + 10)
            machado.runAction(CCActionSequence.actionOne(
                CCActionMoveBy.actionWithDuration(0.8, position: locationInView) as CCActionFiniteTime, two: CCActionCallBlock.actionWithBlock({ () -> Void in
                    machado.removeFromParentAndCleanup(true)
                }) as CCActionFiniteTime) as CCAction)
            self.physicsWorld.addChild(machado, z:1)
        }
    }
    
	
	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
        CCTextureCache.sharedTextureCache().removeAllTextures()
	}
}
