//
//  RoomView.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 20.12.2023.
//

import SwiftUI

struct RoomView: View {
    @StateObject var vm: RoomViewModel
    @EnvironmentObject var coordinator: Coordinator<HotelRouter>
    init(hotel: HotelModel) {
        self._vm = StateObject(wrappedValue: RoomViewModel(hotel: hotel))
    }
    
    var body: some View {
        MainTemplate(title: vm.hotel.name, showButton: true) {
            coordinator.pop()
        } content: {
            ScrollView {
                VStack {
                    if let rooms = vm.room?.rooms {
                        ForEach(rooms, id: \.id) { room in
                            RoomCell(vm: vm, coordinator: coordinator, model: room)
                        }
                    }
                    HStack{Spacer()}
                }
                .padding(.vertical, 8)
            }
            .setBackground()
            .onFirstAppear {
                vm.getRooms()
            }
        }
    }
}
