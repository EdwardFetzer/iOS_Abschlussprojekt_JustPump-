//
//  ExerciseVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 04.11.22.
//

import UIKit

class ExerciseVC: UIViewController {
    
    var showExercises: TrainingVC!
    
    @IBOutlet weak var exerciseCollectionView: UICollectionView!
    
    var exerciseList = ["Sit-Ups","Cross Crunches","Hüftheben auf der Bank"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension ExerciseVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exerciseCell", for: indexPath) as! ExerciseCVCell
        cell.exerciseTitleLbl.text = self.exerciseList[indexPath.row]
        return cell
    }
    
    
}
