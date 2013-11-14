//
//  NWLocationManager.h
//  where_am_i_ios
//
//  Created by Nicholas Wargnier on 11/13/13.
//  Copyright (c) 2013 Nicholas Wargnier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface NWLocationManager : NSObject < CLLocationManagerDelegate >

-(void)startLocationManager;
-(void)stopLocationManager;

@end
