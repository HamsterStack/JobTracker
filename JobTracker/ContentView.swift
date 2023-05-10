//
//  ContentView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject var vm = JobsViewModel()
  var body: some View {

    TabView {
      ListView(vm: vm)
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }
      
      if #available(iOS 16.0, *){
        ResumeView(vm: vm)
          .tabItem {
            Image(systemName: "doc.plaintext")
            Text("Resume")
          }
      }
      else{
        Text("Resume Maker not available on your iOS version yet!")
          .tabItem{
            Image(systemName: "doc.plaintext")
            Text("Resume")
          }
      }
      
      
    }
    .tint(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
