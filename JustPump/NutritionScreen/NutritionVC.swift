//
//  NutritionVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 03.11.22.
//

import UIKit

//MARK: View Controller
class NutritionVC: UIViewController {
    
    @IBOutlet weak var nutritionCollectionView: UICollectionView!
    
    var nutritionList = getAllNutritions()
    var selectedNutrition: Nutrition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Collection View Data Source / View Deligate
extension NutritionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutritionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nutritionCell", for: indexPath) as! NutritionCVCell
        cell.nutritionTitleLbl.text = self.nutritionList[indexPath.row].nutritionName
        cell.nutritionTitleLbl.sizeToFit()
        cell.nutritionImageIv.image = UIImage(named: nutritionList[indexPath.row].nutritionImageRes)
        
        //Lauyer wird erstellt
        cell.layer.cornerRadius = 20
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.cornerRadius = 20.0
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    //MARK: prepare for segue
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
