//
//  NudgersView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/17/23.
//

import SwiftUI

struct NudgersListView: View {
    @EnvironmentObject var mapData: MapUIKitViewModel
    var body: some View {
            NavigationView {
                ScrollView {
                    if let result = mapData.NearbyDetailedUsers{
                        ForEach(result.nearbyNudgers, id: \.id) { result in
                            NudgeBioCompListView(nudgerID: result.NudgerID, distance:result.Distance, firstName: result.FirstName,lastName:result.LastName, bio: result.Bio)
                                    .padding(.horizontal)
                        }
                    }else{
                        ProgressView()
                    }
                    
                    
                }
                
                .navigationTitle("Near by")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem {
                        Button {
                            mapData.getDetailedNearbyUsers()
                        } label: {
                            Text("Refresh")
                                .bold()
                                .font(.caption)
                                .padding(.horizontal)
                                .padding(.vertical,10)
                                .background(.purple)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                        }
                        .tint(.white)

                        
                    }
                }
            }
            .background(.ultraThickMaterial)
            .onAppear{
                mapData.getDetailedNearbyUsers() 
        }
        
    }
}

extension Double{
    func formatNumber() -> String {
            return String(format: "%.0f", self)
        }
}

#Preview {
    NudgersListView()
        .environmentObject(MapUIKitViewModel())
}
