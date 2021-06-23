//
//  AlertService.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 21/06/21.
//

import UIKit

class AlertService {
    
    func alert(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
}
