//
//  MagazineView.m
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "MagazineView.h"
#import "DbAccessor.h"
#import "Magazine.h"
#import "MagazineImageTag.h"
#import "MagazineImageItem.h"
#import <QuartzCore/QuartzCore.h>

@interface MagazineView ()

@end


@implementation MagazineView



@synthesize next,previous,mainScroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

Magazine * magazine;
int currentIndex=-1;
int imageCount;

-(void)GetImage:(int)index
{
    imageCount=[magazine.MagazineImageList count];
    
    if(imageCount==0 || index>=imageCount||imageCount==currentIndex)
    {
        return;
    }
    currentIndex=index;

    for(UIView *subview in [mainScroll subviews]) {
        [subview removeFromSuperview];
    }
    int x=0 ;
    
    // static Initializations
   index = 10;
    for(MagazineImageItem *imageItem in [magazine MagazineImageList]) {
     
        
        UIImage*img =[[UIImage alloc] initWithContentsOfFile:imageItem.ImageItemPath];
        
        
        UIImageView *currentImage = [[UIImageView alloc] initWithImage:img];
        //[currentImage setTag:(-1 *[imageItem ImageItemId])];
        [currentImage setFrame:CGRectMake(x, 0, 1024, 719)];
        [mainScroll addSubview:currentImage];
        
        
        UIScrollView *imageDetailsLayer = [[UIScrollView alloc] init];
        [imageDetailsLayer setTag:(-[imageItem ImageItemId] *100)];
        [imageDetailsLayer setFrame:CGRectMake(x, 659, 1024, 60)];
        [imageDetailsLayer setBackgroundColor:[UIColor blackColor]];
        [imageDetailsLayer setAlpha:0];
        
        
        UILabel *imageTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 300, 50)];
        [imageTitle setBackgroundColor:[UIColor clearColor]];
        [imageTitle setTextColor:[UIColor whiteColor]];
        [imageTitle setText:imageItem.ImageItemTitle];
        imageTitle.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:[UIFont systemFontSize]];
        imageTitle.backgroundColor = [UIColor clearColor];
        imageTitle.lineBreakMode = NSLineBreakByWordWrapping;
        imageTitle.numberOfLines = 0;
        [imageTitle sizeToFit];
        [imageDetailsLayer addSubview:imageTitle];
        
        UILabel *imageDescription = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 600, 50)];
        [imageDescription setBackgroundColor:[UIColor clearColor]];
        [imageDescription setTextColor:[UIColor lightGrayColor]];
        [imageDescription setText:imageItem.ImageItemDescription];
        imageDescription.font = [UIFont systemFontOfSize:12];
        imageDescription.lineBreakMode = NSLineBreakByWordWrapping;
        imageDescription.numberOfLines = 0;
        [imageDescription sizeToFit];
        [imageDetailsLayer addSubview:imageDescription];
        
        [mainScroll addSubview:imageDetailsLayer];
        
        UIButton *imageTap = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageTap setBackgroundColor:[UIColor clearColor]];
        [imageTap setTag:[imageItem ImageItemId]*100];
        [imageTap addTarget:self action:@selector(openDescription:) forControlEvents:UIControlEventTouchUpInside];
        [imageTap setFrame:CGRectMake(x, 0, 1024, 719)];
        [mainScroll addSubview:imageTap];
       
       
 
        for(MagazineImageTag *obj in imageItem.TagList)
        {
            // Red image Tage
             UIButton *imageTag = [UIButton buttonWithType:UIButtonTypeCustom];
             [imageTag setBackgroundImage:[UIImage imageNamed:@"Tag-icon.png"] forState:UIControlStateNormal];
            [imageTag setTag:[obj ImageTagId]];
             [imageTag addTarget:self action:@selector(openTag:) forControlEvents:UIControlEventTouchUpInside];
             [imageTag setFrame:CGRectMake(currentImage.frame.origin.x + 200, 200, 24, 42)];
            
            [imagesTags addObject:[NSString stringWithFormat:@"%li",[obj ImageTagId]]];
            
            //=======> Tag Coordinates
            [imageTag setFrame:CGRectMake(currentImage.frame.origin.x + [obj XCoordinate], [obj YCoordinate], 24, 42)];
            
            [mainScroll addSubview:imageTag];
            
            
        
            // Tag Container
            UIScrollView *tagContent = [[UIScrollView alloc] initWithFrame:CGRectMake(imageTag.frame.origin.x - 50, imageTag.frame.origin.y + 50, 150, 100)];
            
             [tagContent setTag:-[obj ImageTagId]];
            
            // Tag Title
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 130, 50)];
            title.text = [obj ImageTagTitle];
            title.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:[UIFont systemFontSize]];
            title.textColor = [UIColor whiteColor];
            title.backgroundColor = [UIColor clearColor];
            title.lineBreakMode = NSLineBreakByWordWrapping;
            title.numberOfLines = 0;
            [title sizeToFit];
            [tagContent addSubview:title];
            
            UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 130, 50)];
            description.text = [obj ImageTagDescription]; // =======> tag description
            description.backgroundColor = [UIColor clearColor];
            description.textColor = [UIColor lightGrayColor];
            description.font = [UIFont systemFontOfSize:12];
            description.lineBreakMode = NSLineBreakByWordWrapping;
            description.numberOfLines = 0;
            [description sizeToFit];
            [tagContent addSubview:description];
            
            [tagContent setContentSize:CGSizeMake(0, description.bounds.size.height + 20)];
            tagContent.backgroundColor = [UIColor blackColor];
            tagContent.alpha = 0;
            [self.mainScroll addSubview:tagContent];
            
            
            index++;
        }
        x+=1024;
    }
    

    [mainScroll setContentSize:CGSizeMake(1024*imageCount, 719)];
    mainScroll.pagingEnabled = YES;
    mainScroll.bounces = NO;
    
    mainScroll.showsHorizontalScrollIndicator = NO;
    [previous setHidden:YES];

}




