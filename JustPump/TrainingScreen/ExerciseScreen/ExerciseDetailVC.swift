//
//  ExerciseDetailVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 10.11.22.
//

import UIKit

class ExerciseDetailVC: UIViewController {
    
    var showSelectedExercise: Exercise!
    
    @IBOutlet weak var exerciseImageIV: UIImageView!
    @IBOutlet weak var exerciseTitleLbl: UILabel!
    @IBOutlet weak var exerciseDescriptionTV: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseImageIV.image = UIImage(named: showSelectedExercise.exerciseImageRes)
        exerciseTitleLbl.text = showSelectedExercise.exerciseName
        exerciseTitleLbl.sizeToFit()
        exerciseDescriptionTV.text = showSelectedExercise.exerciseDescription
        exerciseDescriptionTV.sizeToFit()
        
       // exerciseDeteilSV.contentSize

        // Do any additional setup after loading the view.
    }
    
    
    
}

