 
#import <Foundation/Foundation.h>
  
@interface PropertyItem : NSObject {
    
    long  PropertyItemId;
    
	    int  BedRoomsFrom;
	    int  BathRoomsFrom;
        int  BedRoomsTo;
        int  BathRoomsTo;
        int  NumberOfImages;
    
        double AreaFrom;
        double AreaTo;
        double PriceFrom;
        double PriceTo;
     
    	 NSString* PropertyDescription;
      	 NSString* PropertyTitle;
         NSString* PropertyReference;
    
        NSString* Location;
        NSString* PropertyType;
        NSString* SaleType;
    
     NSString* Currency;
   	    NSString* ThumbNail;
        NSMutableArray * ImageList;
      NSMutableArray * SuggestedPropertyList;
       
    
}

@property (nonatomic) long  PropertyItemId;

@property (nonatomic) int  BedRoomsFrom;
@property (nonatomic) int  BedRoomsTo;
@property (nonatomic) int  BathRoomsFrom;
@property (nonatomic) int  BathRoomsTo;
@property (nonatomic) int  NumberOfImages;

@property (nonatomic) double  AreaFrom;
@property (nonatomic) double  AreaTo;
@property (nonatomic) double  PriceFrom;
@property (nonatomic) double  PriceTo;

 @property (retain,nonatomic) NSString* PropertyTitle;
 @property (retain,nonatomic) NSString* PropertyDescription;
 @property (retain,nonatomic) NSString* PropertyReference;


@property (retain,nonatomic) NSString* Location;
 @property (retain,nonatomic) NSString* PropertyType;
 @property (retain,nonatomic) NSString* SaleType;


 @property (retain,nonatomic) NSString* Currency;
  @property (retain,nonatomic) NSString* ThumbNail;
@property (retain,nonatomic) NSMutableArray*  SuggestedPropertyList;

  @property (retain,nonatomic) NSMutableArray* ImageList;
 

@end