-(void)openTag:(id)sender 
{
    
    if(!tagPressed)
    {
        UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTagPopup:)];
        [self.view addGestureRecognizer:tab];
        
        tagInx = [sender tag];
        
        ((UIScrollView *)[self.mainScroll viewWithTag:-tagInx]).alpha = 0.8;
    }
    else
    {
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.5];
        ((UIScrollView *)[self.mainScroll viewWithTag:-tagInx]).alpha = 0;
        [UIView commitAnimations];
    }
    tagPressed =! tagPressed;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    motionManager = [[CMMotionManager alloc] init]; // and then initialize it here..
    motionManager.deviceMotionUpdateInterval = 0.3;
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                       withHandler:^(CMDeviceMotion *motion, NSError *error)
     {
         float x =motion.userAcceleration.x;
         float y = motion.userAcceleration.y;
         [UIView animateWithDuration:0.3 animations:^{
             for(int i = 0;i < imagesTags.count ; i++)
             {
                 ((UIButton *)[self.mainScroll viewWithTag:[[imagesTags objectAtIndex:i] integerValue]]).transform = CGAffineTransformMakeTranslation(-x*30, -y*30);
             }
         }];
     }
     ];
    
    imagesTags = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCloseMenu" object:nil userInfo:nil];
    
    DbAccessor * dba = [[DbAccessor alloc]init];
    magazine=   [dba GetMagazine:0];
    
    mainScroll.delegate = self;
    lastOffset = 0, rightCount = 0;
    [self GetImage:0];

}



-(void)openDescription:(id)sender
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5];
    if(!tapped)
        ((UIScrollView *)[self.mainScroll viewWithTag:-[sender tag]]).alpha = 0.8;
    else
        ((UIScrollView *)[self.mainScroll viewWithTag:-[sender tag]]).alpha = 0;
    [UIView commitAnimations];
    tapped =! tapped;
}

-(void)hideTagPopup:(UITapGestureRecognizer *)gesture;
{
    ((UIScrollView *)[self.mainScroll viewWithTag:-tagInx]).alpha = 0;
    tagPressed = FALSE;
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if(lastOffset < scrollView.contentOffset.x)
    {
        if(rightCount < imageCount-1)
        {
            rightCount++;
            [previous setHidden:NO];
            lastOffset = 1024*rightCount;
        }
        if(rightCount == imageCount-1)
            [next setHidden:YES];
    }
    else if(lastOffset > scrollView.contentOffset.x)
    {
        if(rightCount != 0 )
        {
            rightCount--;
            [next setHidden:NO];
            lastOffset = (1024 * (rightCount + 1)) - 1024;
        }
        if(rightCount == 0)
            [previous setHidden:YES];
        
    }    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)next:(id)sender {
    if(mainScroll.contentOffset.x < ((imageCount-1) * 1024) )
    {
        [mainScroll setContentOffset:CGPointMake(mainScroll.contentOffset.x + 1024, 0) animated:YES];
        [previous setHidden:NO];
    }
    if((mainScroll.contentOffset.x + 1024) == ((imageCount-1) * 1024))
        [next setHidden:YES];
}

- (IBAction)previous:(id)sender {
    if(mainScroll.contentOffset.x != 0 )
    {
        [mainScroll setContentOffset:CGPointMake(mainScroll.contentOffset.x - 1024, 0) animated:YES];
        [next setHidden:NO];
    }
    if((mainScroll.contentOffset.x - 1024)== 0)
        [previous setHidden:YES];
}
@end
