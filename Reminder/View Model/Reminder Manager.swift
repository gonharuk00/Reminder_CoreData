//
//  Reminder Manager.swift
//  Reminder
//
//  Created by Alex Honcharuk on 10.09.2021.
//

import SwiftUI
import CoreData

class ReminderManager: ObservableObject {
    @Published var categories = [Category]()
    @Published var items = [Item]()

    var newCategoryName: String = "" {
        didSet{
            if !newCategoryName.isEmpty{
                saveCategory(name: newCategoryName)
            }
        }
    }
    
    var category: Category? {
      didSet {
        loadItems()
      }
    }
    
    private var _context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self._context = context
        
        loadCategories()
    }
    private func save(){
        do{
            if _context.hasChanges{
                try _context.save()
            }
        }
        catch{
            print(error.localizedDescription)
            _context.rollback()
        }
        loadCategories()
    }
}

//MARK: - Category
extension ReminderManager {
    private func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try _context.fetch(request)
        }
        catch{
            print("Error loading categories \(error.localizedDescription)")
            assertionFailure()
        }
    }
    
    private func saveCategory(name: String){
        let newCategory = Category(context: _context)
        newCategory.id = UUID()
        newCategory.name = name
        
        save()
    }
    
    func delete(_ category: Category){
        _context.delete(category)
        save()
    }
    
//    func canDelete(_ category: Category) -> Bool {
//      let request: NSFetchRequest<Item> = Item.fetchRequest()
//      request.predicate = NSPredicate(format: "%K = %@", #keyPath(Item.category), category)
//      
//      do {
//        return try _context.fetch(request).count == 0
//      }
//      catch {
//        assertionFailure()
//      }
//      
//      return false
//    }
}



// MARK: - Item

extension ReminderManager {
  private func loadItems() {
    guard let category = category
    else {
      assertionFailure("Category cannot be nil")
      return
    }
    
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    request.predicate = NSPredicate(format: "%K = %@", #keyPath(Item.category), category)
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.name, ascending: true)]
    
    do {
      items = try _context.fetch(request)
    }
    catch {
      print("Error load items for \(category.name): \(error.localizedDescription)")
      assertionFailure()
    }
  }
    
    func newItem() -> Item {
        guard let category = category
        else {
            assertionFailure("Category cannot be a nil")
            return Item()
        }
        let item = Item(context: _context)
        item.id = UUID()
        item.comleted = false
        item.category = category
        
        return item
        
    }
  
  func saveItem() {
    _context.performAndWait {
      save()
    }
    
    loadItems()
  }
  
  func delete(_ item: Item) {
    _context.performAndWait {
      _context.delete(item)
      save()
    }
    
    loadItems()
  }
}
