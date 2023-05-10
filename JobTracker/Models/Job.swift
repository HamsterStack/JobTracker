//
//  Job.swift
//  JobTracker
//
//  Created by Tom Miller on 10/05/2023.
//

import SwiftUI

struct Job :Hashable, Codable, Identifiable{
  let name: String
  let company: String
  var date: Date
  var tags: [String]
  var status: JobProgress
  var id = UUID()
}
