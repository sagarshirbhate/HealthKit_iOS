//
//  ViewController.m
//  HealthKit Demo
//
//  Created by Sagar Shirbhate on 18/02/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"HelthKit Demo";
    
    workoutBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    workoutBtn.layer.shadowOffset = CGSizeMake(0, 1);
    workoutBtn.layer.shadowOpacity = 1.0;
    workoutBtn.clipsToBounds = NO;
    
    authorizeBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    authorizeBtn.layer.shadowOffset = CGSizeMake(0, 1);
    authorizeBtn.layer.shadowOpacity = 1.0;
    authorizeBtn.clipsToBounds = NO;
    
    getDataBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    getDataBtn.layer.shadowOffset = CGSizeMake(0, 1);
    getDataBtn.layer.shadowOpacity = 1.0;
    getDataBtn.clipsToBounds = NO;
    
    submitWeightBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    submitWeightBtn.layer.shadowOffset = CGSizeMake(0, 1);
    submitWeightBtn.layer.shadowOpacity = 1.0;
    submitWeightBtn.clipsToBounds = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitWeight:(id)sender {
      [[HealthkitManager sharedManager] writeWeightSample:weightTF.text.floatValue];
}

- (IBAction)getData:(id)sender {
    NSDate *birthDate = [[HealthkitManager sharedManager] readBirthDate];
    
    if (birthDate == nil) {
        // Either user didn't set the date, or an error occured. Simply return.
        return;
    }
    
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthDate
                                       toDate:[NSDate date]
                                       options:0];
    
    birthdateLbl.text =[NSString stringWithFormat:@"Age : %@ Years",[@(ageComponents.year) stringValue]];
    bloodGroupLbl.text=[NSString stringWithFormat:@"Blood Type : %@",[[HealthkitManager sharedManager] readBloodType]];
        sexLbl.text=[NSString stringWithFormat:@"Sex : %@",[[HealthkitManager sharedManager] readSexType]];
     skinTypeLbl.text=[NSString stringWithFormat:@"Skin Type  : %@",[[HealthkitManager sharedManager] readSkinType]];
    
}

- (IBAction)authorize:(UIButton *)sender {
      [[HealthkitManager sharedManager] requestAuthorization];
       [sender setTitle:@"Authorized" forState:UIControlStateNormal];
}

- (IBAction)workoutBtnClick:(id)sender {
    // In a real world app, you would obtain reference to a relevant model object and pass it to following method.
    [[HealthkitManager sharedManager] writeWorkoutDataFromModelObject:nil];
}
@end
