//
//  tableViewController.swift
//  musicPlayer
//
//  Created by Mohan K on 06/01/23.
//

import UIKit

class tableViewController: UIViewController {

    @IBOutlet weak var feednews: UITableView!
    
    @IBOutlet weak var backtoBack: UIButton!
    
    var models = [Model]()
    
    var rest = [restAPI]()
    
    
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
        
//        print("models: \(models)")

        feednews.delegate = self
        feednews.dataSource = self
        
        downloadJSON {
            self.feednews.reloadData()
        }
//        feednews.register(likeTableViewCell.nib(), forCellReuseIdentifier: likeTableViewCell.identifier)
    }

    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.rest = try JSONDecoder().decode([restAPI].self, from: data!)
                    DispatchQueue.main.async {
                        self.feednews.reloadData()

                        completed()
                    }
                }catch{
                    print("JSON Error")
                }
            }
        }.resume()
    }

    
    
    
    
}

extension tableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rest.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = feednews.dequeueReusableCell(withIdentifier: "likeTableViewCell", for: indexPath) as!
        likeTableViewCell
        let urlString = "https://api.opendota.com"
        let completeLink = urlString + rest[indexPath.row].img

        cell.newsImg.downloadedFrom(link: completeLink)
        cell.newsImg.clipsToBounds = true
        cell.newsImg.layer.cornerRadius = cell.newsImg.frame.width / 2
        cell.newsImg.contentMode = .scaleAspectFill
        cell.theory.text = rest[indexPath.row].localized_name
        
        cell.company.text = rest[indexPath.row].primary_attr
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "songViewController") as? songViewController else {return}
        
//        vc.songs = models[indexPath.row].text
        
        present(vc, animated: true)
    }
    
}
