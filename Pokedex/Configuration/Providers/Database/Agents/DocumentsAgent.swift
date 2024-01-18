//
//  DocumentsAgent.swift
//  Pokedex
//
//  Created by DIEGO on 17/01/24.
//

import Foundation
import Combine

public enum DecodableModel{
    case pokemonList([PokemonItemListModel])
    case pokemon(PokemonModel)
    
    var nameFile: String {
        switch self {
        case .pokemonList:
            return "pokemon_list.json"
        case let .pokemon(item):
            return "\(item.name).json"
        }
    }
    
    var type: Decodable.Type {
        switch self {
        case .pokemon: return PokemonModel.self
        case.pokemonList: return [PokemonItemListModel].self
        }
    }
}

class DocumentsAgent: DataBaseAgent {
    
    func add(_ model: DecodableModel) {
        switch model {
        case let .pokemon(item):
            if !self.fileExists(model.nameFile, in: .documents) {
                self.add(item, to: .documents, as: model.nameFile)
            }
        case let .pokemonList(list):
            self.add(list, to: .documents, as: model.nameFile)
        }
    }
    
    func retrieve<T: Decodable>(_ name: String?, type: T.Type) -> T? {
        return self.retrieve(name, from: .documents, as: type.self)
    }

}

extension DocumentsAgent {
    
    func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }
        
        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    func add<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func retrieve<T: Decodable>(_ fileName: String?, from directory: Directory, as type: T.Type) -> T? {
        guard let name = fileName else { return nil }
        let url = getURL(for: directory).appendingPathComponent(name, isDirectory: false)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                return nil
            }
        } else {
            fatalError("No data at \(url.path)!")
        }
    }
    
    func clear(_ directory: Directory) {
        let url = getURL(for: directory)
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func remove(_ fileName: String, from directory: Directory) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
    
}
