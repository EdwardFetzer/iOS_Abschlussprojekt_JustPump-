//
//  NutritionVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 03.11.22.
//

import UIKit

class NutritionVC: UIViewController {
    
    @IBOutlet weak var nutritionCollectionView: UICollectionView!
    
    var nutritionList = ["Basics","Muskelaufbau","Abnehmen"]
    

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
        cell.nutritionTitleLbl.text = self.nutritionList[indexPath.row]
        return cell
    }
    
    
}
