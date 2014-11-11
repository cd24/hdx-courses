//
//  Course.h
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 11/10/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Instructor, SubjectCode;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * building;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * days;
@property (nonatomic, retain) NSNumber * courseCode;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * catalogDescription;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * term;
@property (nonatomic, retain) NSNumber * currentEnrollment;
@property (nonatomic, retain) NSNumber * capacity;
@property (nonatomic, retain) SubjectCode *subjectCode;
@property (nonatomic, retain) Instructor *instructor;

@end
