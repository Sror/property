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

-(void) LogException:(NSException*) exception
{

  }




-(ReachabilityStatus) CheckReachability
{
    Reachability *reach =
    [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    ReachabilityStatus returnStatus = ReachabilityStatusOffline;
    switch(status) {
        case NotReachable:
            returnStatus =ReachabilityStatusOffline;
            break;
        case ReachableViaWiFi:
            returnStatus =ReachabilityStatusWifi;
            break;
        case ReachableViaWWAN:
            returnStatus =ReachabilityStatusMobile3G;
            break;
        default:
            returnStatus = ReachabilityStatusOffline;
            break;
    }

    
    
//    if(returnStatus==ReachabilityStatusWifi || returnStatus==ReachabilityStatusMobile3G)
//    {
//        Reachability *rserverRach =
//        [[Reachability reachabilityWithHostName:ServerCheckUrl] retain];
//        NetworkStatus serverStatus = [rserverRach currentReachabilityStatus];
//        
//        switch(serverStatus) {
//            case NotReachable:
//                returnStatus =ReachabilityStatusOffline;
//                break;
//            case ReachableViaWiFi:
//                returnStatus =ReachabilityStatusWifi;
//                break;
//            case ReachableViaWWAN:
//                returnStatus =ReachabilityStatusMobile3G;
//                break;
//            default:
//                returnStatus = ReachabilityStatusOffline;
//                break;
//        }
//
//    
//    }
      
    return returnStatus;
    
}
 

- (NSString*) GetCurrentTime
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
