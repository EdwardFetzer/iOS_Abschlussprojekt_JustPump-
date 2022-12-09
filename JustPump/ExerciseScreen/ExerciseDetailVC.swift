//
//  ExerciseDetailVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 10.11.22.
//

import UIKit

class ExerciseDetailVC: UIViewController {
    
    var showSelectedExercise: Exercise!
        
    @IBOutlet weak var exerciseView: UIView!
    @IBOutlet weak var exerciseImageIV: UIImageView!
    @IBOutlet weak var exerciseTitleLbl: UILabel!
    @IBOutlet weak var exerciseDescriptionTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Layer wird erstellt
        exerciseView.layer.cornerRadius = 20
        exerciseView.layer.borderWidth = 2.0
        exerciseView.layer.masksToBounds = true
        
        exerciseImageIV.image = UIImage(named: showSelectedExercise.exerciseImageRes)
        
        exerciseTitleLbl.text = showSelectedExercise.exerciseName
        exerciseTitleLbl.sizeToFit()
        
        exerciseDescriptionTV.text = showSelectedExercise.exerciseDescription
        exerciseDescriptionTV.sizeToFit()
    }
}
