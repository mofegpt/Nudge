//
//  MapKitView.swift
//  Nudge
//
//  Created by Eyimofe Oladipo on 12/16/23.
//

import SwiftUI
import MapKit

struct MapKitView: View {
    @StateObject var mapData =  MapUIKitViewModel()
    @State private var isNudgersSheetPresented = false
    @State private var mapSelection: MKMapItem?
    var body: some View {
        NavigationView {
            ZStack {
                Map(position: $mapData.cameraPosition, bounds: MapCameraBounds(minimumDistance: 100, maximumDistance: 200), interactionModes: [.pitch, .rotate, .zoom], selection: $mapSelection){
                    UserAnnotation()
                    if let nearbyUsers = mapData.NearbyUsers{
                        ForEach(nearbyUsers.nearbyNudgers, id: \.id) { value in
                            Annotation("", coordinate: CLLocationCoordinate2D(latitude: value.Lat , longitude: value.Lon)) {
                                CustomAnnotationComp(selectedNudger: value)
                            }
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .onAppear{
                    mapData.manager.checkIfLocationServiceIsEnabled()
                    mapData.getNearbyUsers()
                }
                .mapControls {
                    MapUserLocationButton()
                }
                .tint(.purple)
                VStack {
                    
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack{
//                            NavigationLink {
//                                BackgroundView()
//                            } label: {
//                                NearbyNudgerCard()
//                            }
//                            NavigationLink {
//                                BackgroundView()
//                            } label: {
//                                NearbyNudgerCard()
//                            }
//                            NavigationLink {
//                                BackgroundView()
//                            } label: {
//                                NearbyNudgerCard()
//                            }
//                            
//                        }
//                    }
                    
                    
                    
                    
                    
                    
           //        Spacer()
                    HStack(alignment: .bottom) {
                        VStack {
                            NavigationLink {
                                //  ProfileView()
                                BackgroundView()
                            } label: {
                                ButtonRepComp(name: "person.fill")
                            }
                            Button {
                                //mapData.getUserLocation()
                                mapData.getNearbyUsers()
                            } label: {
                                ButtonRepComp(name: "arrow.clockwise")
                            }
                        }
                        
                        
                        Spacer()
                        
                        Button {
                            isNudgersSheetPresented.toggle()
                        } label: {
                            Text("Nudgers")
                                .foregroundStyle(.purple)
                                .padding(.horizontal, 20)
                                .padding(.vertical,10)
                                .background(.ultraThickMaterial)
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            NavigationLink {
                                BackgroundView()
                            } label: {
                                NearbyNudgerCard()
                            }
                            NavigationLink {
                                BackgroundView()
                            } label: {
                                NearbyNudgerCard()
                            }
                            NavigationLink {
                                BackgroundView()
                            } label: {
                                NearbyNudgerCard()
                            }
                            
                        }
                    }
                    
                    
                    
                }
                
                
            }
            .sheet(isPresented: $mapData.isNudgerSheetPresented, onDismiss: {
                mapData.isNudgerSheetPresented = false
            }, content: {
                // Presents view to show more info about the selected annotation
                NudgerInfoView(nudgerID: mapData.selectedNudger, distance: mapData.selectedNudgerDistance)
                    .presentationDetents([.medium,.large])
            })
            .sheet(isPresented: $isNudgersSheetPresented){
                // Presents view that list more detailed info about nearby nudgers
                NudgersListView()
                    .presentationDetents([.medium,.large])
            }
            .environmentObject(mapData)
        }
        .tint(Color.purple)
        
    }
}

#Preview {
    MapKitView()
}
