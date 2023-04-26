//
//  playerViewController.swift
//  musicPlayer
//
//  Created by Mohan K on 05/01/23.
//

import UIKit
import MarqueeLabel

struct Model {
    
    var text: String
    var image: String
    var new: String
    var brand: String
    var time: String
    var Rating: String
    init(text: String, image: String, new: String, brand: String, time: String, Rating: String) {
        self.text = text
        self.image = image
        self.new = new
        self.brand = brand
        self.time = time
        self.Rating = Rating
    }
}

class playerViewController: UIViewController  {
   
    @IBOutlet weak var newsView: UITableView!
    
    @IBOutlet weak var contentView: UICollectionView!
    
    @IBOutlet weak var trackinfo: UICollectionView!
    
    @IBOutlet weak var back1: UIButton!
    
    
    var models = [Model]()
    var rest = [restAPI]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        small()
        
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
        models.append(Model(text: "left fiction", image: "img11", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "5.9"))
        models.append(Model(text: "down fiction", image: "img12", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "6.9"))
        models.append(Model(text: "random fiction", image: "img13", new: "rocky bhai kill the garudan for the K . G . M  who had been took the power of the navi world and occupy the navi cities", brand: "Ping Pong", time: "1 day ago / 5 minutes", Rating: "7.9"))
        
        contentView.register(cell1CollectionViewCell.nib() , forCellWithReuseIdentifier: cell1CollectionViewCell.identifier)
        trackinfo.register(cell2CollectionViewCell.nib(), forCellWithReuseIdentifier: cell2CollectionViewCell.identifier)
//        newsView.register(UINib(nibName: "newsInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "newsInfoTableViewCell")
        
        downloadJSON{
            self.newsView.reloadData()
            self.contentView.reloadData()
            self.trackinfo.reloadData()
        }
    }
    
    func small() {
        
        contentView.delegate = self
        contentView.dataSource = self
        
        trackinfo.delegate = self
        trackinfo.dataSource = self
        
        newsView.delegate = self
        newsView.dataSource = self
    }

    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { data, response, err in
            if err == nil {
                do {
                    self.rest = try JSONDecoder().decode([restAPI].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    
                    }
                }
                catch {
                    print("error fetching data from api")
                }
               
            }
        }.resume()
    }


}

extension playerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rest.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == contentView {
            let cells = contentView.dequeueReusableCell(withReuseIdentifier: "cell1CollectionViewCell", for: indexPath) as! cell1CollectionViewCell
            cells.song.text = rest[indexPath.row].localized_name

            return cells
        }
        else if collectionView == trackinfo {
            let cell = trackinfo.dequeueReusableCell(withReuseIdentifier: "cell2CollectionViewCell", for: indexPath) as! cell2CollectionViewCell
            
            let defaultLink = "https://api.opendota.com"
            let completeLink = defaultLink + rest[indexPath.row].img
            cell.imageInfo.downloadedFrom(link: completeLink)
//            cell.imageInfo.image = UIImage(named: models[indexPath.row].image)
            
            cell.trackname.text = rest[indexPath.row].localized_name
            cell.timing.text = rest[indexPath.row].primary_attr
            cell.playButton.addTarget(self, action: #selector(didmove(sender:)), for: .touchUpInside)
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    @objc func didmove(sender: UIButton){
        
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "songViewController") as? songViewController else {return}
        
        //        vc.songs = models[indexPath.row].text
        
        present(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == contentView {
            
            return CGSize(width: 90, height: 90)
            
        }
        else if collectionView == trackinfo {
            
            return CGSize(width: 250, height: 410)
        }
        return CGSize()

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == contentView {
            
        }  else if collectionView == trackinfo {
            let position = indexPath.row
            
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "songViewController") as? songViewController else {return}
            
            //        vc.songs = models[indexPath.row].text
            
            present(vc, animated: true)
            
        }
    }
        
}

extension playerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rest.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsView.dequeueReusableCell(withIdentifier: "newsInfoTableViewCell", for: indexPath) as! newsInfoTableViewCell
        
        cell.news.text = rest[indexPath.row].localized_name
        cell.televisionChannel.text = rest[indexPath.row].primary_attr
            let defaultLink = "https://api.opendota.com"
            let completeLink = defaultLink + rest[indexPath.row].img
        cell.newsimage.downloadedFrom(link: completeLink)

//        cell.newsimage.image = UIImage(named: models[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "songViewController") as? songViewController else {return}
//        
//       let popUP = popUP()
//        popUP.appear(sender: self)
//        vc.songs = models[indexPath.row].text
        
        present(vc, animated: true)
    }
}

//
//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct InfoVCPreview: PreviewProvider {
//
////    static var devices = ["iPhone 11"]
//
//    static var previews: some View {
//        // view controller using programmatic UI
//
//        playerViewController().toPreview().previewDevice(PreviewDevice(rawValue: "iPhone 14"))
//            .previewDisplayName("iPhone 14")
////
////        ViewController().toPreview().previewDevice(PreviewDevice(rawValue: "iPhone SE"))
////            .previewDisplayName("iPhone SE")
//
////        ForEach(devices, id: \.self) { deviceName in
////            .previewDevice(PreviewDevice(rawValue: deviceName))
////            .previewDisplayName(deviceName)
////        }
//    }
//}
//#endif
