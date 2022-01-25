//
//  RecordingsTableVC.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import UIKit
import AVFoundation

class RecordingsTableVC: UITableViewController {

    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recordings"
        registerTableViewCells()
    }
    
    func registerTableViewCells()
    {
        let cell = UINib(nibName: "RecordingCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "RecordingCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let localFilenames = RecordingManager.shared.getLocalFileNames() else { return 0 }
        return localFilenames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordingCell", for: indexPath) as! RecordingCell
        guard let localFilenames = RecordingManager.shared.getLocalFileNames() else { return cell }
        cell.lblName.text = localFilenames[indexPath.row]
        
        cell.btnPlay.tag = indexPath.row
        cell.btnPlay.addTarget(self, action: #selector(onButtonPlayPress), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(onButtonDeletePress), for: .touchUpInside)
        
        return cell
    }
    
    @objc func onButtonPlayPress(sender: UIButton) {
        let row = sender.tag
        playAudio(at: row)
    }
    
    func playAudio(at row: Int) {
        //todo show error notification
        guard let localUrls = RecordingManager.shared.getLocalDocURLs(), localUrls.count > row else { return }
        let audioFilename = localUrls[row]
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.delegate = self
            audioPlayer.play()
        } catch {
            showOkAlert(title: "Error", msg: "There was a problem playing the audio file.")
        }
    }
    
    @objc func onButtonDeletePress(sender: UIButton) {
        let row = sender.tag
    }
}

extension RecordingsTableVC: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio player finished playing")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
}
