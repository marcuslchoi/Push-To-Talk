//
//  ViewController.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import UIKit
import AVFoundation

class RecordVC: UIViewController {

    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var isRecording: Bool { return audioRecorder != nil }
    @IBOutlet weak var btnRecord: UIButton!
    let recordingImage = UIImage(systemName: SFSymbols.mic)
    let stopImage = UIImage(systemName: SFSymbols.stop)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Push To Talk"
        requestRecordingPermission()
        configureRecordButton()
    }
    
    private func configureRecordButton() {
        if isRecording {
            btnRecord.setImage(stopImage, for: .normal)
            btnRecord.setTitle("Stop", for: .normal)
        } else {
            btnRecord.setImage(recordingImage, for: .normal)
            btnRecord.setTitle("Record", for: .normal)
        }
    }

    private func requestRecordingPermission() {
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                print(allowed)
                DispatchQueue.main.async {
                    if allowed {
                        // recording allowed
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    @IBAction func onButtonRecordPress(_ sender: Any) {
        if isRecording {
            finishRecording(success: true)
        }
        else {
            startRecording()
        }
        configureRecordButton()
    }
    
    func startRecording() {
        let defaultRecordingName = RecordingManager.shared.currDefaultRecordingName
        let audioFilename = K.localDocsUrl.appendingPathComponent("\(defaultRecordingName)\(K.audiofileExtension)")
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: K.recordingSettings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            self.showAlertWithTextField(title: "Success!", msg: "Please name your recording.")
        } else {
            self.showOkAlert(title: "Fail!", msg: "Recording failed.")
        }
    }
}

extension RecordVC: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audio recorder did finish recording")
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }
}