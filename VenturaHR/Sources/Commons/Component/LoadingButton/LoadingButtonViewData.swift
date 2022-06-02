import SwiftUI

struct LoadingButtonViewData {
    var action: () -> Void
    var buttonTitle: String
    var showProgress: Bool = false
    var disabled: Bool = false
    var verticalPadding: CGFloat = 14
    var horizontalPadding: CGFloat = 16
}
