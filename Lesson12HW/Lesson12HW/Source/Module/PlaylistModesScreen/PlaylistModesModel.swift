//
//  PlaylistModesModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistModesModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class PlaylistModesModel {
    
    weak var delegate: PlaylistModesModelDelegate?
    private let dataLoader = DataLoaderService()
    
    var items: [Song] = []
    var dictForSong: [String: [Song]] = [:]
    var dictForAuthor: [String: [Song]] = [:]
    
    func loadData() {
        
        dataLoader.loadPlaylist { playlist in
            
            self.items = playlist?.songs ?? []
            
            for song in self.items {
                
                if self.dictForSong[song.genre] == nil {
                    self.dictForSong[song.genre] = [song]
                } else {
                    self.dictForSong[song.genre]?.append(song)
                }
            }
            
            for song in self.items {
                
                if self.dictForAuthor[song.author] == nil {
                    self.dictForAuthor[song.author] = [song]
                } else {
                    self.dictForAuthor[song.author]?.append(song)
                }
            }
            
            self.delegate?.dataDidLoad()
        }
    }
}
