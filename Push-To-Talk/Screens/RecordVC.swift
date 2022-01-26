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
    @IBOutlet weak var btnGoToRecordings: UIBarButtonItem!
    
    let recManager = RecordingManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.recordTitle
        requestRecordingPermission()
        configureRecordButton()
    }
    
    private func configureRecordButton() {
        if isRecording {
            btnRecord.setImage(K.stopImage, for: .normal)
            btnRecord.setTitle("", for: .normal)
        } else {
            btnRecord.setImage(K.recordingImage, for: .normal)
            btnRecord.setTitle("", for: .normal)
        }
        btnGoToRecordings.isEnabled = !isRecording
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
                        self.showOkAlert(title: Alert.noMicTitle, msg: Alert.noMicMsg)
                    }
                }
            }
        } catch {
            self.showOkAlert(title: Alert.errorTitle, msg: Alert.micEnableErrorMsg)
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
        let audioFilename = K.localDocsUrl.appendingPathComponent("\(K.defaultRecordingName)\(K.audiofileExtension)")
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: K.recordingSettings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        
        guard isRecording else { return }
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            self.showNameRecordingAlert(title: Alert.successTitle, msg: Alert.nameRecordingMsg)
        } else {
            self.showOkAlert(title: Alert.failTitle, msg: Alert.recordingFailMsg)
        }
    }
    
    //Show an alert to name the recording. If no name is entered, the name is the current date/time. If name save fails, show the alert again.
    func showNameRecordingAlert(title: String, msg: String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Alert.okButtonTitle, style: .default) { (action) in
                if let txt = alert.textFields?.first?.text {
                    let newName = txt.isEmpty ? self.recManager.getCurrentDateString() : txt
                    self.recManager.renameFile(oldName: K.defaultRecordingName, newName: newName) { [weak self] error in
                        guard let self = self else { return }
                        if let error = error {
                            self.showNameRecordingAlert(title: Alert.nameSaveFailedTitle, msg: error.rawValue)
                        }
                    }
                }
            }
            alert.addTextField { textField in
                textField.placeholder = Alert.inputRecordingNamePlaceholder
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RecordVC: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audio recorder did finish recording")
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        finishRecording(success: false)
    }
}
