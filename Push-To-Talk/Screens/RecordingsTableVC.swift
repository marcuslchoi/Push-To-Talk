//
//  RecordingsTableVC.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import UIKit
import AVFoundation

class RecordingsTableVC: UITableViewController {

    var currPlayingButton: UIButton?
    var audioPlayer: AVAudioPlayer!
    let sectionCount = 1
    private var sectionIndex: Int { return sectionCount - 1 }
    let recManager = RecordingManager.shared
    var currRecordings: [Recording] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.recordingsTitle
        populateRecordings()
        registerTableViewCells()
        tableView.reloadData()
    }
    
    //populate the currRecordings property
    private func populateRecordings() {
        recManager.getRecordings { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let recordings):
                self.currRecordings = recordings
            case .failure(let error):
                self.showOkAlert(title: "Error", msg: error.rawValue)
            }
        }
    }
    
    func registerTableViewCells()
    {
        let cell = UINib(nibName: K.recordingCellName, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: K.recordingCellName)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currRecordings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.recordingCellName, for: indexPath) as! RecordingCell

        cell.lblName.text = currRecordings[indexPath.row].name
        cell.btnPlay.tag = indexPath.row
        cell.btnPlay.addTarget(self, action: #selector(onButtonPlayPress), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(onButtonDeletePress), for: .touchUpInside)
        
        return cell
    }
    
    @objc func onButtonPlayPress(sender: UIButton) {
        let row = sender.tag
        sender.backgroundColor = .systemGreen
        if currPlayingButton != sender {
            currPlayingButton?.backgroundColor = .systemBackground
            currPlayingButton = sender
        }
        playAudio(at: row)
    }
    
    func playAudio(at row: Int) {
        let audioFileUrl = currRecordings[row].url
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
            audioPlayer.delegate = self
            audioPlayer.play()
        } catch {
            showOkAlert(title: "Error", msg: "There was a problem playing the audio file.")
        }
    }
    
    @objc func onButtonDeletePress(sender: UIButton) {
        let row = sender.tag
        showConfirmDeleteAlert(for: row)
    }
    
    private func showConfirmDeleteAlert(for row: Int)
    {
        let recording = currRecordings[row]
        let alert = UIAlertController(title: "Are you sure?", message: "Do you want to delete \(recording.name)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteFile(url: recording.url, row: row)
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteFile(url: URL, row: Int) {
        recManager.removeFile(localFileUrl: url) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showOkAlert(title: "Error", msg: error.rawValue)
            } else {
                onDeleteFileSuccess(row: row)
            }
        }
    }
    
    private func onDeleteFileSuccess(row: Int) {
        DispatchQueue.main.async {
            self.populateRecordings()
            let indexPath = IndexPath(row: row, section: self.sectionIndex)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }
}

extension RecordingsTableVC: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio player finished playing")
        currPlayingButton?.backgroundColor = .systemBackground
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
}
