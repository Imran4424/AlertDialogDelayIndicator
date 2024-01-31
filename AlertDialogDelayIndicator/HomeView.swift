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
                    .frame(width: 300, height: 150)
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
    @State private var isIndicatorShowing = false
    @State private var showModal = false
    
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
                    Text("Next View")
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    Text("Go to Next View")
                        .font(.body)
                        .padding(.bottom, 16)
                    
                    Spacer()
                    
                    HStack {
                        Button("Cancel") {
                            showingCustomAlert = false
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .foregroundColor(.red)
                        
                        Button {
                            isIndicatorShowing = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showingCustomAlert = false
                                showModal.toggle()
                            }
                        } label: {
                            if isIndicatorShowing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            } else {
                                Text("OK")
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .foregroundColor(.blue)
                    }
                }
                .frame(width: 300, height: 150)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
            }
        )
        .padding()
        .sheet(isPresented: $showModal) {
            NextView()
        }
    }
}

#Preview {
    HomeView()
}
