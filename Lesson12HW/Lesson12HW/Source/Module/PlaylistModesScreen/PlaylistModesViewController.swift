//
//  PlaylistModesViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistModesViewController: UIViewController, PlaylistModesModelDelegate, PlaylistModesViewDelegate {
    
    @IBOutlet weak var contentView: PlaylistModesView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var model: PlaylistModesModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistModesModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.registerMainPlaylistCell()
    }
    
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) {
                print("Выбран сегмент: \(selectedTitle)")
            contentView.tableView.reloadData()
            }
    }
}


extension PlaylistModesViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension PlaylistModesViewController: MainPlaylistViewDelegate {
    
}

extension PlaylistModesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return model.dictForSong.keys.count
        case 2:
            return model.dictForSong.keys.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let index = model.dictForSong.index(model.dictForSong.startIndex, offsetBy: section)
        let key = model.dictForSong.keys[index]
        
        let indexForAuthor = model.dictForAuthor.index(model.dictForAuthor.startIndex, offsetBy: section)
        let keyForAuthor = model.dictForAuthor.keys[indexForAuthor]
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return model.items.count
        case 1:
            return model.dictForSong[key]?.count ?? 0
        case 2:
            return model.dictForAuthor[keyForAuthor]?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPlaylistCell.reuseIdentifier) as? MainPlaylistCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let index = model.dictForSong.index(model.dictForSong.startIndex, offsetBy: indexPath.section)
        let key = model.dictForSong.keys[index]
        
        let indexForAuthor = model.dictForAuthor.index(model.dictForAuthor.startIndex, offsetBy: indexPath.section)
        let keyForAuthor = model.dictForAuthor.keys[indexForAuthor]
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            cell.songLabel.text = model.items[indexPath.row].songTitle
            cell.authorLabel.text = model.items[indexPath.row].author
            cell.albumLabel.text = model.items[indexPath.row].albumTitle
            cell.genreLabel.text = model.items[indexPath.row].genre
        case 1:
            cell.songLabel.text = model.dictForSong[key]?[indexPath.row].songTitle ?? ""
            cell.authorLabel.text = model.dictForSong[key]?[indexPath.row].author ?? ""
            cell.albumLabel.text = model.dictForSong[key]?[indexPath.row].albumTitle ?? ""
            cell.genreLabel.text = model.dictForSong[key]?[indexPath.row].genre ?? ""
        case 2:
            cell.songLabel.text = model.dictForAuthor[keyForAuthor]?[indexPath.row].songTitle ?? ""
            cell.authorLabel.text = model.dictForAuthor[keyForAuthor]?[indexPath.row].author ?? ""
            cell.albumLabel.text = model.dictForAuthor[keyForAuthor]?[indexPath.row].albumTitle ?? ""
            cell.genreLabel.text = model.dictForAuthor[keyForAuthor]?[indexPath.row].genre ?? ""
        default:
            cell.songLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch segmentControl.selectedSegmentIndex {
        case 1:
            let index = model.dictForSong.index(model.dictForSong.startIndex, offsetBy: section)
            let key = model.dictForSong.keys[index]
            return "Жанр: \(key)"
        case 2:
            let indexForAuthor = model.dictForAuthor.index(model.dictForAuthor.startIndex, offsetBy: section)
            let keyForAuthor = model.dictForAuthor.keys[indexForAuthor]
            return "Автор: \(keyForAuthor)"
        default:
            return ""
        }
    }
}

extension PlaylistModesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
