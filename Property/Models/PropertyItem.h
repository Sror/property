 
#import <Foundation/Foundation.h>
  
@interface PropertyItem : NSObject {
    
    int  PropertyItemId;
	    int  BedRooms;
	     int  BathRooms;
	  
	   double  PropertyPriceInEGP;
	    double  PropertyPriceInUSD;
    double  PropertyArea;

    NSString* Location;
   	 NSString* PropertyType;
   	 NSString* PropertyDescription;
   
	 
    	 NSString* PropertyCode;
   	 NSString* LineOfBusiness;
   
       	 NSString* Purpose;
       	 NSString* PropertyTitle;
    
  
  
  
    NSMutableArray * ImageList;
       
    
    
}


@property (nonatomic) int  PropertyItemId;
@property (nonatomic) int  BedRooms;
@property (nonatomic) int  BathRooms;

@property (nonatomic) double  PropertyPriceInEGP;
@property (nonatomic) double  PropertyPriceInUSD;
@property (nonatomic) double  PropertyArea;


@property (retain,nonatomic) NSString* Location;
 @property (retain,nonatomic) NSString* PropertyType;
 @property (retain,nonatomic) NSString* PropertyDescription;

 @property (retain,nonatomic) NSString* PropertyCode;
 @property (retain,nonatomic) NSString* LineOfBusiness;
 
 @property (retain,nonatomic) NSString* Purpose;
 @property (retain,nonatomic) NSString* PropertyTitle;
  @property (retain,nonatomic) NSMutableArray* ImageList;
 

@end
