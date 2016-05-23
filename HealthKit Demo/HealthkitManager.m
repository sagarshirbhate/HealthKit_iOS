//
//  HealthkitManager.m
//  HealthKit Demo
//
//  Created by Sagar Shirbhate on 18/02/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "HealthkitManager.h"
#import <HealthKit/HealthKit.h>

@interface HealthkitManager ()

@property (nonatomic, retain) HKHealthStore *healthStore;

@end


@implementation HealthkitManager

+(HealthkitManager *)sharedManager {
    static dispatch_once_t pred = 0;
    static HealthkitManager *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[HealthkitManager alloc] init];
        instance.healthStore = [[HKHealthStore alloc] init];
    });
    return instance;
}

- (void)requestAuthorization {
    
    if ([HKHealthStore isHealthDataAvailable] == NO) {
        // If our device doesn't support HealthKit -> return.
        return;
    }
    
    NSArray *readTypes = @[[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType],[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierFitzpatrickSkinType]];
    
    NSArray *writeTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
                            [HKObjectType workoutType]];
    
    [self.healthStore requestAuthorizationToShareTypes:[NSSet setWithArray:writeTypes]
                                             readTypes:[NSSet setWithArray:readTypes] completion:nil];
}

- (NSDate *)readBirthDate {
    NSError *error;
    NSDate *dateOfBirth = [self.healthStore dateOfBirthWithError:&error];   // Convenience method of HKHealthStore to get date of birth directly.
    
    if (!dateOfBirth) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
    }
    
    return dateOfBirth;
}

- (NSString *)readBloodType {
    NSError *error;
    HKBloodTypeObject * obj =   [self.healthStore bloodTypeWithError:&error];   // Convenience method of HKHealthStore to get date of birth directly.
    int a =(int) obj.bloodType ;
    NSString * str =@"NA";
    switch (a) {
        case 0:
            str =@"NA";
            break;
        case 1:
            str =@"A+";
            break;
        case 2:
            str =@"A-";
            break;
        case 3:
            str =@"B+";
            break;
        case 4:
            str =@"B-";
            break;
        case 5:
            str =@"AB+";
            break;
        case 6:
            str =@"AB-";
            break;
        case 7:
            str =@"O+";
            break;
        case 8:
            str =@"O-";
            break;
            
        default:
            str =@"NA";
            break;
    }
    
    return str;
}

- (NSString *)readSexType {
    NSError *error;
    HKBiologicalSexObject * obj =   [self.healthStore biologicalSexWithError:&error];   // Convenience method of HKHealthStore to get date of birth directly.
    int a =(int) obj.biologicalSex ;
    
    NSString * str =@"NA";
    switch (a) {
        case 0:
            str =@"NA";
            break;
        case 1:
            str =@"Female";
            break;
        case 2:
            str =@"Male";
            break;
        case 3:
            str =@"Other";
            break;
        default:
            str =@"NA";
            break;
    }
    
    return str;
}

- (NSString *)readSkinType {
    NSError *error;
    HKFitzpatrickSkinTypeObject * obj =   [self.healthStore fitzpatrickSkinTypeWithError:&error];   // Convenience method of HKHealthStore to get date of birth directly.
    int a =(int) obj.skinType ;

    
    NSString * str =@"NA";
    switch (a) {
        case 0:
            str =@"NA";
            break;
        case 1:
            str =@"Type 1";
            break;
        case 2:
            str =@"Type 2";
            break;
        case 3:
            str =@"Type 3";
            break;
        default:
            str =@"Type 4";
            break;
    }
    
    return str;
}



- (void)writeWeightSample:(CGFloat)weight {
    
    // Each quantity consists of a value and a unit.
    HKUnit *kilogramUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:kilogramUnit doubleValue:weight];
    
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    NSDate *now = [NSDate date];
    
    // For every sample, we need a sample type, quantity and a date.
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Error while saving weight (%f) to Health Store: %@.", weight, error);
        }
    }];
}

- (void)writeWorkoutDataFromModelObject:(id)workoutModelObject {
    
    // In a real world app, you would pass in a model object representing your workout data, and you would pull the relevant data here and pass it to the HealthKit workout method.
    
    // For the sake of simplicity of this example, we will just set arbitrary data.
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [startDate dateByAddingTimeInterval:60 * 60 * 2];
    NSTimeInterval duration = [endDate timeIntervalSinceDate:startDate];
    CGFloat distanceInMeters = 57000.;
    
    HKQuantity *distanceQuantity = [HKQuantity quantityWithUnit:[HKUnit meterUnit] doubleValue:(double)distanceInMeters];
    
    HKWorkout *workout = [HKWorkout workoutWithActivityType:HKWorkoutActivityTypeRunning
                                                  startDate:startDate
                                                    endDate:endDate
                                                   duration:duration
                                          totalEnergyBurned:nil
                                              totalDistance:distanceQuantity
                                                   metadata:nil];
    
    [self.healthStore saveObject:workout withCompletion:^(BOOL success, NSError *error) {
        NSLog(@"Saving workout to healthStore - success: %@", success ? @"YES" : @"NO");
        if (error != nil) {
            NSLog(@"error: %@", error);
        }
    }];
}

@end
