//
//  GameViewController.swift
//  Flappy Bird
//
//  Created by Mel Ludowise on 10/24/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

private let kTouchVelocity = CGPoint(x: 0, y: -250)
private let kPipeDistance : CGFloat = 75
private let kPipeSpacing = 100
private let kPipeVelocity = CGPoint(x: -50, y: 0)
private let kPipeTimeInterval : NSTimeInterval = 2

class GameViewController: UIViewController {
    
    @IBOutlet weak var bird: UIImageView!
    @IBOutlet weak var topPipe: UIImageView!
    @IBOutlet weak var bottomPipe: UIImageView!
    
    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var birdItemBehavior : UIDynamicItemBehavior!
//    var collisionBehavior : UICollisionBehavior!
    var pipeItemBehavior : UIDynamicItemBehavior!
    
    var pipes : [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pipes.append(topPipe)
        pipes.append(bottomPipe)
        bottomPipe.frame.origin.y = topPipe.frame.maxY + kPipeDistance
        
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [bird])
        gravity.magnitude = 1.0
        animator.addBehavior(gravity)
        
        birdItemBehavior = UIDynamicItemBehavior(items: [bird])
        birdItemBehavior.allowsRotation = false
        birdItemBehavior.addLinearVelocity(kTouchVelocity, forItem: bird)
        animator.addBehavior(birdItemBehavior)

        pipeItemBehavior = UIDynamicItemBehavior(items: pipes)
        pipeItemBehavior.addLinearVelocity(kPipeVelocity, forItem: topPipe)
        pipeItemBehavior.addLinearVelocity(kPipeVelocity, forItem: bottomPipe)
        animator.addBehavior(pipeItemBehavior)
        
//        collisionBehavior = UICollisionBehavior(items: [bird])
//        collisionBehavior.delete(self)
//        animator.addBehavior(collisionBehavior)
        
        NSTimer.scheduledTimerWithTimeInterval(kPipeTimeInterval, target: self, selector: "addPipes:", userInfo: nil, repeats: true)
    }
    
    func addPipes(timer: NSTimer) {
        println("adding")
        
        var topPipe = UIImageView(image: self.topPipe.image)
        var bottomPipe = UIImageView(image: self.bottomPipe.image)
        
        view.addSubview(topPipe)
        view.addSubview(bottomPipe)
        
        var screenSize = UIScreen.mainScreen().bounds.size
        // Randomly place bottom of top pipe between pipe.height & kPipeDistance
        var pipeOffset = CGFloat(arc4random()) % (topPipe.frame.height - kPipeDistance) + kPipeDistance
        
        topPipe.frame.origin = CGPoint(x: screenSize.width, y: pipeOffset - topPipe.frame.height)
        bottomPipe.frame.origin = CGPoint(x: screenSize.width, y: pipeOffset + kPipeDistance)
        
        println(topPipe.frame.origin)
        
        pipeItemBehavior.addItem(topPipe)
        pipeItemBehavior.addItem(bottomPipe)
        
        pipeItemBehavior.addLinearVelocity(kPipeVelocity, forItem: topPipe)
        pipeItemBehavior.addLinearVelocity(kPipeVelocity, forItem: bottomPipe)
        }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        var velocity = birdItemBehavior.linearVelocityForItem(bird)
        velocity.x = 0
        velocity.y = kTouchVelocity.y - velocity.y
        birdItemBehavior.addLinearVelocity(velocity, forItem: bird)
    }
    
}
