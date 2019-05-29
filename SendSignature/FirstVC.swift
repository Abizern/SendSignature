//
//  ViewController.swift
//  SendSignature
//
//  Created by Florentin Lupascu on 29/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    @IBOutlet private var canvas: Canvas!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(#imageLiteral(resourceName: "signature"))
    }

    @IBAction func nextBtn(_ sender: UIBarButtonItem) {
        guard
            let navigationController = navigationController,
            let secondVC = navigationController.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC
            else { return }
            
        let signatureSaved = canvas.image
        
        secondVC.signature = signatureSaved ?? UIImage()
        
        navigationController.pushViewController(secondVC, animated: true)
    }
    
    @IBAction func clearBtn(_ sender: UIButton) {
        canvas.clear()
    }
}
