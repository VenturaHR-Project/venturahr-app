struct IbgeState {
    var id: Int
    var acronym: String
    var name: String
    var region: IbgeStateRegion
}

extension IbgeState: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case acronym = "sigla"
        case name = "nome"
        case region = "regiao"
    }
}
