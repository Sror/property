//
//  SuggestedPropertyItem.h
//  Property
//
//  Created by Osama Aziz on 11/10/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuggestedPropertyItem : NSObject
{
long  PropertyItemId;

 

 
NSString* PropertyTitle;
 

NSString* Location;
NSString* PropertyType;
NSString* SaleType;

 
NSString* ThumbNail;
 


}

@property (nonatomic) long  PropertyItemId;

 
 
@property (retain,nonatomic) NSString* PropertyTitle;
 

@property (retain,nonatomic) NSString* Location;
@property (retain,nonatomic) NSString* PropertyType;
@property (retain,nonatomic) NSString* SaleType;

 
@property (retain,nonatomic) NSString* ThumbNail;

 


@end
