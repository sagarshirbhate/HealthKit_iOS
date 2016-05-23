//
//  ViewController.h
//  HealthKit Demo
//
//  Created by Sagar Shirbhate on 18/02/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthkitManager.h"
@interface ViewController : UIViewController
{
    __weak IBOutlet UIButton *workoutBtn;
    __weak IBOutlet UIButton *authorizeBtn;
    __weak IBOutlet UIButton *getDataBtn;
    __weak IBOutlet UILabel *birthdateLbl;
    __weak IBOutlet UILabel *bloodGroupLbl;
    __weak IBOutlet UILabel *skinTypeLbl;
    __weak IBOutlet UILabel *sexLbl;
    __weak IBOutlet UITextField *weightTF;
    __weak IBOutlet UIButton *submitWeightBtn;
}
- (IBAction)submitWeight:(id)sender;
- (IBAction)getData:(id)sender;
- (IBAction)authorize:(id)sender;
- (IBAction)workoutBtnClick:(id)sender;
@end

