//
//  EditProfileView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 1/9/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: ProfileViewModel
    @State private var birthDate = Date.now
    @State var firstNameField: String
    @State var lastNameField: String
    @State var bio: String
    var body: some View {
        List{
            Section("Name") {
                TextField("First name", text: $firstNameField)
                TextField("Last name", text: $lastNameField)
            }
            Section("Age") {
                DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Select a date")
                }
            }
            Section("Bio") {
                TextField("What would you like people to know about you", text: $bio)
            }
            Text("Sign out")
                .foregroundStyle(.red)
                .onTapGesture {
                    Task{
                        vm.signOut()
                    }
                }
            
            Text("Get Nuger Info")
                .foregroundStyle(.blue)
                .onTapGesture {
                    Task{
                      //  vm.signOut()
                    }
                }
        }
        .listStyle(.grouped)
        .navigationTitle("Edit Profile")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    vm.updateData(fName: firstNameField, lName: lastNameField, bio: bio, image: "", born: "")
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("update")
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
    EditProfileView(firstNameField: "lol",lastNameField: "lol",bio: "lol")
        .environmentObject(ProfileViewModel())
}
#Preview {
    MapKitView()
}
