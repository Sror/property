//
//  PropertyManager.m
//  Property
//
//  Created by Osama Aziz on 11/10/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "PropertyManager.h"

@implementation PropertyManager
@synthesize LocationList;
@synthesize  PropertyTypeList;
@synthesize   SalesTypeList;
@synthesize   PropertyList;
@synthesize   CurrentPrperty;






-(void)LoadFillingOptionLists{
    DbAccessor * dbaccessor=[[DbAccessor alloc]init];
    
    LocationList = [dbaccessor LoadLocationList];
    PropertyTypeList = [dbaccessor LoadPropertyTypeList];
    SalesTypeList = [dbaccessor LoadSalesTypeList];





}

-(void)LoadPropertyList:(int)locationId :(int)propertyTypeId :(int)SalesTypeId :(int)categryId
{


    
  
    
    
    
    DbAccessor * dbaccessor=[[DbAccessor alloc]init];

 PropertyList= [dbaccessor LoadPropertyList:locationId :propertyTypeId :SalesTypeId :categryId] ;


}
-(void)LoadSinlgleProperty:(long) propertyId{

    
    DbAccessor * dbaccessor=[[DbAccessor alloc]init];
    
    CurrentPrperty= [dbaccessor LoadProperty:propertyId] ;


}


@end
