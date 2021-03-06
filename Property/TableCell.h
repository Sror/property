//
//  TableCell.h
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbAccessor.h"

@interface TableCell : UITableViewCell

@property (nonatomic) int propertyId;
@property (strong, nonatomic) IBOutlet UIImageView *imageBackgroud;
@property (strong, nonatomic) IBOutlet UIImageView *topicImage;

@property (strong, nonatomic) IBOutlet UILabel *cellTextDetails;
@property (strong, nonatomic) IBOutlet UILabel *cellTopicTextHeader;
@property (strong, nonatomic) IBOutlet UILabel *followLbl;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *sq;
@property (strong, nonatomic) IBOutlet UILabel *bids;
@property (strong, nonatomic) IBOutlet UILabel *bath;
@property (strong, nonatomic) IBOutlet UILabel *share;
@property (strong, nonatomic) IBOutlet UILabel *NumberOfImages;

@property (strong, nonatomic) IBOutlet UIButton *followImage;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
- (IBAction)goFollow:(id)sender;
- (IBAction)goShare:(id)sender;
@end
