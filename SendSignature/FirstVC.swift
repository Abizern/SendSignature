//
//  ViewController.swift
//  SendSignature
//
//  Created by Florentin Lupascu on 29/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    @IBOutlet weak var signature: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func nextBtn(_ sender: UIBarButtonItem) {
        
        let secondVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        
        secondVC.signature = self.signature
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
