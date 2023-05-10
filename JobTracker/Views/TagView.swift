//
//  TagView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI

struct TagView: View {
    var tags: [String]
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false){
        HStack {
        ForEach(tags, id: \.self) {
            Text($0)
                .foregroundColor(.darkBlue)
                .font(.system(size: 10))
                .padding(5)
                .overlay(
                   RoundedRectangle(cornerRadius: 15)
                    .stroke(.darkBlue, lineWidth: 0.5)
               )
           }
        }
      }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
      TagView(tags: ["Test"])
    }
}

