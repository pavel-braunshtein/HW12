//
//  PlaylistByGenreViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistByGenreViewController: UIViewController, PlaylistByGenreModelDelegate, PlaylistByGenreViewDelegate {
    
    @IBOutlet weak var contentView: PlaylistByGenreView!
    var model: PlaylistByGenreModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistByGenreModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.registerMainPlaylistCell()
    }
}

extension PlaylistByGenreViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension PlaylistByGenreViewController: MainPlaylistViewDelegate {
    
}

extension PlaylistByGenreViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return model.dict.keys.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let index = model.dict.index(model.dict.startIndex, offsetBy: section)
        let key = model.dict.keys[index]
        
        return model.dict[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPlaylistCell.reuseIdentifier) as? MainPlaylistCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let index = model.dict.index(model.dict.startIndex, offsetBy: indexPath.section)
        let key = model.dict.keys[index]
        
        cell.songLabel.text = model.dict[key]?[indexPath.row].songTitle ?? ""
        cell.authorLabel.text = model.dict[key]?[indexPath.row].author ?? ""
        cell.albumLabel.text = model.dict[key]?[indexPath.row].albumTitle ?? ""
        cell.genreLabel.text = model.dict[key]?[indexPath.row].genre ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let index = model.dict.index(model.dict.startIndex, offsetBy: section)
        let key = model.dict.keys[index]
        
        return "Жанр: \(key)"
    }
}

extension PlaylistByGenreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
