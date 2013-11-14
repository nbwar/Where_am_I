//
//  NWLocationManager.m
//  where_am_i_ios
//
//  Created by Nicholas Wargnier on 11/13/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import "NWLocationManager.h"

@interface NWLocationManager()

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation NWLocationManager


-(CLLocationManager *)locationManager
{
    if(!_locationManager) _locationManager = [[CLLocationManager alloc] init];
    return _locationManager;
}

-(void)startLocationManager
{
    NSLog(@"Starting Location Manager");
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10; // meters
    [self.locationManager startUpdatingLocation];
}

-(void)stopLocationManager
{
    NSLog(@"Stopping Location Manager");
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"HELLO");
    CLLocation* location = [locations lastObject];
    NSLog(@"%+.6f", location.coordinate.latitude);
    [self stopLocationManager];
}
@end
