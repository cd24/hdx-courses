//
//  PeriodsMap.swift
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 12/7/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import Foundation
let ClassPeriodsShared = ClassPeriods()
func A(calView : CalendarViewController, startTime: Int, endTime : Int, title : String){
    for i in 0..<3{
        calView.daysViews[i * 2].addEvent(startTime, halfStart: false, endTime: endTime, halfEnd: false, title: title)
    }
}
func A1(calView : CalendarViewController,title : String){
    A(calView, 8, 9,title)
}
func A2(calView : CalendarViewController,title : String){
    A(calView, 9, 10,title)
}
func A3(calView : CalendarViewController,title : String){
    A(calView, 10, 11,title)
}
func A4(calView : CalendarViewController,title : String){
    A(calView, 11, 12,title)
}
func A5(calView : CalendarViewController,title : String){
    A(calView, 12, 13,title)
}
func A6(calView : CalendarViewController,title : String){
    A(calView, 13, 14,title)
}
func A7(calView : CalendarViewController,title : String){
    A(calView, 14, 15,title)
}
func A8(calView : CalendarViewController,title : String){
    A(calView, 15, 16,title)
}
func B(calView : CalendarViewController, startTime: Int, endTime : Int, halfStart : Bool, title : String){
    for i in 0..<2{
        calView.daysViews[(i * 2) + 1].addEvent(startTime, halfStart: halfStart, endTime: endTime, halfEnd: !halfStart, title: title)
    }
}

func B1(calView : CalendarViewController, title : String){
    B(calView,8,9,false,title)
}
func B2(calView : CalendarViewController,title : String){
    B(calView, 9, 11,true,title)
}
func B3(calView : CalendarViewController,title : String){
    B(calView, 13, 14,false,title)
}
func B4(calView : CalendarViewController,title : String){
    B(calView, 14, 16,true,title)
}
func B5(calView : CalendarViewController,title : String){
    calView.daysViews[1].addEvent(8, halfStart: false, endTime: 11, halfEnd: false, title: title)
    calView.daysViews[3].addEvent(9, halfStart: true, endTime: 11, halfEnd: false, title: title)
}
func LMS(calView : CalendarViewController, day : Int, title : String){
    
    calView.daysViews[day].addEvent(8, halfStart: false, endTime: 10, halfEnd: false, title: title)
    
}
func LM(calView : CalendarViewController, day : Int, title : String){
    
    calView.daysViews[day].addEvent(8, halfStart: false, endTime: 11, halfEnd: false, title: title)
    
}
func LA(calView : CalendarViewController, day :Int, title : String){
    calView.daysViews[day].addEvent(13, halfStart: false, endTime: 16, halfEnd: false, title: title)
}
func L1(calView : CalendarViewController, title : String){
    LMS(calView,0,title)
}
func L2(calView : CalendarViewController,title : String){
    LM(calView,1,title)
}
func L3(calView : CalendarViewController,title : String){
    LMS(calView,2,title)
}
func L4(calView : CalendarViewController,title : String){
    LM(calView,3,title)
}
func L5(calView : CalendarViewController,title : String){
    LMS(calView,4,title)
}
func L6(calView : CalendarViewController, title : String){
    LA(calView,0,title)
}
func L7(calView : CalendarViewController,title : String){
    LA(calView,1,title)
}
func L8(calView : CalendarViewController,title : String){
    LA(calView,2,title)
}
func L9(calView : CalendarViewController,title : String){
    LA(calView,3,title)
}
func L10(calView : CalendarViewController,title : String){
    LA(calView,4,title)
}


func D(calView : CalendarViewController, startTime: Int, endTime : Int, halfStart : Bool, title : String){
    for i in 0..<2{
        calView.daysViews[(i * 2) + 1].addEvent(startTime, halfStart: halfStart, endTime: endTime, halfEnd: halfStart, title: title)
    }
}

func D1(calView : CalendarViewController,title : String){
    A(calView, 8, 10, title)
}
func D2(calView : CalendarViewController,title : String){
    A(calView, 10, 12, title)
}
func D3(calView : CalendarViewController,title : String){
    A(calView, 12, 14,title)
}
func D4(calView : CalendarViewController,title : String){
    A(calView, 14, 16,title)
}
func D5(calView : CalendarViewController,title : String){
    D(calView,9,11,false,title)
}
func D6(calView : CalendarViewController,title : String){
    D(calView,12,14,true,title)
}


class ClassPeriods {
    
    var FunctionMappings : Dictionary<String,((calView : CalendarViewController, title : String) -> ())> = [
        "A1":A1,
        "A2":A2,
        "A3":A3,
        "A4":A4,
        "A5":A5,
        "A6":A6,
        "A7":A7,
        "A8":A8,
        "B1":B1,
        "B2":B2,
        "B3":B3,
        "B4":B4,
        "B5":B5,
        "L1":L1,
        "L2":L2,
        "L3":L3,
        "L4":L4,
        "L5":L5,
        "L6":L6,
        "L7":L7,
        "L8":L8,
        "L9":L9,
        "L10":L10,
        "D1":D1,
        "D2":D2,
        "D3":D3,
        "D4":D4,
        "D5":D5,
        "D6":D6
    ]
    
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
