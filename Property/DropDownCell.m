//
//  DropDownCell.m
//  Property
//
//  Created by Mohamed Alaa El-Din on 5/1/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "DropDownCell.h"

@implementation DropDownCell
@synthesize cellText;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if(selected)
    {
        [self.cellText setTextColor:[UIColor redColor]];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
