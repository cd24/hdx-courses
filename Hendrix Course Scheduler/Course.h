//
//  Course.h
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 12/7/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Instructor, Schedule, SubjectCode;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * building;
@property (nonatomic, retain) NSNumber * capacity;
@property (nonatomic, retain) NSString * catalogDescription;
@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSNumber * currentEnrollment;
@property (nonatomic, retain) NSString * days;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * term;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * period;
@property (nonatomic, retain) Instructor *instructor;
@property (nonatomic, retain) NSSet *schedules;
@property (nonatomic, retain) SubjectCode *subjectCode;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addSchedulesObject:(Schedule *)value;
- (void)removeSchedulesObject:(Schedule *)value;
- (void)addSchedules:(NSSet *)values;
- (void)removeSchedules:(NSSet *)values;

@end
