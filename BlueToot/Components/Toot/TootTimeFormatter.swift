//
//  TootTimeFormatter.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/27/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class TootTimeFormatter: DateComponentsFormatter {
  override init() {
    super.init()

    unitsStyle = .abbreviated
    allowedUnits = [.minute, .hour, .day]
    maximumUnitCount = 1
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func string(from date: Date) -> String? {
    let timeInterval = Date().timeIntervalSince(date)
    return string(from: timeInterval)
  }
}
