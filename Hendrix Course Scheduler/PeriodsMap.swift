//
//  PeriodsMap.swift
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 12/7/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import Foundation
let ClassPeriodsShared = ClassPeriods()
class ClassPeriods {
    
    var DisplayStrings : Dictionary<String,String!> = [
        "A1":"MWF 8:10-9:00 am",
        "A2":"MWF 9:10-10:00 am",
        "A3":"MWF 10:10-11:00 am",
        "A4":"MWF 11:10-12:00 pm",
        "A5":"MWF 12:10-1:00 pm",
        "A6":"MWF 1:10-2:00 pm",
        "A7":"MWF 2:10-3:00 pm",
        "A8":"MWF 3:10-4:00 pm",
        "B1":"TTh 8:15-9:30 am",
        "B2":"TTh 9:45-11:00 am",
        "B3":"TTh 1:15-2:30 pm",
        "B4":"TTh 2:45-4:00 pm",
        "B5":"T 8:10-11:00 am, Th 9:45-11:00 am",
        "L1":"M 8:10-10:00 am",
        "L2":"T 8:10-11:00 am",
        "L3":"W 8:10-10:00 am",
        "L4":"Th 8:10-11:00 am",
        "L5":"F 8:10-11:00 am",
        "L6":"M 1:10-4:00 pm",
        "L7":"T 1:10-4:00 pm",
        "L8":"W 1:10-4:00 pm",
        "L9":"Th 1:10-4:00 pm",
        "L10":"F 1:10-4:00 pm",
        "S1":"M 2:10-4:00 pm",
        "S2":"W 2:10-4:00 pm",
        "S3":"F 2:10-4:00 pm",
        "D1":"MW or WF 8:10-10:00 am",
        "D2":"MW or WF 10:10-Noon",
        "D3":"MW or WF 12:10-2:00 pm",
        "D4":"MW or WF 2:10-4:00 pm",
        "D5":"TTh 9:10-11:00 am",
        "D6":"TTh 12:40-2:30 pm",
        "C1":"MWThF 8:10-9:00 am",
        "C2":"MWF 9:10-10:00 am, T 8:10-9:00 am",
        "C3":"MWF 10:10-11:00 am, Th 12:10-1:00 pm",
        "C4":"MTWF 11:10-Noon",
        "C5":"MTWF 12:10-1 pm",
        "C6":"MWF 1:10-2:00 pm, T 12:10-1:00 pm",
        "C7":"MWF 2:10-3:00 pm, T 2:40-3:30 pm",
        "C8":"MWThF 3:10-4:00 pm"
    ]
}
