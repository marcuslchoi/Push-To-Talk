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
    //var delegate: RecordingManagerDelegate?
    private init() {
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
}
