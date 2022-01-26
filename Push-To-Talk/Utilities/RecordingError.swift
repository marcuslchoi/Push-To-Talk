//
//  RecordingError.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/26/22.
//

import Foundation

enum RecordingError: String, Error {
    case invalidFilename = "This filename may have already been used, or has illegal special characters. Please try a different name."
    case unableToFindFiles = "Cannot locate files. Please try again."
    case fileDoesNotExist = "The file doesn't exist!"
    case failedToRemoveFile = "Failed to remove file."
}
