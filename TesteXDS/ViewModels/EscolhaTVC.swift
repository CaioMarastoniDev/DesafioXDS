//
//  EscolhaTVC.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 17/06/21.
//

import UIKit
import SDWebImage
import Cosmos

class EscolhaTVC: UITableViewCell {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 10
        cardImageView.roundedLeftTopBottom()
    }

    func configCell(url image: URL, name: String, price: Double, rating: Double) {
        self.backgroundColor = KAppColor.init().cardsBackGround
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        self.directionalLayoutMargins = .zero
        
        cardImageView.sd_setImage(with: image, completed: nil)
        nameLabel.text = name
        priceLabel.text = "R$" + String(format: "%.2f", price)
        
        starRatingView.rating = rating
        starRatingView.settings.updateOnTouch = false
        starRatingView.settings.fillMode = .full
        starRatingView.settings.starSize = 15
        starRatingView.settings.starMargin = 5
        starRatingView.settings.filledColor = UIColor.orange
        starRatingView.settings.emptyBorderColor = UIColor.orange
        starRatingView.settings.filledBorderColor = UIColor.orange
        starRatingView.backgroundColor = KAppColor.init().backGround

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
