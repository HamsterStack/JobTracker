//
//  NewJobView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI
import PhotosUI

struct NewJobView: View {
  @ObservedObject var vm: JobsViewModel
  
  
  
  @State private var name = ""
  @State private var company = ""
  @State private var applyDate = Date.now
  @State private var skills = [String]()
  @State private var skill = ""
  
  @FocusState private var skillFocused : Bool
  @FocusState private var jobTypeFocused : Bool
  @FocusState private var jobCompanyFocused : Bool
  
  @Binding var addJob : Bool
  @State private var isRejected: Bool = false
  @State var progress : JobProgress = .applied
  
  private var disableForm: Bool {
    company.isEmpty || name.isEmpty
  }

  let progressId = 1
  
  
    var body: some View {
      NavigationView{
        ScrollViewReader{ p in
          Form{
            Section(header: Text("What type of job is this?"), footer:requiredText){
              TextField("Job Type", text:$name)
                .focused($jobTypeFocused)
            }
            Section(header: Text("What company is the job for?"), footer:requiredText){
              TextField("Company", text:$company)
                .focused($jobCompanyFocused)
                
            }
            
            Section(header: Text("When did you apply?"), footer:requiredText){
              DatePicker("Date", selection: $applyDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .onChange(of: applyDate) { _ in
                    closeKeyboard()
                }
                
                
            }
            
            Section(header: Text("What stage are you on?"), footer: requiredText){
              Toggle("Were you rejected?", isOn: $isRejected)
                .tint(.red)
               
                .onChange(of: isRejected){ _ in
                  if(!isRejected){
                    p.scrollTo(progressId)
                    progress = .applied
                  }
                  else{
                    progress = .rejected
                  }
                  
                }
              if(!isRejected){
                JobProgressView(progress: $progress)
                  .id(progressId)
                  .onChange(of: progress){ _ in
                    closeKeyboard()
                  }
                
              }
              
                
            }
            
            Section(header: Text("What type of skills would you use at this job?")){
              TextField("Enter Skill", text:$skill)
                .focused($skillFocused)
              if(!skills.isEmpty){
                TagView(tags: skills)
              }
              Button("Add Skill"){
                if(!skill.isEmpty){
                  skills.append(skill)
                  skill=""
                }
              }
              .foregroundColor(.blue)
              
            }
       
           
          }
        }
        
        .toolbar{
          Button("Add"){
            //save job
            let newJob = Job(name: name, company: company, date: applyDate, tags: skills, status: progress)
            vm.addJob(job: newJob)
            addJob.toggle()
            
            
            
            
          }
          .disabled(disableForm)
        }
        .navigationTitle("Add New Job")
      
      }
      
    }
  
  let requiredText = Text("*required")
  
  private func closeKeyboard(){
    skillFocused=false
    jobTypeFocused=false
    jobCompanyFocused=false
  }
}

//struct NewJobView_Previews: PreviewProvider {
//    static var previews: some View {
//      NewJobView()
//    }
//}

