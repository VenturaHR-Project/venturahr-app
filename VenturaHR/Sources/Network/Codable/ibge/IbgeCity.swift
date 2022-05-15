import Foundation

struct IbgeCity {
    var id: String
    var name: String
    
    static func decode(data: Data) -> [IbgeCity]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([IbgeCity].self, from: data)
    }
}

extension IbgeCity: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
    }
}
