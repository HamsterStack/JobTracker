//
//  ResumeTemplateView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI



struct ResumeHeaderView: View{
  @State var name: String
  @State var links:[String]
  //Header for the resume
  var body: some View{
    VStack(spacing: 0){
      Text(name)
        .font(.title.bold().italic())
        .padding(.top, 20)
        
      
      HStack{
        ForEach(links, id:\.self){ link in
          Text(link)
          
          Rectangle()
            .frame(width: 1, height: 10)
        }
      }
      .font(.system(size: 10))
      .padding(.horizontal, 20)
    }
  }
}


struct ResumeSkillsView: View{
  
  
  
 
  
  @State var sectionName: String
  @State var resumeSkillSections: [ResumeSkillSection]
  var body: some View{
    VStack(alignment: .leading, spacing:0){
      Text(sectionName)
        .font(.footnote.italic())
      Rectangle()
        .frame(height:1)
        .padding(.trailing, 10)
      
      ForEach(resumeSkillSections, id: \.skillName){ skill in
        HStack(spacing:0){
          Text("\(skill.skillName): ")
            .font(.caption.bold())
          HStack(spacing:0){
            ForEach(skill.items.indices, id:\.self){ index in
              Text(skill.items[index])
                
              if(index<skill.items.count-1){
                Text(", ")
              }
              
              
            }
            .font(.caption.italic())
          }
          
        }
        .padding(.leading, 10)
      }
      
      
  
      
      
      
      
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(10)
  }
}

struct ResumeEducationView: View{
  @State var sectionName: String
  @State var schoolName: String
  @State var schoolLocation:String
  @State var degreeType: String
  @State var gradDate: String
  var body: some View{
    VStack(alignment: .leading, spacing:0){
      Text(sectionName)
        .font(.footnote.italic())
      Rectangle()
        .frame(height:1)
        .padding(.trailing, 10)
      
      HStack{
        Text(schoolName)
          .font(.caption.bold())
          .padding(.leading, 10)
        Spacer()
        Text(schoolLocation)
          .padding(.trailing, 10)
        
      }
      .font(.caption)
      
      HStack{
        Text(degreeType)
          .font(.caption2)
          
        Spacer()
        Text("Expected \(gradDate)")
          .font(.caption2.italic())
          .padding(.trailing, 10)
      }
      .padding(.leading, 10)
      
      
      
      
      
      
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(10)
  }
}

struct ResumeExperienceView: View{
  @State var sectionName: String
  @State var jobs: [ResumeJob]
  var body: some View{
    VStack(alignment: .leading, spacing:0){
      Text(sectionName)
        .font(.footnote.italic())
      Rectangle()
        .frame(height:1)
        .padding(.trailing, 10)
      
      ForEach(jobs, id: \.company){job in
        HStack{
          Text(job.name)
            .font(.footnote.bold())
          Spacer()
          Text(job.date)
            .padding(.trailing, 10)
            .font(.footnote)
        }
        .padding(.leading, 10)
        
        Text(job.company)
          .font(.caption2.italic())
          .padding(.leading, 10)
        
        ForEach(job.points, id: \.self){ point in
          HStack{
            Circle()
              .frame(width: 5)
            Text(point)
            
            
            
          }
          .font(.caption2)
          .padding(.leading, 20)
          
        }
        
      }
      
      
      
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(10)
  }
}



struct ResumeProjectsView: View{
  @State var sectionName: String
  @State var projects: [ResumeProject]
  var body: some View{
    VStack(alignment: .leading, spacing:0){
      Text(sectionName)
        .font(.footnote.italic())
      Rectangle()
        .frame(height:1)
        .padding(.trailing, 10)
      
      ForEach(projects, id: \.name){ project in
        VStack(alignment: .leading,spacing: 0){
          HStack(spacing:0){
            Text("\(project.name)")
              .font(.footnote.bold())
              .padding(.trailing, 3)
            Rectangle()
              .frame(width: 1, height:10)
              .padding(.trailing, 3)
            
            
            ForEach(project.techStack.indices, id:\.self){ index in
              Text("\(project.techStack[index])")
                
              if(index<project.techStack.count-1){
                Text(", ")
              }
              
              
            }
            .font(.caption.italic())
            
            
            
          }
          .padding(.leading, 10)
          .padding(.top, 5)
          
          ForEach(project.points, id: \.self){point in
            HStack{
              Circle()
                .frame(width: 5)
              Text(point)
              
              
              
            }
            .font(.caption)
            .padding(.leading, 20)
          }
        }
      }
      
      
      
      
      
      
      
      
      
      
      
     
      
      
      
      
    }
    .frame(maxWidth: .infinity)
    .padding(10)
  }
}

struct ResumeTemplateView: View {
  let name: String
  let skills: [ResumeSkillSection]
  let education: ResumeEducation
  let projects: [ResumeProject]
  let jobs: [ResumeJob]
  let links:[String]
  
  
    var body: some View {
      
      VStack(alignment: .center, spacing:0){
        ResumeHeaderView(name: name,
                         links:links)
        
        
        ResumeSkillsView(sectionName: "SKILLS", resumeSkillSections: skills)
        
        
        
        
        
        
        ResumeEducationView(sectionName: "EDUCATION", schoolName: education.name, schoolLocation: education.schoolLocation, degreeType: education.degreeType, gradDate: education.gradDate)
        
        
        
        ResumeExperienceView(sectionName: "EXPERIENCE", jobs: jobs)
        ResumeProjectsView(sectionName: "PROJECTS", projects: projects)
        
        
        
        Spacer()
        
        
        
        
        
        
        
        
      }
      
   
   
      
    }
    
}

//struct ResumeTemplateView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResumeTemplateView()
//    }
//}

