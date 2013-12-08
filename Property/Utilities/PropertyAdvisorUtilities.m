//
//  RevoUtilities.m
//  Revo
//
//  Created by svp on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PropertyAdvisorUtilities.h"
#import "PropertyAdvisorStringHelper.h"

@implementation PropertyAdvisorUtilities  

-(void) logException:(NSException*) exception
{

}

-(NSString*) getDeviceId
{
    return @"";
}

-(reachabilityStatus) checkReachability
{
    Reachability *reach  = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    reachabilityStatus returnStatus = reachabilityStatusOffline;
    switch(status)
    {
        case NotReachable:
            returnStatus = reachabilityStatusOffline;
            break;
        case ReachableViaWiFi:
            returnStatus = reachabilityStatusWifi;
            break;
        case ReachableViaWWAN:
            returnStatus = reachabilityStatusMobile3G;
            break;
        default:
            returnStatus = reachabilityStatusOffline;
            break;
    }
    return returnStatus;
}
 

- (NSString*) getCurrentTime
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormat setTimeZone:timeZone];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss S"];
    NSString *dateString = [dateFormat stringFromDate:today];
     return dateString; 
}


@end
