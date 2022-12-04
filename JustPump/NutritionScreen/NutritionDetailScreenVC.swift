//
//  NutritionDetailScreenVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 11.11.22.
//

import UIKit

class NutritionDetailScreenVC: UIViewController {
    
    var showSelectedNutrition: Nutrition!
    
    @IBOutlet weak var nutritionView: UIView!
    @IBOutlet weak var nutritionImageIV: UIImageView!
    @IBOutlet weak var nutritionTitleLbl: UILabel!
    @IBOutlet weak var nutritionDetailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nutritionView.layer.cornerRadius = 20
        nutritionView.layer.borderWidth = 2.0
        nutritionView.layer.masksToBounds = true
        
        nutritionImageIV.image = UIImage(named: showSelectedNutrition.nutritionImageRes)
        
        nutritionTitleLbl.text = showSelectedNutrition.nutritionName
        nutritionTitleLbl.sizeToFit()
        
        nutritionDetailTextView.text = showSelectedNutrition.nutritionDescription
        nutritionDetailTextView.sizeToFit()
    }
}
