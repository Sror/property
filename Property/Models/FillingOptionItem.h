//
//  FillingOptionItem.h
//  Property
//
//  Created by Osama Aziz on 11/10/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FillingOptionItem : NSObject
{
    int  FillingOptionItemId;
    
    NSString* FillingOptionItemName;
}


@property (retain,nonatomic) NSString* FillingOptionItemName;

@property (nonatomic) int  FillingOptionItemId;
@end
