//
//  CategoryListView.swift
//  Reminder
//
//  Created by Alex Honcharuk on 10.09.2021.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject private var _manager : ReminderManager
    
    @State private var _showingAlert = false
    @State private var _showNoDelete = false
    @State private var _textEntered = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(alignment: .leading, spacing: 10){
                    List{
                        ForEach(_manager.categories, id: \.id) {category in
                            NavigationLink(destination: ItemListView(category: category)) {
                            Text(category.name)
                            }
                        }
                        .onDelete(perform: self.removeRow)
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    HStack{
                        Button(action: {
                            _showingAlert.toggle()
                        }, label: {
                            if !_showingAlert {
                                HStack{
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .center)
                                    
                                    Text("New Category")
                                }
                                .padding()
                            }
                        })
                    }
                }
                if _showingAlert{
                    AlertView(textEntered: $_textEntered, showingAlert: $_showingAlert)
                        .onDisappear {
                            if !_textEntered.isEmpty {
                                _manager.newCategoryName = _textEntered
                            }
                        }
                }
            }
            .alert(isPresented: $_showNoDelete) {
                Alert(title: Text("Delete Fail"),
                      message: Text("There are items currently attached to this category "),
                      dismissButton: .default(Text("Okay"),
                                              action: {
                                                _showNoDelete = false
                                              }))
            }
            .navigationBarTitle("Category")
        }
    }
    
    private func removeRow(at offsets: IndexSet){
        for offset in offsets {
            let category = _manager.categories[offset]
//            if _manager.canDelete(category){
//                _manager.delete(category)
//            }
//            else {
//                _showNoDelete = true
//            }
            _manager.delete(category)
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}

