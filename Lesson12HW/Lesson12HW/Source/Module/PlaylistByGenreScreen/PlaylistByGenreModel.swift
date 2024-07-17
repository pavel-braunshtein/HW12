//
//  PlaylistByGenreModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistByGenreModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class PlaylistByGenreModel {
    
    weak var delegate: PlaylistByGenreModelDelegate?
    private let dataLoader = DataLoaderService()
    
    var items: [Song] = []
    var dict: [String: [Song]] = [:]
    
    func loadData() {
        
        dataLoader.loadPlaylist { playlist in
            
            self.items = playlist?.songs ?? []
            
            for song in self.items {
                if self.dict[song.genre] == nil {
                    self.dict[song.genre] = [song]
                } else {
                    self.dict[song.genre]?.append(song)
                }
            }
            self.delegate?.dataDidLoad()
        }
    }
}
