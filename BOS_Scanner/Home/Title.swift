//  Title.swift
//  BOS_Scanner
//
//  This file contains the Title view used in the Scanner app.
//  It displays the app's main title and provides a button for creating new entries in the database.
//
//  Created by EC.

import SwiftUI
import SwiftData

struct Title: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @Query private var items: [NewEntryModel]
    @State private var scannedUPC: String? = nil
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
                AddItemView(item: $newListItem, upc: scannedUPC ?? "") 
            }
           
        }
       
    }
}

#Preview {
    Title()
}
