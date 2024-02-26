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
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .aspectRatio(contentMode: .fill)
                })
                
                Spacer()
                
            }
            .padding()
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
                    TextField("What would you like people to know about you", text: $vm.user.Bio)
                }
                Text("Sign out")
                    .foregroundStyle(.red)
                    .onTapGesture {
                        Task{
                            vm.signOut()
                        }
                    }
                
                Text("Save")
                    .foregroundStyle(.red)
                    .onTapGesture {
                        Task{
                        await vm.updateUser()
                        }
                    }
                
              
            }
            .listStyle(.grouped)
            .navigationTitle("Edit Profile")
            .toolbar{
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button{
//                        vm.updateData(fName: firstNameField, lName: lastNameField, bio: bio, image: "", born: "")
//                        presentationMode.wrappedValue.dismiss()
//                    }label: {
//                        Text("update")
//                            .foregroundStyle(Color("bw"))
//                            .bold()
//                            .font(.caption)
//                            .padding(.horizontal)
//                            .padding(.vertical,10)
//                            .background(.purple)
//                            .clipShape(RoundedRectangle(cornerRadius: 20))
//                    }
//                }
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
