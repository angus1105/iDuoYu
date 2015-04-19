//
//  LocationHelper.m
//  iDuoYu
//
//  Created by ChenAngus on 15/4/17.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "LocationHelper.h"

@implementation LocationHelper

+ (void)locateCurrentCity: (void (^)(NSDictionary *addressInfo, NSError *error))locatedCity{
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                       timeout:10.0
                          delayUntilAuthorized:YES
                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                             [LocationHelper intuLocationManagerBlock:currentLocation
                                                                            andStatus:status
                                              successGetCity:locatedCity];
                                         }];
}

+ (void)intuLocationManagerBlock:(CLLocation *)currentLocation
                       andStatus:(INTULocationStatus)status
                  successGetCity:(void (^)(NSDictionary *addressInfo, NSError *error))locatedCity {
    
    NSString *message = @"";
    
    switch (status) {
        case INTULocationStatusSuccess:
            [LocationHelper reverseGeocoderByLocation:currentLocation
                                       successGetCity:locatedCity];
            break;
            
        case INTULocationStatusServicesDenied:
            message = NSLocalizedString(@"请在系统设置->隐私->定位服务中允许使用位置服务", nil);
            break;
            
        case INTULocationStatusServicesDisabled:
            message = NSLocalizedString(@"请在系统设置->隐私->定位服务中打开定位服务", nil);
            break;
            
        default:
            message = NSLocalizedString(@"无法获取当前位置", nil);
            break;
    }
    
    if (message.length > 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"知道了", @"知道了")
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}

+ (void)reverseGeocoderByLocation:(CLLocation *)currentLocation
                   successGetCity:(void (^)(NSDictionary *addressInfo, NSError *error))locatedCity{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if(error){
                           NSLog(@"%@", [error localizedDescription]);
                       }
                       
                       CLPlacemark *placemark = [placemarks lastObject];
                       NSLog(@"placemark = %@", placemark.addressDictionary);
                       
                       for (NSString *key in [placemark.addressDictionary allKeys]) {
                           NSLog(@"\n%@ : %@",key, [placemark.addressDictionary objectForKey:key]);
                       }
                       
                       if (locatedCity) {
                           locatedCity(placemark.addressDictionary, nil);
                       }
                   }];
}

@end
