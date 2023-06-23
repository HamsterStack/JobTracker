//
//  NewResumeView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI
import NaturalLanguage


struct NewResumeView: View {
  @ObservedObject var vm: JobsViewModel
  
  private var disableForm: Bool {
    resumeName.isEmpty || name.isEmpty || resumeSkills.isEmpty || jobs.isEmpty || projects.isEmpty
  }
  
  
  
  @State private var resumeName = ""
  @State private var name = ""
  @State var schoolName = ""
  @State var schoolLocation = ""
  @State var degreeType = ""
  @State var gradDate = ""
  
  @State private var skill = ""
  @State private var skills = [String]()
  @State private var skillType = ""
  
  @FocusState private var skillFocused : Bool
  
  @Binding var addResume : Bool
  
  @State private var jobCompany = ""
  @State private var jobType = ""
  @State private var jobPoint = ""
  @State private var jobPoints = [String]()
  @State private var jobDate = ""
  
  @State private var projectName = ""
  @State private var projectStack = ""
  @State private var projectStacks = [String]()
  @State private var projectPoint = ""
  @State private var projectPoints = [String]()
  
  @State private var jobs = [ResumeJob]()
  @State private var projects = [ResumeProject]()
  @State private var resumeSkills = [ResumeSkillSection]()
  
  @State private var links = [String]()
  
  @State private var link = ""
  
  
  
  

  
  
