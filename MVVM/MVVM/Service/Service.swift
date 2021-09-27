//
//  Service.swift
//  MVVM
//
//  Created by Jay's Mac Mini on 27/09/21.
//

import UIKit

class Service: NSObject {

    static let shareInstance = Service()

    func getAllMovieMusic(completion: @escaping([MovieModel]?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?media=music&term=bollywood"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                do{
                    var arrMovieData = [MovieModel]()
                    let results = try JSONDecoder().decode(ResultsModel.self, from: data)
                    for movie in results.results{
                        arrMovieData.append(MovieModel(artistName: movie.artistName!, trackName: movie.trackName!,trackPrice: movie.trackPrice!, artworkUrl100: movie.artworkUrl100!,primaryGenreName: movie.primaryGenreName!))
                    }
                    completion(arrMovieData, nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                }
            }
        }.resume()
    }
}
