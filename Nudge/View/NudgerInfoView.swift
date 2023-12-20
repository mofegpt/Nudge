//
//  NudgerInfoView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import SwiftUI

struct NudgerInfoView: View {
    @StateObject var vm =  NudgerInfoViewModel()
//    init(){
//        vm.getUser()
//    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Image("simp")
                    .resizable()
                    .scaledToFill()
                VStack(alignment: .leading) {
                    HStack(spacing: 15) {
                        Text(vm.NudgerInfo.FirstName! + " " + vm.NudgerInfo.LastName!)
                            .bold()
                            .font(.largeTitle)
                        Text(vm.NudgerInfo.age!.description)
                            .font(.title)
                        Spacer()
                        Image(systemName: "bell.fill")
                            .font(.title)
                            .foregroundStyle(.red)
                            .padding(.trailing)
                    }
                    HStack(alignment: .bottom){
                        Image(systemName: "figure.stand.line.dotted.figure.stand")
                        Text(vm.NudgerInfo.Distance!.description + " meters away")
                    }
                    
                    Divider()
                    
                    Text("About Me")
                        .bold()
                        .font(.title2)
                    
                    Text(vm.NudgerInfo.Bio!.description)
                    
                    Divider()
                    
                    Text("Interest")
                        .bold()
                        .font(.title2)
                }
                .padding(.leading)
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(vm.NudgerInfo.Interests!, id: \.id) { value in
                            InterestCompView(text: value.interest)
                        }
                  }
                    
                    .padding(.leading)
                    .padding(.vertical, 4)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NudgerInfoView()
}
