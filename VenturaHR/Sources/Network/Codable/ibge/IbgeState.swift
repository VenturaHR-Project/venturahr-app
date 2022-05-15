import Foundation

struct IbgeState {
    var id: Int
    var acronym: String
    var name: String
    var region: IbgeStateRegion
    
    static func decode(data: Data) -> [IbgeState]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([IbgeState].self, from: data)
    }
}

extension IbgeState: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case acronym = "sigla"
        case name = "nome"
        case region = "regiao"
    }
}
