

#import <Foundation/Foundation.h>
 
#import "Reachability.h"
#import "PropertyAdvisorEnums.h"


@interface PropertyAdvisorUtilities : NSObject {
    
}
- (NSString*) GetCurrentTime;
- (ReachabilityStatus) CheckReachability;
-(NSString*) GetDeviceId;
-(void) LogException:(NSException*) exception; 

@end
