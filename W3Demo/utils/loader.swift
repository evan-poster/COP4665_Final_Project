//
//  json_loader.swift
//  W2D3_SwiftDataLiveDemo
//
//  Created by Joseph Bender on 9/14/25.
//

import Foundation

final class JSONLoader {
    enum Source { case bundle, documents, url(URL) }

    private func bundleURL(for path: String) -> URL? {
        let name = (path as NSString).deletingPathExtension
        let ext  = (path as NSString).pathExtension.isEmpty ? "json"
                                                            : (path as NSString).pathExtension
        return Bundle.main.url(forResource: name, withExtension: ext)
    }

    private func documentsURL(for path: String) -> URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(path)
    }

    func load<T: Decodable>(_ type: T.Type,
                            path: String?,
                            from source: Source = .bundle,
                            configure: ((JSONDecoder) -> Void)? = nil) throws -> T {
        var url: URL

        switch source {
        case .bundle:
            guard let path, let bundleUrl = bundleURL(for: path) else {
                throw NSError(domain: "JSONLoader", code: 1,
                              userInfo: [NSLocalizedDescriptionKey: "Bundle file not found: \(path ?? "<nil>")"])
            }
            url = bundleUrl

        case .documents:
            guard let path else {
                throw NSError(domain: "JSONLoader", code: 2,
                              userInfo: [NSLocalizedDescriptionKey: "Documents path is required"])
            }
            url = documentsURL(for: path)

        case .url(let explicit):
            url = explicit
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        configure?(decoder)
        return try decoder.decode(T.self, from: data)
        
        
    }
}
