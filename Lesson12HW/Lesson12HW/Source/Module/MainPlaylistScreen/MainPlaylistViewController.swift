//
//  MainPlaylistViewController.swift
//  Lesson12HW
//

//

import UIKit

class MainPlaylistViewController: UIViewController {
    
    @IBOutlet weak var contentView: MainPlaylistView!
    var model: MainPlaylistModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = MainPlaylistModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.registerMainPlaylistCell()
    }
}

extension MainPlaylistViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension MainPlaylistViewController: MainPlaylistViewDelegate {
    
}

extension MainPlaylistViewController: UITableViewDataSource {
    
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
}

extension MainPlaylistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
