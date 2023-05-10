//
//  JobEditView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI

struct JobEditView: View {
  @Binding var job: Job
  
  var body: some View {
    NavigationView{
      VStack {
        
          
        Spacer()
        
        Text("Your role for \(job.name) @\(job.company)")
        JobProgressView(progress: $job.status)
        Toggle("Were you rejected?", isOn: Binding(
          get: { job.status == .rejected },
          set: { newValue in job.status = newValue ? .rejected : .applied }
        ))
        .tint(.red)
        Spacer()
        
      }
      .padding()
      .navigationTitle("Update Status")
    }
  }
}

//struct JobEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobEditView()
//    }
//}

