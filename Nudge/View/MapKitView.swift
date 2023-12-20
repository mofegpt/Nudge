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
    @Namespace var mapScope
    var body: some View {
        NavigationView {
            ZStack {
                Map(position: $mapData.cameraPosition, bounds: MapCameraBounds(minimumDistance: 100, maximumDistance: 200), interactionModes: [.pitch, .rotate, .zoom], selection: $mapSelection){
                    UserAnnotation()
                    ForEach(mapData.NudgersArray, id: \.id) { value in
                        
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: value.Lat, longitude: value.Lon)) {
                            CustomAnnotationComp(image: value.smallImage)
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .onAppear{
                    mapData.manager.checkIfLocationServiceIsEnabled()
                }
                .mapControls {
                    MapUserLocationButton()
                }
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink {
                            ProfileView()
                        } label: {
                            ProfileButtonCompView()
                                
                        }.padding(.trailing,5)
                            .padding(.top, 60)
                    }
                    Spacer()
                    HStack {
                        Spacer()
    //                    Button {
    //                        mapData.getUserLocation()
    //                    } label: {
    //                        Text("Get")
    //                            .padding(.horizontal, 20)
    //                            .padding(.vertical,10)
    //                            .background(.white)
    //                            .cornerRadius(20)
    //                    }
                        
                        Button {
                            isNudgersSheetPresented.toggle()
                        } label: {
                            Text("Nudgers")
                                .padding(.horizontal, 20)
                                .padding(.vertical,10)
                                .background(.white)
                                .cornerRadius(20)
                        }
                        .padding()
                    }
                }
                
            }
            .sheet(isPresented: $mapData.isNudgerSheetPresented, onDismiss: {
                mapData.isNudgerSheetPresented = false
                
            }, content: {
                NudgerInfoView()
                    .presentationDetents([.medium,.large])
            })
            .sheet(isPresented: $isNudgersSheetPresented){
                NudgersListView()
                    .presentationDetents([.medium,.large])
            }
        .environmentObject(mapData)
        }
        
    }
}

#Preview {
    MapKitView()
}
