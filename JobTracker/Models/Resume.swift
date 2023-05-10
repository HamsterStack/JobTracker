//
//  Resume.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import Foundation

struct ResumeProject:Codable{
  var name: String
  var techStack: [String]
  var points :[String]
}

struct ResumeSkillSection:Codable{
  var items: [String]
  var skillName: String
}

struct ResumeJob:Codable, Hashable{
  var name:String
  var company:String
  var points:[String]
  var date:String
}

struct ResumeEducation:Codable{
  var name: String
  var degreeType: String
  var schoolLocation: String
  var gradDate: String
}

struct Resume: Codable,Identifiable{
  var id = UUID()
  
  var resumeName: String
  var name:String
  var jobs: [ResumeJob]
  var skils: [ResumeSkillSection]
  var projects: [ResumeProject]
  var education: ResumeEducation
  var addDate: Date
  var links:[String]
 
  
}


