//
//  MovieViewModel.swift
//  MVVM
//
//  Created by Jay's Mac Mini on 27/09/21.
//

import UIKit

class MovieViewModel: NSObject {
    
    var artistName: String?
    var trackName: String?
    var trackPrice: Float?
    var artworkUrl100: String?
    var primaryGenreName: String?

    init(movie:MovieModel){
        self.artistName = movie.artistName
        self.trackName = movie.trackName
        self.trackPrice = movie.trackPrice
        self.artworkUrl100 = movie.artworkUrl100
        self.primaryGenreName = movie.primaryGenreName
    }
}
