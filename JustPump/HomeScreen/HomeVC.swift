//
//  HomeVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 21.10.22.
//

import UIKit
import FirebaseFirestore

//MARK: View Controller
class HomeVC: UIViewController {
    
    let db = Firestore.firestore()
    
    private var selectedGains: GainTraining!
    var gainList = [GainTraining]()
    var trainingList = getAllTraining()
    var nutritionList = getAllNutritions()
    
    var selectedTraining: Training!
    var selectedNutrition: Nutrition!
    var selectedExercise: Exercise!
    
    @IBOutlet weak var gainsTV: UITableView!
    @IBOutlet weak var nutritionCollectionView: UICollectionView!
    @IBOutlet weak var trainingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gainsTV.delegate = self
        gainsTV.dataSource = self
        fetchGainTraining()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchGainTraining()
    }
    
    //Neues Training wird hinzugefügt
    func fetchGainTraining() {
        
        do {
            gainList = try sortByDate(list:(appDelegate.persistentContainer.viewContext.fetch(GainTraining.fetchRequest())))
        } catch {
            print(error.localizedDescription)
        }
        gainsTV.reloadData()
    }
}

//MARK: Table View Data Source / View Deligate
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Größe der Celle
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Abstand zwichen den cellen
        let cellSpace: CGFloat = 6
        //Layer wird erstellt
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
            // Löschen der row aus der data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            appDelegate.saveContext()
        } else if editingStyle == .insert {
            // Erstellt eine neue instance und fügt es dem array hinzu, und erstellt eine neue Celle in der table view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gainList.count
    }
    
    //Liste der Gains wird nach datum sortiert
    func sortByDate(list: [GainTraining]) -> [GainTraining] {
        let sortedList = list.sorted(by: {
            $0.date!.compare($1.date!) == .orderedDescending
        })
        return sortedList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gainCell", for: indexPath) as! GainCell
        
        //Liste der Gains wird nach datum sortiert
        let sortedList = sortByDate(list: gainList)
        cell.trainingLbl.text = sortedList[indexPath.row].name
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyy-MM-dd"
        let dateString = dateFormater.string(from: sortedList[indexPath.row].date ?? Date())
        
        cell.dateLbl.text = dateString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedGains = gainList[indexPath.row]
        performSegue(withIdentifier: "homeToGains", sender: self)
    }
    
    //MARK: Collection View Data Source / View Deligate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.trainingCollectionView {
            return trainingList.count
        }
        return nutritionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == trainingCollectionView {
            let trainingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingCell", for: indexPath) as! TrainingCVCell
            let training = self.trainingList[indexPath.row]
            trainingCell.trainingTitleLbl.text = training.trainingName
            trainingCell.trainingTitleLbl.sizeToFit()
            trainingCell.trainingImageIv.image = UIImage(named: training.trainingImageRes)
            
            //Layer wird erstellt
            trainingCell.layer.cornerRadius = 18
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
            
            //Layer wird erstellt
            nutritionCell.layer.cornerRadius = 18
            nutritionCell.contentView.layer.borderWidth = 2.0
            nutritionCell.contentView.layer.borderColor = UIColor.black.cgColor
            nutritionCell.contentView.layer.cornerRadius = 20
            nutritionCell.contentView.layer.masksToBounds = true
            return nutritionCell
        }
    }
    
    //MARK: prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "homeToGains" {
            let viewController = segue.destination as! GainDetailVC
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
