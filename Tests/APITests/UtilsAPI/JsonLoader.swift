import Foundation


import Foundation

class JsonLoader {

    static func loadJsonData(from fileName: String) -> Data? {
        let bundle = Bundle(for: JsonLoader.self)
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            print("Could not find file: \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Failed to load file: \(fileName).json, error: \(error)")
            return nil
        }
    }


    static func decodeJson<T: Decodable>(from fileName: String, type: T.Type) -> T? {
        guard let data = loadJsonData(from: fileName) else { return nil }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Failed to decode file: \(fileName).json, error: \(error)")
            return nil
        }
    }
}




