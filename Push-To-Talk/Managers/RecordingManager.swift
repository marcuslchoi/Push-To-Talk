//
//  RecordingManager.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import Foundation

enum RecordingError: String, Error {
    case invalidFilename = "Invalid filename. Please try a different name."
    case unableToFindFiles = "Cannot locate files. Please try again."
    case fileDoesNotExist = "The file doesn't exist!"
    case failedToRemoveFile = "Failed to remove file."
}

class RecordingManager {

    //singleton
    static var shared = RecordingManager()
    private init() {}
    
    func renameFile(oldName: String, newName: String, completion: (RecordingError?) -> Void) {
        let oldAudioFilename = K.localDocsUrl.appendingPathComponent("\(oldName)\(K.audiofileExtension)")
        let newAudioFilename = K.localDocsUrl.appendingPathComponent("\(newName)\(K.audiofileExtension)")
        do {
            try FileManager.default.moveItem(at: oldAudioFilename, to: newAudioFilename)
        } catch {
            completion(.invalidFilename)
        }
        completion(nil)
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
    
    func getRecordings(completion: (Result<[Recording], RecordingError>) -> Void) {
        guard let urls = getLocalDocURLs() else {
            completion(.failure(.unableToFindFiles))
            return
        }

        var recordings: [Recording] = []
        for url in urls {
            let recording = Recording(url: url)
            recordings.append(recording)
        }
        completion(.success(recordings))
    }
    
    //return true if successfully removed file
    func removeFile(localFileUrl: URL, completion: (RecordingError?) -> Void)
    {
        if FileManager.default.fileExists(atPath: localFileUrl.path)
        {
            do {
                try FileManager.default.removeItem(at: localFileUrl)
            }
            catch
            {
                completion(.failedToRemoveFile)
            }
        } else {
            completion(.fileDoesNotExist)
        }
        completion(nil)
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
