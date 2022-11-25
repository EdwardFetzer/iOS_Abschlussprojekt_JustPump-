//
//  NutritionVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 03.11.22.
//

import UIKit

class NutritionVC: UIViewController {
    
    @IBOutlet weak var nutritionCollectionView: UICollectionView!
    
    var nutritionList = getAllNutritions()
    
    var selectedNutrition: Nutrition!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

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
extension NutritionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutritionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nutritionCell", for: indexPath) as! NutritionCVCell
        cell.nutritionTitleLbl.text = self.nutritionList[indexPath.row].nutritionName
        cell.nutritionTitleLbl.sizeToFit()
        cell.nutritionImageIv.image = UIImage(named: nutritionList[indexPath.row].nutritionImageRes)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNutrition" {
            let viewController = segue.destination as! NutritionDetailScreenVC
            viewController.showSelectedNutrition = selectedNutrition
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedNutrition = nutritionList[indexPath.row]
        performSegue(withIdentifier: "showNutrition", sender: nil)
    }
    
}
