//
//  HomeVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 21.10.22.
//

import UIKit
import FirebaseFirestore

class HomeVC: UIViewController {
    
    @IBOutlet weak var nutritionCollectionView: UICollectionView!
    @IBOutlet weak var trainingCollectionView: UICollectionView!
    
    var trainingList = getAllTraining()
    var nutritionList = getAllNutritions()
    
    var selectedTraining: Training!
    var selectedNutrition: Nutrition!
    var selectedExercise: Exercise!

    let db = Firestore.firestore()
    
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

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.trainingCollectionView {
            return trainingList.count
        }
        return trainingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == trainingCollectionView {
            let trainingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingCell", for: indexPath) as! TrainingCVCell
            let training = self.trainingList[indexPath.row]
            trainingCell.trainingTitleLbl.text = training.trainingName
            trainingCell.trainingTitleLbl.sizeToFit()
            trainingCell.trainingImageIv.image = UIImage(named: training.trainingImageRes)
            
            trainingCell.layer.cornerRadius = 20
            trainingCell.contentView.layer.borderWidth = 2.0
            trainingCell.contentView.layer.borderColor = UIColor.red.cgColor
            trainingCell.contentView.layer.cornerRadius = 20.0
            trainingCell.contentView.layer.masksToBounds = true
            
            return trainingCell
        } else {
            let nutritionCell = nutritionCollectionView.dequeueReusableCell(withReuseIdentifier: "nutritionCell", for: indexPath) as! NutritionCVCell
            nutritionCell.nutritionTitleLbl.text = self.nutritionList[indexPath.row].nutritionName
            nutritionCell.nutritionTitleLbl.sizeToFit()
            nutritionCell.nutritionImageIv.image = UIImage(named: nutritionList[indexPath.row].nutritionImageRes)
            
            return nutritionCell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showExercises" {
            let viewController = segue.destination as! ExerciseVC
            
            viewController.showSelectedTraining = selectedTraining
        }
        
        if segue.identifier == "showNutrition" {
            let viewController = segue.destination as! NutritionDetailScreenVC
            viewController.showSelectedNutrition = selectedNutrition
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.trainingCollectionView {
            selectedTraining = trainingList[indexPath.row]
            performSegue(withIdentifier: "showExercises", sender: nil)
        } else {
            selectedNutrition = nutritionList[indexPath.row]
            performSegue(withIdentifier: "showNutrition", sender: nil)
        }
    }
}


