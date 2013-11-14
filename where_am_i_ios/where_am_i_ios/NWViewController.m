//
//  NWViewController.m
//  where_am_i_ios
//
//  Created by Nicholas Wargnier on 11/13/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import "NWViewController.h"
#import "NWLocationManager.h"

@interface NWViewController ()
@property (strong, nonatomic) NWLocationManager *locationManager;
@end

@implementation NWViewController

-(NWLocationManager *)locationManager
{
    if (!_locationManager) _locationManager = [[NWLocationManager alloc] init];
    return _locationManager;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)howFarButtonPressed:(UIButton *)sender
{
    [self.locationManager startLocationManager];
}
@end
