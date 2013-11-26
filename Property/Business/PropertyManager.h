//
//  PropertyManager.h
//  Property
//
//  Created by Osama Aziz on 11/10/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyItem.h"
#import "SuggestedPropertyItem.h"
#import "DbAccessor.h"

@interface PropertyManager : NSObject
{
    NSMutableArray * LocationList;
    NSMutableArray * PropertyTypeList;
    NSMutableArray * SalesTypeList;
    NSMutableArray * PropertyList;
    PropertyItem * CurrentPrperty;
}
  @property (retain,nonatomic) NSMutableArray* LocationList;
  @property (retain,nonatomic) NSMutableArray* PropertyTypeList;
  @property (retain,nonatomic) NSMutableArray* SalesTypeList;
  @property (retain,nonatomic) NSMutableArray* PropertyList;
  @property (retain,nonatomic) PropertyItem* CurrentPrperty;






-(void)LoadFillingOptionLists;
-(void)LoadPropertyList:(int)locationId :(int)propertyTypeId :(int)SalesTypeId :(int)categryId;
-(void)LoadSinlgleProperty:(long) propertyId;
 
@end
