//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController, PlaylistMoveDeleteModelDelegate, PlaylistMoveDeleteViewDelegate {
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
        
        let changeButton = UIBarButtonItem(title: "Change", style: .plain, target: self, action: #selector(changeButtonTapped))
        navigationItem.rightBarButtonItem = changeButton
    }
    
    private func setupInitialState() {
        
        model = PlaylistMoveDeleteModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.registerMainPlaylistCell()
    }
    
    @objc func changeButtonTapped() {
        
        contentView.tableView.isEditing = !contentView.tableView.isEditing
        navigationItem.rightBarButtonItem?.title = contentView.tableView.isEditing ? "Done" : "Edit"
        
    }
}



extension PlaylistMoveDeleteViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension PlaylistMoveDeleteViewController: MainPlaylistViewDelegate {
    
}

extension PlaylistMoveDeleteViewController: UITableViewDataSource {
    
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
    //MARK: - CallCanBeDelete
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if tableView.isEditing {
            return .delete
        } else {
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     
        if tableView.isEditing && editingStyle == .delete {
          
            model.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - CellCanMove
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        let movedItem = model.items[sourceIndexPath.row]
        
        model.items.remove(at: sourceIndexPath.row)
        model.items.insert(movedItem, at: destinationIndexPath.row)
    }
    
}

extension PlaylistMoveDeleteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
