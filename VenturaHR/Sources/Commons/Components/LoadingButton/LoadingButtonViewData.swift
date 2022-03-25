struct LoadingButtonViewData {
    var action: () -> Void
    var buttonTitle: String
    var showProgress: Bool = false
    var disabled: Bool = false
}
