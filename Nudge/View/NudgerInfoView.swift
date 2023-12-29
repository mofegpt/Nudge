//
//  NudgerInfoView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import SwiftUI

struct NudgerInfoView: View {
    @StateObject var vm =  NudgerInfoViewModel()
    @Environment(\.presentationMode) var presentationMode

    var nudgerID: Int
    var distance: Double
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                Image("simp")
                    .resizable()
                    .scaledToFill()
                VStack(alignment: .leading) {
                    HStack(spacing: 15) {
                        Text(vm.Info!.FirstName + " " + vm.Info!.LastName)
                            .bold()
                            .font(.title)
                        Text(vm.Info?.Age ?? "0")
                            .font(.title2)
                        Spacer()
                        Image(systemName: "bell.fill")
                            .font(.title)
                            .foregroundStyle(.purple)
                            .padding(.trailing)
                    }
                    HStack(alignment: .bottom){
                        Text( "\(Image(systemName: "figure.stand.line.dotted.figure.stand")) \(distance.rounded().formatNumber()) meters away")
                            .font(.caption)
                    }
                    .foregroundStyle(.secondary)
                    
                    Divider()
                    
                    Text("About Me")
                        .bold()
                        .font(.title3)
                    
                    Text(vm.Info!.Bio)
                        .font(.callout)
                    
                    Divider()
                    
                    Text("Interest")
                        .bold()
                        .font(.title3)
                }
                .padding(.leading)
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(vm.interests, id: \.id) { value in
                            InterestCompView(text: value.interest)
                        }
                  }
                    
                    .padding(.leading)
                    .padding(.vertical, 4)
                }
            }
            .onAppear{
                vm.getUser(id: nudgerID)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
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
        .ignoresSafeArea()
    }
}

#Preview {
    NudgerInfoView(nudgerID: 1, distance: 1.999)
}
