enum IbgeServiceEndpoint {
    case getUfs
    case getCities
}

extension IbgeServiceEndpoint {
    private var baseUrl: String {
        "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    }
    
    var value: String {
        switch self {
        case .getUfs:
            return baseUrl
        case .getCities:
            return "\(baseUrl)/%@/municipios"
        }
    }
}
