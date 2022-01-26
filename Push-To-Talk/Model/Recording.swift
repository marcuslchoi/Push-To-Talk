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
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}
