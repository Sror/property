//
//  MagazineImageTag.h
//  Property
//
//  Created by mohamed Alaa El-Din on 10/22/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagazineImageTag : NSObject
{
    int  XCoordinate;
	int  YCoordinate;
	int  ImageTagId;
    
    NSString* ImageTagTitle;
    NSString* ImageTagIcon;
	NSString* ImageTagDescription;
}

@property (retain,nonatomic) NSString* ImageTagTitle;
@property (retain,nonatomic) NSString* ImageTagIcon;
@property (retain,nonatomic) NSString* ImageTagDescription;

@property (nonatomic) int  XCoordinate;
@property (nonatomic) int  YCoordinate;
@property (nonatomic) int  ImageTagId;

@end
