//
//  TrainingVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 03.11.22.
//

import UIKit

class TrainingVC: UIViewController {
    
    
    
    @IBOutlet weak var trainingCollectionView: UICollectionView!
    
    var trainingList = ["Bauch","Rücken","Beine"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension TrainingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingCell", for: indexPath) as! TrainingCVCell
        cell.trainingTitleLbl.text = self.trainingList[indexPath.row]
        print("1.Punkt")
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExercises" {
            var viewController = segue.description as! ExerciseVC
            viewController.showExercises = selected
        }
    }
    
}
