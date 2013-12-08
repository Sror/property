//
//  DetailsView.h
//  Property
//
//  Created by mohamed Alaa El-Din on 10/25/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashBoard.h"
#import "Magazine.h"
@interface DetailsView : UIViewController <UIScrollViewDelegate>
{
    int lastOffset,rightCount,imageCount;
    Magazine * magazine;
    long CurrentPropertyId;
    BOOL opened;
}
@property (weak, nonatomic) IBOutlet UILabel *propertyName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;
@property (weak, nonatomic) IBOutlet UIButton *previousOutlet;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (weak, nonatomic) IBOutlet UIButton *nextOutlet;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *activeLinkImg;
@property (weak, nonatomic) IBOutlet UIScrollView *dataContentScroll;
@property (nonatomic) long  CurrentPropertyId;
@property (weak, nonatomic) IBOutlet UIScrollView *headerScroll;
- (IBAction)propertyFacts:(id)sender;
- (IBAction)description:(id)sender;
- (IBAction)contact:(id)sender;
- (IBAction)related:(id)sender;

- (IBAction)back:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)follow:(id)sender;
- (IBAction)share:(id)sender;
@end
