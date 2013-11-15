//
//  NWViewController.h
//  where_am_i_ios
//
//  Created by Nicholas Wargnier on 11/13/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWViewController : UIViewController <NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITextField *locationTextField;

- (IBAction)howFarButtonPressed:(UIButton *)sender;


@end
