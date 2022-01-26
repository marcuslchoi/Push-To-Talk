//
//  Constants.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import UIKit
import AVFoundation

enum SFSymbols {
    static let mic = "mic.circle.fill"
    static let play = "play"
    static let stop = "stop.circle.fill"
}

enum Alert {
    static let errorTitle = "Error"
    static let successTitle = "Success!"
    static let failTitle = "Fail!"
    static let recordingFailedTitle = "Recording save failed"
    static let nameSaveFailedTitle = "Name save failed"
    static let noMicTitle = "Cannot Record"
    static let noMicMsg = "Please allow access to the microphone in order to record audio."
    static let micEnableErrorMsg = "There was an error enabling the microphone, please try again."
    static let nameRecordingMsg = "Please name your recording."
    static let recordingFailMsg = "Recording failed."
    static let okButtonTitle = "OK"
    static let cancelButtonTitle = "Cancel"
    static let deleteButtonTitle = "Delete"
    static let inputRecordingNamePlaceholder = "Input recording name..."
    static let playFileFailedMsg = "There was a problem playing the audio file."
    static let confirmDeleteTitle = "Please confirm"
    static func getDeleteConfirmMsg(filename: String) -> String {
        return "Do you want to delete \(filename)?"
    }
}

struct K {
    
    static let recordingsTitle = "Recordings"
    static let recordTitle = "Push To Talk"
    static let largeImgConfig = UIImage.SymbolConfiguration(pointSize: 150, weight: .bold, scale: .large)
    static let recordingImage = UIImage(systemName: SFSymbols.mic, withConfiguration: largeImgConfig)
    static let stopImage = UIImage(systemName: SFSymbols.stop, withConfiguration: largeImgConfig)
    
    static let defaultRecordingName = "Recording"
    static let localDocsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let recordingSettings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 48000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    static let audiofileExtension = ".m4a"
    static let recordingCellName = "RecordingCell"
}
