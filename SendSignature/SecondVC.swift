//
//  SecondVC.swift
//  SendSignature
//
//  Created by Florentin Lupascu on 29/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var receivedSignature: UIView!
    
    var signature = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        receivedSignature = signature
    }
}
