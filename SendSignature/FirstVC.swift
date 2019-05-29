//
//  ViewController.swift
//  SendSignature
//
//  Created by Florentin Lupascu on 29/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    @IBOutlet weak var signature: Canvas!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(#imageLiteral(resourceName: "signature"))
    }

    @IBAction func nextBtn(_ sender: UIBarButtonItem) {
        
        let secondVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        
        let signatureSaved = convertViewToImage(with: signature)
        
        secondVC.signature = signatureSaved ?? UIImage()
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @IBAction func clearBtn(_ sender: UIButton) {
        
        signature.clear()
    }
    
    
    func convertViewToImage(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
