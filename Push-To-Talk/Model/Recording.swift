//
//  Recording.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/25/22.
//

import Foundation

struct Recording {
    let name: String
    let url: URL
    
    init(url: URL) {
        self.name = url.deletingPathExtension().lastPathComponent
        self.url = url
    }
}
