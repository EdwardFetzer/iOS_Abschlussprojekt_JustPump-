//
//  HomeVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 21.10.22.
//

import UIKit
import FirebaseFirestore

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var gainsTV: UITableView!
    @IBOutlet weak var nutritionCollectionView: UICollectionView!
    @IBOutlet weak var trainingCollectionView: UICollectionView!
    
    var gainList = [GainTraining]()
    private var selectedGains: GainTraining!
    var trainingList = getAllTraining()
    var nutritionList = getAllNutritions()
    
    var selectedTraining: Training!
    var selectedNutrition: Nutrition!
    var selectedExercise: Exercise!

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gainsTV.delegate = self
        gainsTV.dataSource = self
        fetchGainTraining()
    }

    func fetchGainTraining() {
        
        do {
            gainList = try appDelegate.persistentContainer.viewContext.fetch(GainTraining.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        gainsTV.reloadData()
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 26))
//
//        let trainingTitleLbl = UILabel()
//        trainingTitleLbl.frame = CGRect.init(x: 5, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height-10)
//        trainingTitleLbl.text = "Training"
//        trainingTitleLbl.font = .systemFont(ofSize: 16)
//        trainingTitleLbl.textColor = .black
//
//        let dateTitleLbl = UILabel()
//        dateTitleLbl.frame = CGRect.init(x: headerView.frame.width / 2, y: 0, width: (headerView.frame.width / 2) - 5, height: headerView.frame.height-10)
//        dateTitleLbl.text = "Datum"
//        dateTitleLbl.textAlignment = .right
//        dateTitleLbl.font = .systemFont(ofSize: 16)
//        dateTitleLbl.textColor = .black
//
//        headerView.addSubview(trainingTitleLbl)
//        headerView.addSubview(dateTitleLbl)
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 26
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellSpace: CGFloat = 6
        let myLayer = CALayer()
        myLayer.cornerRadius = 8
        myLayer.backgroundColor = UIColor.blue.cgColor
        myLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: cellSpace)
        cell.layer.mask = myLayer
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let deleteTraining = self.gainList[indexPath.row]
            context.delete(deleteTraining)
            self.gainList.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            appDelegate.saveContext()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(gainList.count)
        return gainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gainCell", for: indexPath) as! GainCell
        cell.trainingLbl.text = gainList[indexPath.row].name
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyy-MM-dd"
        let dateString = dateFormater.string(from: gainList[indexPath.row].date ?? Date())
        
        cell.dateLbl.text = dateString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGains = gainList[indexPath.row]
        performSegue(withIdentifier: "homeToGains", sender: self)
    }
    
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
            trainingCell.contentView.layer.borderColor = UIColor.black.cgColor
            trainingCell.contentView.layer.cornerRadius = 20
            trainingCell.contentView.layer.masksToBounds = true
            return trainingCell
            
        } else {
            let nutritionCell = nutritionCollectionView.dequeueReusableCell(withReuseIdentifier: "nutritionCell", for: indexPath) as! NutritionCVCell
            nutritionCell.nutritionTitleLbl.text = self.nutritionList[indexPath.row].nutritionName
            nutritionCell.nutritionTitleLbl.sizeToFit()
            nutritionCell.nutritionImageIv.image = UIImage(named: nutritionList[indexPath.row].nutritionImageRes)
            
            nutritionCell.layer.cornerRadius = 18
            nutritionCell.contentView.layer.borderWidth = 2.0
            nutritionCell.contentView.layer.borderColor = UIColor.black.cgColor
            nutritionCell.contentView.layer.cornerRadius = 20
            nutritionCell.contentView.layer.masksToBounds = true
            return nutritionCell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "homeToGains" {
            var viewController = segue.destination as! GainDetailVC
            viewController.shownGains = selectedGains
        }
        
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
