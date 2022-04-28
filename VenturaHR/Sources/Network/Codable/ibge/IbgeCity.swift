struct IbgeCity {
    var id: String
    var name: String
}

extension IbgeCity: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
    }
}
