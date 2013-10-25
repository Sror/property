#import <Foundation/Foundation.h>

@interface PropertyAdvisorUpdater : NSObject {
    
}





 -(BOOL) DoAuthorize;
 -(BOOL) DecompressFile:(NSString*)sourceFilePath:(NSString*)destinationPath;
-(NSString *)  PrepareAddProductQuery:(NSMutableArray*)inputProductList;
-(void) StartUpdateProducts;
-(void)ShowUpdatingSplash;
        
 -(BOOL) CheckForInitialUpdate:(UIViewController *) caller;






@end
