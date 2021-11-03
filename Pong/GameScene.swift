//
//  GameScene.swift
//  Pong
//
//  Created by Joseph Quinn on 10/29/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemyPaddle = SKSpriteNode()
    var mainPaddle = SKSpriteNode()
    
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemyPaddle = self.childNode(withName: "enemyPaddle") as! SKSpriteNode
        enemyPaddle.position.y = (self.frame.height / 2) - 50
        
        mainPaddle = self.childNode(withName: "mainPaddle") as! SKSpriteNode
        mainPaddle.position.y = (-self.frame.height / 2) + 50
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
               
    }
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == mainPaddle {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        else if playerWhoWon == enemyPaddle {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemyPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    mainPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                mainPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemyPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    mainPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                mainPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentGameType {
        case .easy:
            enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 1.1))
            break
        case .medium:
            enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 0.9))
            break
        case .hard:
            enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .player2:
            break
        }
        
        if ball.position.y <= mainPaddle.position.y - 30 {
            addScore(playerWhoWon: enemyPaddle)
        }
        else if ball.position.y >= enemyPaddle.position.y + 30 {
            addScore(playerWhoWon: mainPaddle)
        }
    }
}
