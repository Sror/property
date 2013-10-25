//
//  TableCell.m
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell
@synthesize imageBackgroud,cellTextDetails,cellTopicTextHeader,followImage,topicImage,followLbl,bath,bids,sq,price,share;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [cellTextDetails sizeToFit];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goFollow:(id)sender {
    [followImage setBackgroundImage:[UIImage imageNamed:@"follow-active-icon.png"] forState:UIControlStateNormal];
    followLbl.text=@"Following";
    followLbl.textColor=[UIColor colorWithRed:0xc2/255.0f
                                        green:0x39/255.0f
                                         blue:0x29/255.0f alpha:1];
}

- (IBAction)goShare:(id)sender {
}
@end
