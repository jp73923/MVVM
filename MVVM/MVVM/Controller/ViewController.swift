//
//  ViewController.swift
//  MVVM
//
//  Created by Jay's Mac Mini on 27/09/21.
//

import UIKit
class cellMovieSongs:UITableViewCell {
    @IBOutlet var imgSong: UIImageView!
    @IBOutlet var lblSongName: UILabel!
    @IBOutlet var lblArtistName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblGenre: UILabel!
}
class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var arrMovieVM = [MovieViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Service.shareInstance.getAllMovieMusic { (moviesSongs, err) in
            if err != nil {
                print(err.debugDescription)
            } else {
                self.arrMovieVM = moviesSongs?.map({ return MovieViewModel(movie: $0) }) ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
//MARK:- UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMovieVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMovieSongs", for: indexPath) as! cellMovieSongs
        let MVM = arrMovieVM[indexPath.row]
        cell.lblArtistName.text = MVM.artistName ?? ""
        cell.lblSongName.text = MVM.trackName ?? ""
        cell.lblGenre.text = MVM.primaryGenreName ?? ""
        cell.lblPrice.text =  String.init(format: "%0.2f $", MVM.trackPrice ?? 0.0)
        if let urlSong = URL.init(string: MVM.artworkUrl100 ?? "") {
            getData(from: urlSong) { data, response, error in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                DispatchQueue.main.async() { [weak self] in
                    cell.imgSong.image =  UIImage(data: data)
                    cell.imgSong.layer.cornerRadius = 5.0
                    cell.imgSong.clipsToBounds = true
                }
            }
        }
        return cell
    }
    
}
