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
#import "ImageItem.h"

@interface DbAccssor : NSObject


-(Magazine *) GetMagazine:(int)categoryId :(NSString*)usedLangApprev;
-(int) GetContentVersion;

@end
