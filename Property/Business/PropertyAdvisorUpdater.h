
#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"
#import "ZipArchive.h"
#import "SplashView.h"
#import "AppDelegate.h"
#import "DbAccessor.h"
#import "PropertyAdvisorStringHelper.h"

@interface PropertyAdvisorUpdater : NSObject
{
    UIViewController *viewController;
    UILabel *downloading;
    
    SplashView * CallerController;
    int serverVersion, localVersion;

    UIProgressView *theProgressView;
    
    NSString *destination;
}
@property (nonatomic, retain) UIViewController *viewController;

-(BOOL) decompressFile:(NSString*)sourceFilePath :(NSString*)destinationPath;
-(BOOL) checkForInitialUpdate:(UIViewController *) caller;

@end
