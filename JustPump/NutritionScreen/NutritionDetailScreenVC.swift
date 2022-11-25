//
//  NutritionDetailScreenVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 11.11.22.
//

import UIKit

class NutritionDetailScreenVC: UIViewController {
    
    var showSelectedNutrition: Nutrition!
    
    @IBOutlet weak var nutritionDetailSV: UIScrollView!
    @IBOutlet weak var nutritionImageIV: UIImageView!
    @IBOutlet weak var nutritionTitleLbl: UILabel!
    @IBOutlet weak var nutritionDetailTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nutritionImageIV.image = UIImage(named: showSelectedNutrition.nutritionImageRes)
        nutritionTitleLbl.text = showSelectedNutrition.nutritionName
        nutritionTitleLbl.sizeToFit()
        nutritionDetailTextView.text = showSelectedNutrition.nutritionDescription
        nutritionDetailTextView.sizeToFit()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
