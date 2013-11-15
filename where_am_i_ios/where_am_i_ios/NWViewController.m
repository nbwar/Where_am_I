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
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSURLConnection *connection;
@end

@implementation NWViewController


#pragma mark - NSURLConnection Delegate methods
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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)howFarButtonPressed:(UIButton *)sender
{
    [self.locationManager startLocationManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000/api/location.json"]];
    
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
    NSLog(@"didreceieve response");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@", [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding]);
    
    NSError *error;
    id response = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
    if (!error && [response isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = response;
        NSLog(@"dict: %@", dict);
    }
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}
@end
