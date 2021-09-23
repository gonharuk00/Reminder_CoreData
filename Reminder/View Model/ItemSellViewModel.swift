//
//  ItemSellViewModel.swift
//  Reminder
//
//  Created by Alex Honcharuk on 11.09.2021.
//

import Foundation

class ItemSellViewModel : ObservableObject{
    @Published var item : Item
    
    private var _manager: ReminderManager
    
    init(manager: ReminderManager, item: Item) {
        self._manager = manager
        self.item = item
    }
    
    func saveItem(){
        _manager.saveItem()
    }
    
    func deleteItem(){
        _manager.delete(item)
    }
}
