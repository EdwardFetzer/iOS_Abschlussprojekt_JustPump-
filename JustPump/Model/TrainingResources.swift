//
//  TrainingResources.swift
//  JustPump
//
//  Created by Edward Fetzer on 07.11.22.
//

import Foundation

func getAllTraining() -> [Training] {
    return [
        // Brusttraining
        Training(
            trainingName: "Brusttraining",
            trainingImageRes: "brust",
            trainingExercises: getChestExercises()),
        // Schultertraining
        Training(
            trainingName: "Schultertraining",
            trainingImageRes: "schulter",
            trainingExercises: getShoulderExercises()),
        // Rückentraining
        Training(
            trainingName: "Rückentraining",
            trainingImageRes: "ruecken",
            trainingExercises: getBackExercises()),
        
        // Armtraining
        Training(
            trainingName: "Armtraining",
            trainingImageRes: "arme",
            trainingExercises: getArmExercises()),
        
        // Bauchtraining
        Training(
            trainingName: "Bauchtraining",
            trainingImageRes: "bauch",
            trainingExercises: getAbdominalExercises()),
        
        // Beintraining
        Training(
            trainingName: "Beintraining",
            trainingImageRes: "beinpresse",
            trainingExercises: getLegExercises()),
        
    ]
}
