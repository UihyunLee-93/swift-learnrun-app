import SwiftUI

struct UserProfile {
    var newData: Bool = false
}

struct StartView: View {
    @State private var userProfile = UserProfile()
    @State private var isButtonPressed = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    
                    HStack {
                        Spacer()
                        ZStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 55, height: 55)

                            if userProfile.newData {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 13, height: 13)
                                    .offset(x: 17, y: -20)
                            }
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 10)

                    Spacer()


                    Text("Learn Run!")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .padding(.bottom, 10)


                    Image("run_")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .padding(.bottom, 30)


                    NavigationLink(destination: CategoryView()) {
                        Text("Start")
                            .frame(width: 160, height: 50)
                            .background(isButtonPressed ? Color.blue : Color.clear)
                            .foregroundColor(isButtonPressed ? .white : .blue)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        isButtonPressed.toggle()
                    })
                    .padding(.top, 20)

                    Spacer()
                }
            }
        }
    }
}


#Preview {
    StartView()
}
