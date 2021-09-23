//
//  ItemListView.swift
//  Reminder
//
//  Created by Alex Honcharuk on 11.09.2021.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject private var _manager: ReminderManager
    @State private var _showAddItem = false
    private var _category: Category
    
    init(category: Category) {
        self._category = category
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 10){
                List{
                    ForEach(_manager.items, id: \.id){ item in
                        ItemCell(itemCellVM: ItemSellViewModel(manager: _manager, item: item))
                    }
                    .onDelete(perform: self.removeRow)
                    
                    if _showAddItem{
                        ItemCell(itemCellVM: ItemSellViewModel(manager: _manager, item: _manager.newItem()))
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                HStack{
                    Button(action: {_showAddItem.toggle() }) {
                        if _showAddItem {
                            Button (action: {_showAddItem.toggle() }) {
                                Text("Done")
                            }
                            .padding()
                        }
                        else{
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                
                                Text("New item")
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationBarTitle(_category.name)
        .onAppear{
            _manager.category = _category
        }
    }
    
    private func removeRow(at offsets: IndexSet){
        for offset in offsets{
            let item = _manager.items[offset]
            _manager.delete(item)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(category: Category())
    }
}
