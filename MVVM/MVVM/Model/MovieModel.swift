//
//  MovieModel.swift
//  MVVM
//
//  Created by Jay's Mac Mini on 27/09/21.
//

import UIKit

class MovieModel: Decodable {
    var artistName:String?
    var trackName: String?
    var trackPrice: Float?
    var artworkUrl100: String?
    var primaryGenreName: String?

    init(artistName:String, trackName: String, trackPrice: Float, artworkUrl100: String, primaryGenreName: String) {
        self.artistName = artistName
        self.trackName = trackName
        self.trackPrice = trackPrice
        self.artworkUrl100 = artworkUrl100
        self.primaryGenreName = primaryGenreName
    }
}

class ResultsModel : Decodable {
    var results = [MovieModel]()
    
    init(results: [MovieModel]) {
        self.results = results
    }
}
