//
//  UserInfoView.swift
//  Nudge
//
//  Created by Dayo Iredele on 2/21/24.
//

import SwiftUI

struct UserInfoView: View {
    @EnvironmentObject var vm: ProfileViewModel
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                
                HStack(alignment: .center){
                    Text("\(vm.currentUser?.FirstName ?? "") \n\(vm.currentUser?.LastName ?? "")")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                    
                    //   .frame(width: 300, height: 100)
                    //   .background(.blue)
                    Spacer()
                    Image(systemName: "heart.circle.fill")
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 40, height: 40)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            Task{
                                vm.signOut()
                            }
                        }
                    
                }
                .frame(height: 100)
                
                HStack(spacing: 70){
                    VStack(alignment: .leading){
                        Text("HEIGHT")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray)
                        Text("5'5 ft")
                            .fontWeight(.bold)
                    }
                    
                    VStack(alignment: .leading){
                        Text("AGE")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray)
                        Text("23")
                            .fontWeight(.bold)
                        
                    }
                    VStack(alignment: .leading){
                        Text("SIGN")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray)
                        Text("AQUARIUS")
                            .fontWeight(.bold)
                        
                    }
                    
                }
                .padding(.vertical)
                
                VStack(alignment: .leading){
                    Text("BIO")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    Text(vm.currentUser?.Bio ?? "")
                    //    .lineLimit(3)
                }
                Divider()
                
                VStack(alignment: .leading){
                    Text("BROWSE GALLERY")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    HStack{
                        Image("2")
                            .resizable()
                            .frame(width: 150, height: 210)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .aspectRatio(contentMode: .fit)
                        
                        VStack{
                            Image("1")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .aspectRatio(contentMode: .fill)
                            Image("3")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .aspectRatio(contentMode: .fit)
                            
                        }
                        
                    }
                }
                .padding(.vertical)
                
                
                
                
                //  Spacer()
            }
            //   .ignoresSafeArea()
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    UserInfoView()
}

