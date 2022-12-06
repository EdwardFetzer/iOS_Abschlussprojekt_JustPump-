//
//  Utillities.swift
//  JustPump
//
//  Created by Edward Fetzer on 20.10.22.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Layer wird erstellt
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&.]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
