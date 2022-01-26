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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recordings"
        registerTableViewCells()
    }
    
    func registerTableViewCells()
    {
        let cell = UINib(nibName: K.recordingCellName, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: K.recordingCellName)
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recordings = recManager.getRecordings() else { return 0 }
        return recordings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.recordingCellName, for: indexPath) as! RecordingCell
        guard let recordings = recManager.getRecordings() else { return cell }
        cell.lblName.text = recordings[indexPath.row].name
        
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
        //todo show error notification
        guard let recordings = recManager.getRecordings(), recordings.count > row else { return }
        let audioFileUrl = recordings[row].url
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
        guard let recordings = recManager.getRecordings(), recordings.count > row else {
            showOkAlert(title: "Error", msg: "There was an error locating this file.")
            return
        }
        let recording = recordings[row]
        let alert = UIAlertController(title: "Are you sure?", message: "Do you want to delete \(recording.name)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            guard self.deleteFile(url: recording.url, row: row) else {
                self.showOkAlert(title: "Error", msg: "Unable to delete recording.")
                return
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteFile(url: URL, row: Int) -> Bool {
        if recManager.removeFile(localFileUrl: url) {
            let indexPath = IndexPath(row: row, section: sectionIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            return true
        }
        return false
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
