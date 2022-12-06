//
//  GainsDeteilVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 31.10.22.
//

import UIKit

//MARK: View Controller
class GainDetailVC: UIViewController {
    
    var gainExerciseList = [GainExercise]()
    var shownGains: GainTraining!
    
    @IBOutlet weak var gainExerciseTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gainExerciseTV.delegate = self
        gainExerciseTV.dataSource = self
        fetchGainExercise()
    }
    
    // Neue Übung wird hinzugefügt
    @IBAction func addGainExerciseBtn(_ sender: UIBarButtonItem) {
        
        // Alert wird erstellt
        let alert = UIAlertController(title: "Übung hinzufügen", message: "Welche übung hast du ausgeführt?", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Hinzufügen", style: .default, handler: { (action) in
            let newExercise = GainExercise(context: context)
            newExercise.gainExerciseName = alert.textFields![0].text!
            newExercise.reps = Int16(alert.textFields![1].text!) ?? 0
            newExercise.weight = Float(alert.textFields![2].text!) ?? 0
            newExercise.gainTraining = self.shownGains
            
            do {
                try context.save()
            } catch {
                print("Failed save Exercise to CoreData")
            }
            self.fetchGainExercise()
        })
        
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.addTextField(configurationHandler: { (exerciseNameTF) in
            exerciseNameTF.placeholder = "Übung"
        })
        alert.addTextField(configurationHandler: { (repsTF) in
            repsTF.placeholder = "Wiederholungen"
        })
        alert.addTextField(configurationHandler: { (weightTF) in
            weightTF.placeholder = "Gewicht"
        })
        present(alert, animated: true)
    }
    
    // Übung wird in CoreData gespeichert
    func fetchGainExercise() {
        gainExerciseList = shownGains.gainExercises?.allObjects as! [GainExercise]
        gainExerciseList = gainExerciseList.sorted(by: {
            $0.gainExerciseName!.compare($1.gainExerciseName!) == .orderedAscending
        })
        gainExerciseTV.reloadData()
    }
}

//MARK: Table View Data Source / View Deligate
extension GainDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    // Überschrift für die Table View wird erstellt
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 26))
        
        let exerciseTitleLbl = UILabel()
        // Position des Labels wird bestimmt
        exerciseTitleLbl.frame = CGRect.init(x: 10, y: 0, width: (headerView.frame.width / 2) - 5, height: headerView.frame.height-10)
        exerciseTitleLbl.text = "Übung"
        exerciseTitleLbl.font = .systemFont(ofSize: 16)
        exerciseTitleLbl.textColor = .white
        
        let repsLbl = UILabel()
        // Position des Labels wird bestimmt
        repsLbl.frame = CGRect.init(x: headerView.frame.width / 3, y: 0, width: (headerView.frame.width / 2) - 10, height: headerView.frame.height-10)
        repsLbl.text = "Wdh"
        repsLbl.textAlignment = .right
        repsLbl.font = .systemFont(ofSize: 16)
        repsLbl.textColor = .white
        
        let weightLbl = UILabel()
        // Position des Labels wird bestimmt
        weightLbl.frame = CGRect.init(x: headerView.frame.width / 2, y: 0, width: (headerView.frame.width / 2) - 10, height: headerView.frame.height-10)
        weightLbl.text = "Kg"
        weightLbl.textAlignment = .right
        weightLbl.font = .systemFont(ofSize: 16)
        weightLbl.textColor = .white
        
        headerView.addSubview(exerciseTitleLbl)
        headerView.addSubview(repsLbl)
        headerView.addSubview(weightLbl)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //Größe der Überschrift
        return 26
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Größe der Celle
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Abstand zwichen den cellen
        let cellSpace: CGFloat = 6
        let myLayer = CALayer()
        //Layer wird erstellt
        myLayer.cornerRadius = 8
        myLayer.backgroundColor = UIColor.blue.cgColor
        myLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: cellSpace)
        cell.layer.mask = myLayer
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteExercise = self.gainExerciseList[indexPath.row]
            context.delete(deleteExercise)
            self.gainExerciseList.remove(at: indexPath.row)
            // Löschen der celle aus der data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            appDelegate.saveContext()
        } else if editingStyle == .insert {
            // Erstellt eine neue instance und fügt es dem array hinzu, und erstellt eine neue Celle in der table view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gainExerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gainExerciseCell", for: indexPath) as! GainExerciseCell
        
        cell.exerciseLbl.text = gainExerciseList[indexPath.row].gainExerciseName
        cell.exerciseLbl.sizeToFit()
        cell.repsLbl.text = gainExerciseList[indexPath.row].reps.description
        cell.repsLbl.sizeToFit()
        cell.weightLbl.text = gainExerciseList[indexPath.row].weight.description
        cell.weightLbl.sizeToFit()
        
        return cell
    }
}
