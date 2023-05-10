//
//  ListView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI
import Charts

struct ListView: View {
  
  @ObservedObject var vm: JobsViewModel
  @State private var addJob = false
  @State private var searchQuery = ""
  
  
  var editingJob: Binding<Bool> {
      Binding(
          get: { selectedJob != nil },
          set: { newValue in
              if !newValue {
                selectedJob = nil
              }
          }
      )
  }
  
  @State private var selectedJob: Job?
  
  private func getStatusColor(_ status: JobProgress) -> Color{
    switch(status){
    case .applied:
      return Color(red: 28/255, green:186/255, blue:123/255)
    case .viewed:
      return Color(red: 227/255, green:167/255, blue:39/255)
    case .accepted:
      return Color(red: 0/255, green:199/255, blue:70/255)
    case .rejected:
      return Color(red: 1, green:0, blue:0)
    }
  }
  
  private var jobs: [Job] {
          if searchQuery.isEmpty {
            return vm.jobs.sorted{$0.date > $1.date }
          } else {
            return vm.jobs.filter { $0.company.contains(searchQuery) }
              .sorted{$0.date > $1.date}
          }
      }
  
    var body: some View {
        NavigationView {
          
          
          
          
            List {
              if #available(iOS 16.0, *){
                if(vm.jobs.count>0){
                  Section("Job Stats"){
                    Chart {
                      ForEach(vm.jobs) { job in
                            BarMark(
                              x: .value("Job Status", job.status.name),
                                y: .value("Total Count", 1)
                            )
                            .foregroundStyle(by: .value("Color", job.status.name))
                        }
                    }
                    .padding()
                    .chartForegroundStyleScale([
                        "Rejected": .red, "Applied": Color(red: 28/255, green:186/255, blue:123/255), "Viewed": Color(red: 227/255, green:167/255, blue:39/255), "Accepted": Color(red: 0/255, green:199/255, blue:70/255)
                    ])
                  }
                }
              }
            
                
                Section(header: Text("Jobs")) {
                  
                  ForEach(jobs, id: \.id) { job in
                    Button{
                      selectedJob = job
                    
                     
                      editingJob.wrappedValue = true
                      
                      
                      
                      
                    }label:{
                      HStack{
                          Image(systemName: "person.2")
                          .resizable()
                          .scaledToFit()
                          .frame(width: 25)
                          .padding()
                          VStack(alignment: .leading, spacing: 10) {
                            TagView(tags: job.tags)
                            Text("\(job.name) @\(job.company)")
                                  .bold()
                                  .font(.subheadline)
                                  .lineLimit(1)
                            Text("Applied \(job.date.formatted(date: .long, time: .omitted))")
                                  .font(.caption2)
                                  .foregroundColor(Color.gray)
                          
                          }
                        Spacer()
                        Text(JobProgress(rawValue: job.status.rawValue)!.name)
                          .padding(8)
                          .padding(.horizontal, 5)
                          .background(getStatusColor(job.status))
                          .cornerRadius(15)
                          .foregroundColor(.white)
                        Spacer()
                      }
                    }
                    .foregroundColor(.black)
                    }
                  
                  .onDelete(perform: removeJobs)
                }
            }
            .searchable(text: $searchQuery, prompt:"Search by company")
            .sheet(isPresented: $addJob){
              NewJobView(vm: vm, addJob: $addJob)
            }
            .sheet(isPresented: editingJob) {
              if let jobIndex = vm.jobs.firstIndex(where: { $0.id == selectedJob?.id }) {
                    JobEditView(job: $vm.jobs[jobIndex])
                }
            }
            .toolbar {
              Button {
                //add job
                addJob.toggle()
                
              } label: {
                Image(systemName:"plus")
              }
            }
            .listStyle(.grouped)
            .navigationTitle("Your Applications")
        }
        .navigationViewStyle(.stack)
    }
  
  private func removeJobs(at offsets: IndexSet) {
    vm.jobs.remove(atOffsets: offsets)
  }

    
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}

