//
//  TrainingVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 03.11.22.
//

import UIKit

class TrainingVC: UIViewController {
    
    
    
    @IBOutlet weak var trainingCollectionView: UICollectionView!
    
    var trainingList = getAllTraining()
    
    var selectedTraining: Training!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        trainingCollectionView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
        
    }
    
}

extension TrainingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingCell", for: indexPath) as! TrainingCVCell
        let training = self.trainingList[indexPath.row]
        cell.trainingTitleLbl.text = training.trainingName
        cell.trainingTitleLbl.sizeToFit()
        cell.trainingImageIv.image = UIImage(named: training.trainingImageRes)
        
        cell.layer.cornerRadius = 20
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.red.cgColor
        cell.contentView.layer.cornerRadius = 20.0
        cell.contentView.layer.masksToBounds = true

        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showExercises" {
            let viewController = segue.destination as! ExerciseVC
            print(selectedTraining.trainingName)
            viewController.showSelectedTraining = selectedTraining
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTraining = trainingList[indexPath.row]
        performSegue(withIdentifier: "showExercises", sender: nil)
    }
    
}
