//
//  GameViewController.swift
//  Flappy Bird
//
//  Created by Mel Ludowise on 10/24/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var bird: UIImageView!
    
    var animator : UIDynamicAnimator!
    var gravity = UIGravityBehavior()
    var birdItemBehavior : UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        animator.addBehavior(gravity)
        gravity.addItem(bird)
        
        
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        
    }
    
}
