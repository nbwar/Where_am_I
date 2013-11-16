//
//  NWViewController.h
//  where_am_i_ios
//
//  Created by Nicholas Wargnier on 11/13/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWViewController : UIViewController <NSURLConnectionDataDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UIView *distanceView;
@property (strong, nonatomic) IBOutlet UILabel *milesLabel;
@property (strong, nonatomic) IBOutlet UILabel *drivingLabel;
@property (strong, nonatomic) IBOutlet UILabel *walkingLabel;

- (IBAction)howFarButtonPressed:(UIButton *)sender;



@end
