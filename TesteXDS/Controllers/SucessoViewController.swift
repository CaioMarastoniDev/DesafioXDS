//
//  SucessoViewController.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 22/06/21.
//

import UIKit

class SucessoViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    @IBOutlet weak var voltarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        voltarButton.btnCorner()
    }
    
    @IBAction func voltarBUtton(_ sender: UIButton) {
        self.navigationController?.popToViewController(EscolhaVC(), animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
