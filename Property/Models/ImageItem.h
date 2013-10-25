 
#import <Foundation/Foundation.h>
 


@interface ImageItem : NSObject {
    
    int  ImageItemId;
	    int  ImageItemOrder;

		 NSString* CategoryList;
     NSString* ImageItemDescription;
       NSString* ImageItemTitle;
	NSString* ImageItemPath;


    NSMutableArray * TagList;
       
    
    
}
 @property (retain,nonatomic) NSString* CategoryList;
 @property (retain,nonatomic) NSString* ImageItemDescription;
 @property (retain,nonatomic) NSString* ImageItemTitle;
 @property (retain,nonatomic) NSString* ImageItemPath;

@property (nonatomic) int  ImageItemId;
@property (nonatomic) int  ImageItemOrder;

 @property (retain,nonatomic) NSMutableArray* TagList;
 

@end
