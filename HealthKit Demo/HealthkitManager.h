//
//  HealthkitManager.h
//  HealthKit Demo
//
//  Created by Sagar Shirbhate on 18/02/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HealthkitManager : NSObject

+ (HealthkitManager *)sharedManager;

- (void)requestAuthorization;
- (NSDate *)readBirthDate;
- (NSString *)readBloodType;
- (NSString *)readSexType;
- (NSString *)readSkinType;
- (void)writeWeightSample:(CGFloat)weight;
- (void)writeWorkoutDataFromModelObject:(id)workoutModelObject;

@end
