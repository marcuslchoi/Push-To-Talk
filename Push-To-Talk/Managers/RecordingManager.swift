//
//  RecordingManager.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import Foundation

class RecordingManager {

    //singleton
    static var shared = RecordingManager()
    private init() {}
    
    func renameFile(oldName: String, newName: String) {
        let oldAudioFilename = K.localDocsUrl.appendingPathComponent("\(oldName)\(K.audiofileExtension)")
        let newAudioFilename = K.localDocsUrl.appendingPathComponent("\(newName)\(K.audiofileExtension)")
        do {
            try FileManager.default.moveItem(at: oldAudioFilename, to: newAudioFilename)
        } catch {
            print(error)
        }
    }
    
    private func getLocalDocURLs() -> [URL]?
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
    
    func getRecordings() -> [Recording]? {
        guard let urls = getLocalDocURLs() else { return nil }

        var recordings: [Recording] = []
        for url in urls {
            let filename = url.deletingPathExtension().lastPathComponent
            let recording = Recording(name: filename, url: url)
            recordings.append(recording)
        }
        return recordings
    }
    
    //return true if successfully removed file
    func removeFile(localFileUrl: URL) -> Bool
    {
        if FileManager.default.fileExists(atPath: localFileUrl.path)
        {
            do {
                try FileManager.default.removeItem(at: localFileUrl)
            }
            catch
            {
                print(error)
                return false
            }
        } else {
            print("the file does not exist at \(localFileUrl)")
            return false
        }
        
        return true
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
        let secStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minutes = c.minute!
        let minStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        
        let dateStr = "\(c.month!) \(c.day!) \(c.year!), \(c.hour!):\(minStr):\(secStr)"
        return dateStr
    }
}
