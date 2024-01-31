//
//  HomeView.swift
//  AlertDialogDelayIndicator
//
//  Created by Shah Md Imran Hossain on 31/1/24.
//

import SwiftUI

struct CustomAlert<Content: View>: View {
    @Binding var isPresented: Bool
    let content: () -> Content
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                content()
                    .frame(width: 300, height: 200)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .transition(.opacity)
        }
    }
}

struct HomeView: View {
    @State private var showingCustomAlert = false
    @State private var okButtonTapped = false
    @State private var showDialog = false
    @State private var isIndicatorShowing = false
    
    var body: some View {
        VStack {
            Text("Home View")
            Button("Show Dialog") {
                showingCustomAlert = true
            }
        }
        .padding()
        .overlay(
            CustomAlert(isPresented: $showingCustomAlert) {
                VStack {
                    Text("Alert Title")
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    Text("Alert Message")
                        .font(.body)
                        .padding(.bottom, 16)
                    
                    HStack(spacing: 20) {
                        Button("Cancel") {
                            showingCustomAlert = false
                        }
                        .foregroundColor(.red)
                        
                        Button("OK") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showingCustomAlert = false
                            }
                        }
                        .foregroundColor(.blue)
                    }
                }
                .frame(width: 300, height: 200)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
            }
        )
        .padding()
    }
}

#Preview {
    HomeView()
}
