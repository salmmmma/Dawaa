//
//  ViewController.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                HSBrandsComponentView(title: "Brands")
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Featured Products")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    ProductsListView()
                }
            }
            .padding(.top, 24)
            .padding(.bottom, 24)
        }
        .background(Color.white)
    }
}
