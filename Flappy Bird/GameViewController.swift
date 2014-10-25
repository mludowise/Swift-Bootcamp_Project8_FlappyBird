//
//  GameViewController.swift
//  Flappy Bird
//
//  Created by Mel Ludowise on 10/24/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

private let kTouchVelocity = CGPoint(x: 0, y: -320)
private let kPipeDistance = 100
private let kPipeSpacing = 100
private let kPipeVelocity = CGPoint(x: -100, y: 0)

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
        
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [bird])
        gravity.magnitude = 1.0
        animator.addBehavior(gravity)
        
        birdItemBehavior = UIDynamicItemBehavior(items: [bird])
        birdItemBehavior.allowsRotation = false
        birdItemBehavior.addLinearVelocity(kTouchVelocity, forItem: bird)
        animator.addBehavior(birdItemBehavior)

//        collisionBehavior = UICollisionBehavior(items: [bird])
//        collisionBehavior.delete(self)
//        animator.addBehavior(collisionBehavior)
        
        pipeItemBehavior = UIDynamicItemBehavior(items: pipes)
        pipeItemBehavior.addLinearVelocity(kPipeVelocity, forItem: topPipe)
        pipeItemBehavior.addLinearVelocity(kPipeVelocity, forItem: bottomPipe)
        animator.addBehavior(pipeItemBehavior)
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        var velocity = birdItemBehavior.linearVelocityForItem(bird)
        velocity.x = 0
        velocity.y = kTouchVelocity.y - velocity.y
        birdItemBehavior.addLinearVelocity(velocity, forItem: bird)
    }
    
}
