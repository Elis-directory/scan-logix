//
//  SearchPage.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/16/24.
//

import SwiftUI

struct SearchPage: View {
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack() {
            Color.red
            ForEach(1..<10) { item in
                Text("Search item: \(item)")
                
            }
            .searchable(text: $searchText)
            .background(.blue)
            .padding(.bottom, 50)
         
           
          customSearchBar()
            
        }
        
        
        
       
    }
    
}

struct customSearchBar: View {
    @State private var searchText: String = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(UIColor.secondarySystemBackground))
                .frame(width: 350, height: 50)
            
            HStack {
               
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 30)
                    .foregroundStyle(.gray)
                
                TextField("Search", text: $searchText)
                Spacer()
            }
        }
    }
}

#Preview {
    SearchPage()
}
