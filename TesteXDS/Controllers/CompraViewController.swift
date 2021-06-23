//
//  CompraViewController.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 22/06/21.
//

import UIKit
import SDWebImage
import Cosmos

class CompraViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var nameLabe: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var priceLAbel: UILabel!
    @IBOutlet weak var pButton: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    
    var name = ""
    var image = ""
    var rating = 0.0
    var priceP = 0.0
    var priceM = 0.0
    var priceG = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabe.text = name
        pizzaImageView.sd_setImage(with: URL(string: image), completed: nil)
        ratingView.backgroundColor = KAppColor.init().backGround
        ratingView.rating = rating
        priceLAbel.text = "R$" + String(format: "%.2f", priceP)
        pButton.btnCorner()
        mButton.btnCorner()
        gButton.btnCorner()
        
    }
    
    @IBAction func priceButton(_ sender: UIButton) {
        
        switch sender.titleLabel?.text {
        case "P":
            self.priceLAbel.text = "R$" + String(format: "%.2f", priceP)
        case "M":
            self.priceLAbel.text = "R$" + String(format: "%.2f", priceM)
        case "G":
            self.priceLAbel.text = "R$" + String(format: "%.2f", priceG)
        default:
            self.priceLAbel.text = String(priceG)

        }
    }
    
    @IBAction func comprarButton(_ sender: UIButton) {
        performSegue(withIdentifier: "voltarSegue", sender: self)
    }
    

}
