//
//  title.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/16/24.
//

import SwiftUI
import SwiftData

struct Title: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @Query private var items: [NewEntryModel]
    
    @State var createTableSheet: Bool = false
    @State var newListItem: String = ""
    
    var body: some View {
        HStack {
            Spacer()
            Text("ScanLogix")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading, 50)
            
            Button {
                createTableSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundStyle(Color.primary.opacity(0.6))
                    .frame(alignment: .trailing)
                    .padding(.trailing, 20)
            }
            
            .sheet(isPresented: $createTableSheet, onDismiss: {
                createTableSheet = false
            })
            {
                AddItemView(item: $newListItem)
                
            }
           
        }
       
    }
}

#Preview {
    Title()
}
