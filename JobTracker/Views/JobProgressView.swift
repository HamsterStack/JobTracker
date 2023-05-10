//
//  JobProgressView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct JobProgressView: View {
  @Binding  var progress : JobProgress
    var body: some View {
      HStack{
        ForEach(JobProgress.applied.rawValue...JobProgress.accepted.rawValue, id: \.self){num in
          Line()
           .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
           .frame(height: 1)
          VStack(spacing:0){
            Button{
              withAnimation{
                
                progress = JobProgress(rawValue: num) ?? .applied
              }
            }label:{
              ZStack{
                Circle()
                  .stroke(.black, lineWidth: 2)
                  
                  
                  
                if(num<=progress.rawValue){
                  Image(systemName: "checkmark")
                    .foregroundColor(.green)
                }
              }
            }
            .padding(.top, 15)
            .transition(.scale)
            .buttonStyle(.borderless)
            
            
            
            
            //MARK: Fix text its too small
            

            Text(JobProgress(rawValue: num)!.name)
              .font(.system(size: 8))
              .padding(.top, 5)
              
            
          }
          
          
        }
                
        Line()
          .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
          .frame(height: 1)
          
      }
      
      
      
    }
}

//struct JobProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobProgressView()
//    }
//}

