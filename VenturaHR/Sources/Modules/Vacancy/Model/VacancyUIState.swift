enum VacancyUIState: Equatable {
    case hasError(message: String)
    case loading
    case emptyList
    case fullList
}
