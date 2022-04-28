struct IbgeStateRegion {
    var id: Int
    var acronym: String
    var name: String
}

extension IbgeStateRegion: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case acronym = "sigla"
        case name = "nome"
    }
}

