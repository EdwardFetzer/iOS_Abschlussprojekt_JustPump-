//
//  CaloriesVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 31.10.22.
//

import UIKit

class CaloriesVC: UIViewController {
    
  //  var macro: Item?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var servingSizeLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var fatTotalLbl: UILabel!
    @IBOutlet weak var fatSaturatedLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var sugarLbl: UILabel!
    @IBOutlet weak var carbohydratesLbl: UILabel!
    @IBOutlet weak var choletorolLbl: UILabel!
    @IBOutlet weak var sodiumLbl: UILabel!
    @IBOutlet weak var potassiumLbl: UILabel!
    
    @IBOutlet weak var search: UITextField!
    let apiClient = APIClient()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        let searchTxt = search.text
        
        apiClient.getMacros(searchItem: searchTxt!) { macro in
            
            DispatchQueue.main.async {
                let newMacro = macro.items?[0]
                self.nameLbl.text = newMacro?.name
                self.nameLbl.sizeToFit()
                self.servingSizeLbl.text = newMacro?.serving_size_g.description
                self.caloriesLbl.text = newMacro?.calories.description
                self.fatTotalLbl.text = newMacro?.fat_total_g.description
                self.fatSaturatedLbl.text = newMacro?.fat_saturated_g.description
                self.proteinLbl.text = newMacro?.protein_g.description
                self.sugarLbl.text = newMacro?.sugar_g?.description
                self.carbohydratesLbl.text = newMacro?.carbohydrates_total_g.description
                self.choletorolLbl.text = newMacro?.cholesterol_mg.description
                self.sodiumLbl.text = newMacro?.sodium_mg.description
                self.potassiumLbl.text = newMacro?.potassium_mg.description
                
                
                //self.testLbl.text = macro.items?[0].calories.description
            }
        }
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