    var body: some View {
      NavigationView{
        
        Form{
          

          NavigationLink("Basic Info"){
            Form{
              
              Section(header:Text("What do you wanna call the resume?"), footer:requiredText){
                TextField("Resume Name", text:$resumeName)
              }
              
              Section(header:Text("What's your name?"), footer:requiredText){
                TextField("Your Name", text:$name)
              }
              
              Section("Enter any links you want in your resume here"){
                TextField("Link", text:$link)
                Button("Add Link"){
                  if(!link.isEmpty){
                    links.append(link)
                    link = ""
                  }
                }
                .foregroundColor(.blue)
                
                if(!links.isEmpty){
                  TagView(tags: links)
                    .listRowBackground(Color.clear)
                }
              }
              
              
              
              
              
            }
            .navigationTitle("Basic Info")
          }
          
          
          NavigationLink("Skills"){
            
            Form{
             
                
              
              Section(header:Text("What's the skill type?"), footer:requiredText){
                TextField("Skill Type", text:$skillType)
              }
              Section(header:Text("What are the skills?"), footer:requiredText){
                TextField("Skill Name", text:$skill)
                  
                Button("Add"){
                  if(!skill.isEmpty){
                    skills.append(skill)
                    skill = ""
                  }
                }
                .foregroundColor(.blue)
                
                if(!skills.isEmpty){
                  TagView(tags: skills)
                    .listRowBackground(Color.clear)
                }
                  
              }
              
              Button("Add Skill"){
                //add current job
                if(!skills.isEmpty && !skillType.isEmpty){
                  let newSkill = ResumeSkillSection(items: skills, skillName: skillType)
                  resumeSkills.append(newSkill)
                  skills=[]
                  skill=""
                  skillType=""
                }
              }
              .foregroundColor(.blue)
              
              .buttonStyle(.plain)
              
              Section(header: Text("Your Skills")){
                ForEach(resumeSkills.indices, id:\.self){ index in
                  Text("\(index+1). \(resumeSkills[index].skillName)")
                }
                .onDelete(perform: deleteSkill)
              }
              
            }
            .navigationTitle("Skills")
          }
          
          NavigationLink("Education"){
            Form{
              Section(header:Text("What's your school name?"), footer:requiredText){
                TextField("School Name", text:$schoolName)
              }
              
              Section(header:Text("What's your degree type??"), footer:requiredText){
                TextField("Degree Type", text:$degreeType)
              }
              
              Section("Where is your school?"){
                TextField("School Location", text:$schoolLocation)
              }
              
              Section("When will you graduate?"){
                TextField("Graduation Date", text:$gradDate)
              }
            }
            .navigationTitle("Education")
          }
          NavigationLink("Experience"){
            Form{
              
              Section(header:Text("What was your role called?"), footer:requiredText){
                TextField("Your Role", text:$jobType)
              }
              Section(header:Text("Where did you work?"), footer:requiredText){
                TextField("Company", text:$jobCompany)
              }
              
              Section(header:Text("When did you work there?"), footer:requiredText){
                TextField("Job Date", text:$jobDate)
              }
              
              Section(header:Text("List off things you did at this job."), footer:requiredText){
                TextField("Bullet Point", text:$jobPoint)
                Button("Add Point"){
                  if(!jobPoint.isEmpty){
                    //using embeddings to find neighbors and similar words
                    let words = jobPoint.components(separatedBy: " ")
                    for word in words{
                      if let embedding = NLEmbedding.wordEmbedding(for: .english){
                        embedding.enumerateNeighbors(for: word , maximumCount: 1) { neighbor, distance in
                               print("\(neighbor): \(distance.description) for \(word)")
                               return true
                           }
                      }
                    }
                    jobPoints.append(jobPoint)
                    jobPoint = ""
                    
                  }
                }
                .foregroundColor(.blue)
                if(!jobPoints.isEmpty){
                  ForEach(jobPoints, id:\.self){ point in
                    HStack{
                      Circle()
                        .frame(width: 5, height:5)

                      Text(point)
                    }
                  }
                }
              }
              
              
              
              Section(header: Text("Your Jobs")){
                ForEach(jobs.indices, id:\.self){ index in
                  Text("\(index+1). \(jobs[index].name) @\(jobs[index].company)")
                }
                .onDelete(perform: deleteJob)
              }
              
              
              
              Button("Add Job"){
                //add current job
                if(!jobType.isEmpty && !jobCompany.isEmpty && !jobPoints.isEmpty && !jobDate.isEmpty){
                  let newJob = ResumeJob(name: jobType, company: jobCompany, points: jobPoints, date: jobDate)
                  jobs.append(newJob)
                  jobType = ""
                  jobCompany=""
                  jobDate=""
                  jobPoint=""
                  jobPoints=[]
                }
                
              }
              .foregroundColor(.blue)
              
              .buttonStyle(.plain)
              
              
              
              
              
              
            }
            .navigationTitle("Experience")
          }
          NavigationLink("Projects"){
            Form{
              
              Section(header:Text("What is the project name?"), footer:requiredText){
                TextField("Project Name", text:$projectName)
              }
              Section(header:Text("What technologies did you use?"), footer:requiredText){
                TextField("Technology", text:$projectStack)
                Button("Add Technology"){
                  if(!projectStack.isEmpty){
                    projectStacks.append(projectStack)
                    projectStack = ""
                  }
                }
                .foregroundColor(.blue)
                
                if(!projectStacks.isEmpty){
                  TagView(tags: projectStacks)
                    .listRowBackground(Color.clear)
                }
                  
              }
              
              
              
              
            
              
              Section(header:Text("List off bullet points for this project."), footer:requiredText){
                TextField("Bullet Point", text:$projectPoint)
                Button("Add Point"){
                  if(!projectPoint.isEmpty){
                    projectPoints.append(projectPoint)
                    projectPoint = ""
                  }
                }
                .foregroundColor(.blue)
                
                if(!projectPoints.isEmpty){
                  ForEach(projectPoints, id:\.self){ point in
                    HStack{
                      Circle()
                        .frame(width: 5, height:5)

                      Text(point)
                    }
                  }
                }
              }
              
              
              Section(header: Text("Your Projects")){
                ForEach(projects.indices, id:\.self){ index in
                  Text("\(index+1). \(projects[index].name)")
                }
                .onDelete(perform: deleteProject)
              }
              
              
              Button("Add Project"){
                //add current job
                if(!projectName.isEmpty && !projectStacks.isEmpty && !projectPoints.isEmpty){
                  let newProject = ResumeProject(name: projectName, techStack: projectStacks, points: projectPoints)
                  projects.append(newProject)
                  
                  projectName = ""
                  projectPoint=""
                  projectPoints=[]
                  projectStacks=[]
                  projectStack=""
                }
               
              }
              .foregroundColor(.blue)
              .buttonStyle(.plain)
              
              
              
            }
            .navigationTitle("Projects")
          }
          
         
        }
        
        .toolbar{
          Button("Add"){
            //save job
            
          
            if(isValid()){
              addResume.toggle()
              saveResume()
            }
            else{
              print("invalid")
            }
            
            
            
            
          }
          .disabled(disableForm)
        }
        .navigationTitle("New Resume")
      
      }
      
    }
  
  private func isValid() -> Bool{
    //validate resume
    
    
    if(!name.isEmpty){
      return true
    }
    return false
    
    
  }
  
  private func deleteJob(at offsets: IndexSet){
    jobs.remove(atOffsets: offsets)
  }
  
  private  func deleteProject(at offsets: IndexSet){
    projects.remove(atOffsets: offsets)
  }
  
  private func deleteSkill(at offsets: IndexSet){
    resumeSkills.remove(atOffsets: offsets)
  }
  
  private func saveResume(){
    let education = ResumeEducation(name: schoolName, degreeType: degreeType, schoolLocation: schoolLocation, gradDate: gradDate)
 
    let resume = Resume(resumeName: resumeName, name:name, jobs: jobs, skils: resumeSkills, projects: projects,education:education, addDate: Date.now, links:links)


    vm.addResume(resume: resume)
    
  }
  
  
  let requiredText = Text("*required")
  

}

//struct NewResumeView_Previews: PreviewProvider {
//    static var previews: some View {
//      NewResumeView()
//    }
//}

