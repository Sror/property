//
//  DbAccssor.h
//  Property
//
//  Created by Osama Aziz on 10/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <sqlite3.h>
#import "MagazineImageTag.h"
#import "Magazine.h"
#import "MagazineImageItem.h"
#import "PropertyItem.h"
#import "SuggestedPropertyItem.h"
#import "FillingOptionItem.h"
#import "PropertyAdvisorEnums.h"

@interface DbAccessor : NSObject


-(Magazine *) GetMagazine:(int)categoryId;
-(int) GetContentVersion;
-(NSMutableArray*)LoadLocationList;
-(NSMutableArray*)LoadPropertyTypeList;
-(NSMutableArray*)LoadSalesTypeList;
-(NSMutableArray*)LoadPropertyList:(int)locationId :(int)propertyTypeId :(int)SalesTypeId :(int)categryId;
-(PropertyItem*)LoadProperty:(long)propertyId;

@end
