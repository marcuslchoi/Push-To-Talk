//
//  Constants.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import Foundation
import AVFoundation

enum SFSymbols {
    static let mic = "mic"
    static let play = "play"
    static let delete = "delete.left"
    static let stop = "stop"
}

struct K {
    
    static let localDocsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let recordingSettings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
}
