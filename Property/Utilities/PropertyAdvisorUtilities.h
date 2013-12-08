

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "PropertyAdvisorEnums.h"


@interface PropertyAdvisorUtilities : NSObject

-(NSString*) getCurrentTime;
-(NSString*) getDeviceId;

-(reachabilityStatus) checkReachability;
-(void) logException:(NSException*) exception;

@end
