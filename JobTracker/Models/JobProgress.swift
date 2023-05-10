//
//  JobProgress.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import Foundation

enum JobProgress: Int, Codable{
  
  case rejected = 1
  case applied
  case viewed
  case accepted
  
  var name: String {
          switch self {
          case .rejected: return "Rejected"
          case .applied: return "Applied"
          case .viewed: return "Viewed"
          case .accepted: return "Accepted"
          }
      }
}


