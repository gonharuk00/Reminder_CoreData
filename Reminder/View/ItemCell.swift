//
//  ItemCell.swift
//  Reminder
//
//  Created by Alex Honcharuk on 11.09.2021.
//

import SwiftUI

struct ItemCell: View {
    @ObservedObject var itemCellVM : ItemSellViewModel
    var body: some View {
        HStack{
            Image(systemName: itemCellVM.item.comleted ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(itemCellVM.item.comleted ? .red : Color(.lightGray))
                .onTapGesture {
                    itemCellVM.item.comleted.toggle()
                    itemCellVM.saveItem()
                }
            TextField("Enter Item name ",
                      text: $itemCellVM.item.name,
                      onEditingChanged: { editing in
                        if !editing,itemCellVM.item.name.isEmpty {
                            itemCellVM.deleteItem()
                        }
                      },
                      onCommit: {
                        updeted(itemCellVM.item)
                      })
        }
        .onDisappear {
            updeted(itemCellVM.item)
        }
    }
    private func updeted(_ item: Item){
        if item.name.isEmpty{
            itemCellVM.deleteItem()
        }
        else{
            itemCellVM.saveItem()
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        let manager = ReminderManager(context: PersistenceController.preview.container.viewContext)
        
        ItemCell(itemCellVM: ItemSellViewModel(manager: manager, item: manager.newItem()))
    }
}
