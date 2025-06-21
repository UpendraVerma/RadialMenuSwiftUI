//
//  ContentView.swift
//  RadialMenuApp
//
//  Created by upendra verma on 21/06/25.
//

import SwiftUI

struct RadialMenuButton: Identifiable {
    let id = UUID()
    let icon: String
    let color: Color
    let action: () -> Void
}

struct ContentView: View {
    
    @State private var isExpanded = false
    
    let buttons: [RadialMenuButton] = [
        RadialMenuButton(icon: "pencil", color: .blue, action: { print("Edit") }),
        RadialMenuButton(icon: "trash", color: .red, action: { print("Delete") }),
        RadialMenuButton(icon: "photo", color: .green, action: { print("Gallery") }),
        RadialMenuButton(icon: "paperplane", color: .orange, action: { print("Send") })
        
    ]
    
    var body: some View {
        ZStack {
            // Background Blur
            if isExpanded {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
            }
            
            // Buttons
            ForEach(Array(buttons.enumerated()), id: \.0) { index, button in
                Group {
                    if isExpanded {
                        Button(action: button.action) {
                            Image(systemName: button.icon)
                                .foregroundColor(.white)
                                .padding()
                                .background(button.color)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .offset(x: getOffset(index).x, y: getOffset(index).y)
                        .transition(.scale)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: isExpanded)
                    }
                }
            }
            
            // Central FAB
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }) {
                Image(systemName: isExpanded ? "xmark" : "plus")
                    .foregroundColor(.white)
                    .padding(24)
                    .background(Color.purple)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }

        }
    }
    
    // Calculate circular position
    func getOffset(_ index: Int) -> (x: CGFloat, y: CGFloat) {
        let angle = Double(index) * (360.0 / Double(buttons.count))
        let radians = angle * .pi / 180
        let radius: CGFloat = 100
        return (x: cos(radians) * radius, y: -sin(radians) * radius)
    }
}

#Preview {
    ContentView()
}
