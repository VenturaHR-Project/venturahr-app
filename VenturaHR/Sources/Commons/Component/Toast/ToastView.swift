import SwiftUI

struct ToastView: View {
    var imageName: String = R.image.infoCircle.name
    var message: String
    
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
        .frame(width: .infinity, height: 50, alignment: .center)
        .cornerRadius(12)
        .padding(10)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(
            imageName: R.image.infoCircle.name,
            message: "Lorem ipsum nullam varius, quisque tris"
        )
    }
}
