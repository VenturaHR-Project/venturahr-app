import SwiftUI

struct ToastView: View {
    var imageName: String = R.image.infoCircle.name
    var message: String
    
    @Binding var isDisabled: Bool
    
    var body: some View {
        ZStack {
            Color.orange

            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)

                Text(message)
                    .foregroundColor(.white)
            }
            .padding(5)
        }
        .opacity(isDisabled ? 0 : 1)
        .frame(idealWidth: .infinity, idealHeight: 50, maxHeight: 50, alignment: .center)
        .cornerRadius(12)
        .padding(10)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(
            imageName: R.image.infoCircle.name,
            message: "Lorem ipsum nullam varius, quisque tris",
            isDisabled: .constant(true)
        )
    }
}
