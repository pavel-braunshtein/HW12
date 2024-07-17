//
//  PlaylistDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistDeleteViewController: UIViewController, PlaylistDeleteModelDelegate, PlaylistDeleteViewDelegate {
    
    @IBOutlet weak var contentView: PlaylistDeleteView!
    var model: PlaylistDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistDeleteModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.registerMainPlaylistCell()
    }
}

extension PlaylistDeleteViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension PlaylistDeleteViewController: MainPlaylistViewDelegate {
    
}

extension PlaylistDeleteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPlaylistCell.reuseIdentifier) as? MainPlaylistCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.songLabel.text = model.items[indexPath.row].songTitle
        cell.authorLabel.text = model.items[indexPath.row].author
        cell.albumLabel.text = model.items[indexPath.row].albumTitle
        cell.genreLabel.text = model.items[indexPath.row].genre
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.items.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension PlaylistDeleteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
