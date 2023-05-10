//
//  JobsViewModel.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import Foundation

class JobsViewModel: ObservableObject {
  
  @Published var resumes = [Resume](){
    didSet{
      let encoder = JSONEncoder()
      
      if let encoded = try? encoder.encode(resumes){
        UserDefaults.standard.set(encoded, forKey:"resumes")
      }
    }
  }
  
  
  
  
  @Published var jobs = [Job]() {
    didSet{
      let encoder = JSONEncoder()
      
      if let encoded = try? encoder.encode(jobs){
        UserDefaults.standard.set(encoded, forKey:"jobs")
      }
          
    }
  }
  
  
  
  func addResume(resume: Resume){
    resumes.append(resume)
  }
  
  func addJob(job : Job){
    jobs.append(job)
  }
  
 
  
  init() {
    if let savedJobs = UserDefaults.standard.data(forKey:"jobs"){
      if let decodedJobs = try? JSONDecoder().decode([Job].self, from:savedJobs){
        jobs = decodedJobs
        
      }
    }
    else{
      jobs = []
    }
    
    if let savedResumes = UserDefaults.standard.data(forKey:"resumes"){
      if let decodedResumes = try? JSONDecoder().decode([Resume].self, from:savedResumes){
        resumes = decodedResumes
       
      }
    }
    else{
      
      resumes = []
    }
    
    
    
    
  }
}

