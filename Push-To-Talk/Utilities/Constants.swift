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
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    static let audiofileExtension = ".m4a"
    static let recordingCellName = "RecordingCell"
}
