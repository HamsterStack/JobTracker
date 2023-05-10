//
//  ViewModifiers.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI

struct Underline : ViewModifier{
  let color: Color
  let padding: CGFloat
  func body(content: Content) -> some View {
      content
        .overlay( Rectangle()
          .frame(height: 2).offset(y: padding)
          .foregroundColor(color)
                  , alignment: .bottom)
    }
    
    
}

extension View{
  func underline(color: Color, padding: CGFloat) -> some View{
        modifier(Underline(color: color, padding: padding))
    }
}


