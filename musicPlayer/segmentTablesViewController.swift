//
//  segmentTablesViewController.swift
//  musicPlayer
//
//  Created by Mohan K on 23/01/23.
//

import UIKit

class segmentTablesViewController: UIViewController {

    @IBOutlet weak var radioPoadcast: UISegmentedControl!
    
    @IBOutlet weak var segmentTable: UITableView!
    
    var rest = [restAPI]()
    
    var models = [Model]()
    
//    var rests = restAPI?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        models.append(Model(text: "fiction", image: "img1", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities" , brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "4.9"))
        models.append(Model(text: "non fiction", image: "img2", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "5.9"))
        models.append(Model(text: "pulpi fiction", image: "img3", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "6.9"))
        models.append(Model(text: "tactic fiction", image: "img4", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "7.9"))
        models.append(Model(text: "static fiction", image: "img5", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "8.9"))
        models.append(Model(text: "dramatic fiction", image: "img6", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "4.9"))
        models.append(Model(text: "in fiction", image: "img7", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "5.9"))
        models.append(Model(text: "out fiction", image: "img8", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "6.9"))
        models.append(Model(text: "up fiction", image: "img9", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "7.9"))
        models.append(Model(text: "right fiction", image: "img10", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "8.9"))
        models.append(Model(text: "left fiction", image: "img11", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "4.9"))
        models.append(Model(text: "down fiction", image: "img12", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "5.9"))
        models.append(Model(text: "random fiction", image: "img13", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "6.9"))
        
        segmentTable.delegate = self
        segmentTable.dataSource = self
        
        downloadJSON {
            self.segmentTable.reloadData()
        }
    }
    
    
    @IBAction func segmentTapped(_ sender: Any) {
        
        segmentTable.reloadData()
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.rest = try JSONDecoder().decode([restAPI].self, from: data!)
                    DispatchQueue.main.async {
                        self.segmentTable.reloadData()

                        completed()
                    }
                }catch{
                    print("JSON Error")
                }
            }
        }.resume()
    }

}


extension segmentTablesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch radioPoadcast.selectedSegmentIndex{
        case 0:
            return rest.count
        case 1:
            return rest.count
        default:
            break
        }
   
        return rest.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = segmentTable.dequeueReusableCell(withIdentifier: "segmentTableViewCell", for: indexPath) as! segmentTableViewCell
        switch radioPoadcast.selectedSegmentIndex{
        case 0:
            let urlString = "https://api.opendota.com"
            let completeLink = urlString + rest[indexPath.row].img
            cell.songImage.downloadedFrom(link: completeLink)
            cell.songImage.clipsToBounds = true
            cell.songImage.layer.cornerRadius = cell.songImage.frame.width / 2
            cell.songImage.contentMode = .scaleAspectFill
//            cell.songImage.image = UIImage(named: models[indexPath.row].image)
            cell.label3.text = rest[indexPath.row].localized_name
            cell.tradeMark.text = rest[indexPath.row].primary_attr
        case 1:
            let urlString = "https://api.opendota.com"
            let completeLink = urlString + rest[indexPath.row].img
            cell.songImage.downloadedFrom(link: completeLink)
            cell.songImage.clipsToBounds = true
            cell.songImage.layer.cornerRadius = cell.songImage.frame.width / 2
            cell.songImage.contentMode = .scaleAspectFill
            cell.label3.text = rest[indexPath.row].primary_attr
            cell.tradeMark.text = rest[indexPath.row].localized_name
        default:
            break
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "playerViewController") as? playerViewController else {return}
        
//        vc.songs = models[indexPath.row].text
        
        present(vc, animated: true)
    }
    
}


