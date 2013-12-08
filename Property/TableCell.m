//
//  TableCell.m
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "TableCell.h"
#import "AppDelegate.h"

@implementation TableCell
@synthesize imageBackgroud,cellTextDetails,cellTopicTextHeader,followImage,topicImage,followLbl,bath,bids,sq,price,share,NumberOfImages, propertyId,followBtn;
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
    
    [self savePropertyWithId:propertyId];
    [self addPropertyWithId:propertyId];
}


-(void)savePropertyWithId:(long)propertyIdd{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FavouritesProperties.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *downloadedIssueArray ;
    
    if (![fileManager fileExistsAtPath: path])
    {
        path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"FavouritesProperties.plist"] ];
        downloadedIssueArray = [[NSMutableArray alloc] init];
    }
    
    else
        downloadedIssueArray = [[NSMutableArray alloc] initWithContentsOfFile: path];
    
    NSDictionary *downloadIssueDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%li",propertyIdd],@"id",nil];
    [downloadedIssueArray addObject:downloadIssueDict];
    [downloadedIssueArray writeToFile:path atomically:YES];
}

-(void)addPropertyWithId:(long)propertyIdd{
    NSMutableArray *downloadedBooks = [NSMutableArray arrayWithArray:[self getArrayWithKey:@"FavouritesProperties"]];
    [downloadedBooks addObject:[NSString stringWithFormat:@"%ld",propertyIdd]];
    [self addObject:downloadedBooks withKey:@"FavouritesProperties" ifKeyNotExists:NO];
}

-(void)addObject:(id)objectValue withKey:(NSString *)objectKey ifKeyNotExists:(BOOL)keyCheck{
    
    // NSLog(@"dict=%@",objectValue);
	if ((objectKey != nil) && !keyCheck) {
		[[NSUserDefaults standardUserDefaults] setObject:objectValue forKey:objectKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
	} else if (objectKey != nil) {
		NSObject *returnObject = [[NSUserDefaults standardUserDefaults] objectForKey:objectKey];
		if (returnObject == nil) {
			[[NSUserDefaults standardUserDefaults] setObject:objectValue forKey:objectKey];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
}

- (NSArray *)getArrayWithKey:(NSString *)arrayKey{
	NSArray *userData = nil;
	
	if (arrayKey != nil) {
		NSObject *returnObject = [[NSUserDefaults standardUserDefaults] objectForKey:arrayKey];
		if ([returnObject isKindOfClass:[NSArray class]]) {
			userData = (NSArray *)returnObject;
		}
	}
	
	return userData;
}

- (IBAction)goShare:(id)sender {
}
@end
