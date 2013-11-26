//
//  MagazineView.h
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineView : UIViewController<UIScrollViewDelegate>
{

    int lastOffset,rightCount,tagInx;
    BOOL tagPressed;
}


@property (strong, nonatomic) IBOutlet UIButton *next;
@property (strong, nonatomic) IBOutlet UIButton *previous;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;

- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;
@end
