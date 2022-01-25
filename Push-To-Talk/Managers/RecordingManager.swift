//
//  RecordingManager.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import Foundation

class RecordingManager {
    
    var currDefaultRecordingName = "Recording"
    //singleton
    static var shared = RecordingManager()
    //var delegate: RecordingManagerDelegate?
    private init() {
    }
    
    func renameFile(newName: String) { 
        let oldAudioFilename = K.localDocsUrl.appendingPathComponent("\(currDefaultRecordingName)\(K.audiofileExtension)")
        let newAudioFilename = K.localDocsUrl.appendingPathComponent("\(newName)\(K.audiofileExtension)")
        do {
            try FileManager.default.moveItem(at: oldAudioFilename, to: newAudioFilename)
        } catch {
            print(error)
        }
    }
    
    func getLocalDocURLs() -> [URL]?
    {
        do
        {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: K.localDocsUrl, includingPropertiesForKeys: nil)
            return directoryContents
        } catch {
            print(error)
            return nil
        }
    }
    
    func getLocalFileNames() -> [String]?
    {
        if let urls = getLocalDocURLs()
        {
            let fileNames = urls.map{ $0.deletingPathExtension().lastPathComponent }
            return fileNames
        }
        return nil
    }
    
    func removeFile(localFileUrl: URL)
    {
        if FileManager.default.fileExists(atPath: localFileUrl.path)
        {
            do {
                try FileManager.default.removeItem(at: localFileUrl)
            }
            catch
            {
                print(error)
            }
        }
    }
    
    func getCurrentDateString() -> String {
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]

        // get the components
        let c = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let seconds = c.second!
        var secStr: String
        if seconds < 10 { secStr = "0\(seconds)"}  else {
            secStr = "\(seconds)" }
        
        let minutes = c.minute!
        var minStr: String
        if minutes < 10 { minStr = "0\(minutes)"}  else {
            minStr = "\(minutes)" }
        
        let dateStr = "\(c.month!) \(c.day!) \(c.year!), \(c.hour!):\(minStr):\(secStr)"
        return dateStr
    }
}
