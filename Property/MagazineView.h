//
//  MagazineView.h
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MagazineView : UIViewController<UIScrollViewDelegate >
{

    int lastOffset,rightCount,tagInx;
    BOOL tagPressed, tapped;
    double positionX, positionY, positionZ;
    NSMutableArray *imagesTags;
    CMMotionManager *motionManager;
}


@property (strong, nonatomic) IBOutlet UIButton *next;
@property (strong, nonatomic) IBOutlet UIButton *previous;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;

- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;
@end
