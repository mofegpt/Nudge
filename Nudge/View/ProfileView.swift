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
                NavigationLink {
                    EditProfileView(firstNameField: vm.userData.firstName, lastNameField: vm.userData.lastName, bio: vm.userData.bio)
                        .environmentObject(vm)
                } label: {
                    Text("Edit Profile")
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
        .environmentObject(vm)
    }
}

#Preview {
    ProfileView()
}
#Preview {
    MapKitView()
}
