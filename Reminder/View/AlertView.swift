//
//  AlertView.swift
//  Reminder
//
//  Created by Alex Honcharuk on 10.09.2021.
//

import SwiftUI

struct AlertView: View {
    @Binding var textEntered : String
    @Binding var showingAlert : Bool
    
    @State private var _editedText : String = ""
    
    var body: some View {
        VStack(alignment: .center){
            Text("Add Category")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.top,15.0)
            
            HStack{
                TextField("Enter Text",
                          text: $_editedText,
                          onEditingChanged: { _ in },
                          onCommit: {
                            textEntered = _editedText
                            _editedText = ""
                            self.showingAlert.toggle()
                          })
                    .padding(5)
                    .background(Color(.lightGray).opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(10)
            
            Divider()
            
            HStack{
                // Cancel
                Spacer()
                Button(action: {
                    _editedText = ""
                    textEntered = ""
                    showingAlert.toggle()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Divider()
                
                // Done
                Spacer()
                Button(action: {
                    textEntered = _editedText
                    _editedText = ""
                    showingAlert.toggle()

                }, label: {
                    Text("Done")
                })
                Spacer()
            }
        }
        .frame(width: 300, height: 150)
        .background(Color.white)
        .cornerRadius(20.0)
        .shadow(radius:10.0)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(textEntered: .constant(""), showingAlert: .constant(true))
    }
}
