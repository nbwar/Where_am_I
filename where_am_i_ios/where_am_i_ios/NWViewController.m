//
//  NWViewController.m
//  where_am_i_ios
//
//  Created by Nicholas Wargnier on 11/13/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import "NWViewController.h"
#import "NWLocationManager.h"

#define API_URL @"http://localhost:3000/api/location.json"

@interface NWViewController ()
@property (strong, nonatomic) NWLocationManager *locationManager;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSURLConnection *connection;
@end

@implementation NWViewController


#pragma mark - Initalizers
////////////////////////////////////////////////
////////////// Initializers ////////////////////
////////////////////////////////////////////////

-(NWLocationManager *)locationManager
{
    if (!_locationManager) _locationManager = [[NWLocationManager alloc] init];
    return _locationManager;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.locationManager startLocationManager];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
////////////////////////////////////////////////
///////////////// IBActions ////////////////////
////////////////////////////////////////////////

- (IBAction)howFarButtonPressed:(UIButton *)sender
{
    [self.locationTextField resignFirstResponder];
    
    
    if ([self.locationTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Location" message:@"You need to first enter a location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    NSString *location = self.locationTextField.text;
    
    // Post request to server
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:API_URL]];
    request.HTTPMethod = @"POST";
    NSString *data = [NSString stringWithFormat:@"latitude=%f&longitude=%f&location=%@", self.locationManager.latitude, self.locationManager.longitude, location];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = conn;


}

#pragma mark - NSURLConnection Delegate methods
////////////////////////////////////////////////
///////////// NSURLConnection //////////////////
////////////////////////////////////////////////

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSError *error;
    id response = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
    if (!error && [response isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = response;
        float distance = [dict[@"distance"] floatValue];
        
        NSMutableDictionary *drivingTime = [self calculateTime:distance mph:60];
        NSMutableDictionary *walkingTime = [self calculateTime:distance mph:3.5];
        [self updateUI:drivingTime walkingTime:walkingTime distance:distance];

        
    }
    
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}

#pragma mark - UITextField Delegate Methods
////////////////////////////////////////////////
/////////// UITextField Delegate ///////////////
////////////////////////////////////////////////

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Helper Methods
////////////////////////////////////////////////
////////////// Helper Methods //////////////////
////////////////////////////////////////////////



-(NSMutableDictionary *)calculateTime:(float)distance mph:(float)mph
{
    float time = distance / mph;
    NSMutableDictionary *drivingTime = [[NSMutableDictionary alloc] init];
    [drivingTime setObject:@(time) forKey:@"time"];

    
    if (time > 1) {
        int hours = [@(time) intValue];
        int minutes = lroundf(fmod(time, 1) * 60);
        [drivingTime setObject:@(hours) forKey:@"hours"];
        [drivingTime setObject:@(minutes) forKey:@"minutes"];

    } else {
        int minutes = lroundf(time * 60);
        [drivingTime setObject:@(minutes) forKey:@"minutes"];
    }
    
    return drivingTime;
}



-(void)updateUI:(NSMutableDictionary *)drivingTime walkingTime:(NSMutableDictionary *)walkingTime distance:(float)distance
{
    self.milesLabel.text = [NSString stringWithFormat:@"%.2f", distance];
    if ([drivingTime[@"time"] floatValue] > 1 ) {
        self.drivingLabel.text = [NSString stringWithFormat: @"%i hrs %i mins", [drivingTime[@"hours"] intValue], [drivingTime[@"minutes"] intValue]];
    } else {
        self.drivingLabel.text = [NSString stringWithFormat:@"%i mins", [drivingTime[@"minutes"] intValue]];
    }
    
    if ([walkingTime[@"time"] floatValue] > 1) {
        self.walkingLabel.text = [NSString stringWithFormat:@"%i hrs %i mins", [walkingTime[@"hours"] intValue], [walkingTime[@"minutes"] intValue]];
    } else {
        self.walkingLabel.text = [NSString stringWithFormat:@"%i mins", [walkingTime[@"minutes"] intValue]];
    }

    self.distanceView.hidden = NO;
}
@end
