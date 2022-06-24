struct CandidateData {
    var userUid: String = ""
    var name: String = ""
    var phone: String = ""
    var score: Double = 0
    
    static func map(answersResponse: [AnswerVacancyResponseDTO]) -> [CandidateData] {
        let candidate: [CandidateData] = answersResponse.map { answer in
            return CandidateData(userUid: answer.userUid,
                                 name: answer.userName,
                                 phone: answer.userPhone,
                                 score: answer.score)
        }
        return candidate
    }
}
