#import <Foundation/Foundation.h>

@interface PropertyAdvisorUpdater : NSObject {
    UIViewController *viewController;
}


@property (nonatomic, retain) UIViewController *viewController;


 -(BOOL) DoAuthorize;
 -(BOOL) DecompressFile:(NSString*)sourceFilePath:(NSString*)destinationPath;
-(NSString *)  PrepareAddProductQuery:(NSMutableArray*)inputProductList;
-(void) StartUpdateProducts;
-(void)ShowUpdatingSplash;
        
 -(BOOL) CheckForInitialUpdate:(UIViewController *) caller;






@end
