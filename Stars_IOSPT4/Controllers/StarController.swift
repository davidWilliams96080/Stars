//
//  StarController.swift
//  Stars_IOSPT4
//
//  Created by David Williams on 12/5/19.
//  Copyright © 2019 david williams. All rights reserved.
//

import Foundation

class StarController {
    
    init() {
        loadFromPersistentStore()
    }
    
    // CRUD functions = creating, reading, updating, deleting objects
    // Access control -  the stars array can only be set from within StarContoller
    private(set) var stars: [Star] = []
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("stars.plist")
        
    }
    
    // Create
    // @discardableResult - YOu can call the dunction without doing anything with the return value
    // Throw away the return value if not assigned to anything
    @discardableResult func createStar(named name: String, withDistance distance: Double) -> Star {
        let star = Star(name: name, distance: distance)
        stars.append(star)
        saveToPersistentStore()
        return star
        
    }
    // Save and load
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(stars)
            try data.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        // Data in Plist -> Star
        let fileManager = FileManager.default
        guard let url = persistentFileURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data =  try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            stars =  try decoder.decode([Star].self, from: data)
        } catch {
            print("Error loading stars dats: \(error)")
        }
    }
    
}
