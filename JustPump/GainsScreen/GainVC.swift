//
//  GainVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 31.10.22.
//

import UIKit
import CoreData

class GainVC: UIViewController {
    
    var trainingList = [GainTraining]()
    private var selectedTraining: GainTraining!
    
    @IBOutlet weak var trainingTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trainingTV.delegate = self
        trainingTV.dataSource = self
        fetchTraining()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTrainingBtn(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Training hinzufügen \n\n\n\n\n", message: "Wie soll das Training heißen?", preferredStyle: .alert)
        
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.frame = CGRect(x: 5, y: 40, width: 270, height: 100)
        
        let addAction = UIAlertAction(title: "Hinzufügen", style: .default, handler: { (action) in
            let newTraining = GainTraining(context: context)
            newTraining.name = alert.textFields![0].text!
            
            newTraining.date = myDatePicker.date
            
            do {
                try context.save()
            } catch {
                print("Failed save Training to CoreData")
            }
            self.fetchTraining()
        })
        
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel)
        
        alert.view.addSubview(myDatePicker)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: { (trainingNameTF) in
            trainingNameTF.placeholder = "Training"
        })
        
        present(alert, animated: true)
    }
    
    func fetchTraining() {
        
        do {
            trainingList = try appDelegate.persistentContainer.viewContext.fetch(GainTraining.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        trainingTV.reloadData()
    }
    
    //MARK: deinit
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("test"), object: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 26))
        
        let trainingTitleLbl = UILabel()
        trainingTitleLbl.frame = CGRect.init(x: 5, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height-10)
        trainingTitleLbl.text = "Training"
        trainingTitleLbl.font = .systemFont(ofSize: 16)
        trainingTitleLbl.textColor = .black
        
        let dateTitleLbl = UILabel()
        dateTitleLbl.frame = CGRect.init(x: headerView.frame.width / 2, y: 0, width: (headerView.frame.width / 2) - 5, height: headerView.frame.height-10)
        dateTitleLbl.text = "Datum"
        dateTitleLbl.textAlignment = .right
        dateTitleLbl.font = .systemFont(ofSize: 16)
        dateTitleLbl.textColor = .black
        
        headerView.addSubview(trainingTitleLbl)
        headerView.addSubview(dateTitleLbl)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 26
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
            let deleteTraining = self.trainingList[indexPath.row]
            context.delete(deleteTraining)
            self.trainingList.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            appDelegate.saveContext()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gainCell", for: indexPath) as! GainCell
        
        //cell.contentView.layer.cornerRadius = 5
        
        cell.trainingLbl.text = trainingList[indexPath.row].name
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyy-MM-dd"
        let dateString = dateFormater.string(from: trainingList[indexPath.row].date ?? Date())
        
        cell.dateLbl.text = dateString
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showGains" {
            var viewController = segue.destination as! GainDetailVC
            
            viewController.shownTraining = selectedTraining
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTraining = trainingList[indexPath.row]
        performSegue(withIdentifier: "showGains", sender: self)
        
    }
    
    
}
