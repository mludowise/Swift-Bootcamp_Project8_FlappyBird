//
//  GameViewController.swift
//  Flappy Bird
//
//  Created by Mel Ludowise on 10/24/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

private let kTouchVelocity = CGPoint(x: 0.0, y: -425.0)

class GameViewController: UIViewController {
    
    @IBOutlet weak var bird: UIImageView!
    
    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var birdItemBehavior : UIDynamicItemBehavior!
    var collisionBehavior : UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [bird])
        gravity.magnitude = 1.0
        animator.addBehavior(gravity)
        
        birdItemBehavior = UIDynamicItemBehavior(items: [bird])
        birdItemBehavior.allowsRotation = false
        animator.addBehavior(birdItemBehavior)

//        collisionBehavior = UICollisionBehavior(items: [bird])
//        collisionBehavior.delete(self)
//        animator.addBehavior(collisionBehavior)
        
        
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        var velocity = birdItemBehavior.linearVelocityForItem(bird)
        velocity.x = 0
        velocity.y = kTouchVelocity.y - velocity.y
        birdItemBehavior.addLinearVelocity(velocity, forItem: bird)
    }
    
}
