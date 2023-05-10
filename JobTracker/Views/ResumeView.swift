//
//  ResumeView.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI


@available(iOS 16.0, *)
@MainActor
struct ResumeView: View {
  @ObservedObject var vm: JobsViewModel
  @State private var addResume = false
  @State private var searchQuery = ""
  
  private var resumes: [Resume] {
          if searchQuery.isEmpty {
            return vm.resumes.sorted{$0.addDate > $1.addDate }
          } else {
            return vm.resumes.filter { $0.resumeName.contains(searchQuery)}
              .sorted{$0.addDate > $1.addDate }
                
                
            
          }
      }
    var body: some View {
      NavigationView{
        List{
         
          Section("Resumes"){
            ForEach(resumes, id:\.resumeName){resume in
              
              ShareLink(item: viewToPDF(resumeName: resume.name, skills: resume.skils, education: resume.education, jobs: resume.jobs, projects: resume.projects, links:resume.links)){
                HStack{
                    Image(systemName: "doc")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
      
                        .foregroundColor(.black)
                    VStack(alignment: .leading, spacing: 10) {
                      Text("\(resume.resumeName)")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.black)
                      Text("Resume added \(resume.addDate.formatted(date: .long, time: .omitted))")
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                    }
                }
                .padding(8) //optional
              }
              
            }
            .onDelete { offsets in
              vm.resumes.remove(atOffsets: offsets)
            }
          }
        }
        .searchable(text: $searchQuery, prompt:"Search by name")
        .listStyle(.grouped)
        .sheet(isPresented: $addResume){
          NewResumeView(vm: vm, addResume: $addResume)
        }
        .navigationTitle("Your Resumes")
        .toolbar {
          Button {
            //add resume
            addResume.toggle()
            
          } label: {
            Image(systemName:"plus")
          }
          
        }
        
      }
      .navigationViewStyle(.stack)
      
      
    }
  
  private func viewToPDF(resumeName: String, skills: [ResumeSkillSection], education: ResumeEducation, jobs:[ResumeJob], projects: [ResumeProject], links:[String]) -> URL {
    /*Used https://developer.apple.com/documentation/swiftui/imagerenderer & https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-swiftui-view-to-a-pdf
     in order to read more and learn about how to render a view to a PDF with SwiftUI
     so I could create a resume PDF given a resume view.
     
     */
    
          let renderer = ImageRenderer(content:
                                        ResumeTemplateView(name: resumeName, skills: skills, education: education, projects: projects, jobs: jobs, links: links)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
          )

          let url = URL.documentsDirectory.appending(path: "resume.pdf")

          renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
              guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                  return
              }

              pdf.beginPDFPage(nil)

              context(pdf)

              pdf.endPDFPage()
              pdf.closePDF()
          }

          return url
      }
  
  
}

//@available(iOS 16.0, *)
//struct ResumeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResumeView()
//    }
//}

