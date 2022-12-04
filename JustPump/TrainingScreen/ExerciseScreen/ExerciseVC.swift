//
//  ExerciseVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 04.11.22.
//

import UIKit

class ExerciseVC: UIViewController {
    
    var showSelectedTraining: Training!
    
    var selectedExercise: Exercise!
    
    @IBOutlet weak var exerciseCollectionView: UICollectionView!
    
    var exerciseList: [Exercise]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseList = showSelectedTraining.trainingExercises
        exerciseCollectionView.backgroundColor = UIColor.clear

        // Do any additional setup after loading the view.
    }
}

extension ExerciseVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exerciseCell", for: indexPath) as! ExerciseCVCell
        cell.exerciseTitleLbl.text = self.exerciseList[indexPath.row].exerciseName
        cell.exerciseTitleLbl.sizeToFit()
        cell.exerciseImmageIv.image = UIImage(named: exerciseList[indexPath.row].exerciseImageRes)
        
        cell.layer.cornerRadius = 20
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showExerciseDetail" {
            let viewController = segue.destination as! ExerciseDetailVC
            viewController.showSelectedExercise = selectedExercise
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedExercise = exerciseList[indexPath.row]
        performSegue(withIdentifier: "showExerciseDetail", sender: nil)
    }
    
}
