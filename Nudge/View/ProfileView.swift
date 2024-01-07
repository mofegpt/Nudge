//
//  ProfileView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/20/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    var body: some View {
        
        ScrollView(showsIndicators: false){
            VStack() {
                PfTopComp(firstName: vm.userData.firstName, lastName: vm.userData.lastName, age: vm.userData.born)
                    //.padding(.top, 50)
                Divider()
                
                HStack {
                    Text("Requested")
                    .font(.callout)
                    .bold()
                    .padding(.bottom)
                    Spacer()
                }
                
                
                ForEach(0..<2, id: \.self) { _ in
                    ListOfRequestedComp()
                }
            }
            .padding()
            .onAppear{
                vm.getAppData()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    vm.signOut()
                    
                }label: {
                    Text("Sign out")
                        .foregroundStyle(Color("bw"))
                        .bold()
                        .font(.caption)
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
#Preview {
    MapKitView()
}
