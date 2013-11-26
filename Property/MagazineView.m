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
        [currentImage setFrame:CGRectMake(x, 0, 1024, 719)];
        [mainScroll addSubview:currentImage];
        
        for(MagazineImageTag *obj in imageItem.TagList)
        {
            // Red image Tage
             UIButton *imageTag = [UIButton buttonWithType:UIButtonTypeCustom];
             [imageTag setBackgroundImage:[UIImage imageNamed:@"Tag-icon.png"] forState:UIControlStateNormal];
          //   [imageTag setTag:index];   //
            [imageTag setTag:[obj ImageTagId]]; // =====> tag id
             [imageTag addTarget:self action:@selector(openTag:) forControlEvents:UIControlEventTouchUpInside];
             [imageTag setFrame:CGRectMake(currentImage.frame.origin.x + 200, 200, 24, 42)];
            
            //=======> Tag Coordinates
            [imageTag setFrame:CGRectMake(currentImage.frame.origin.x + [obj XCoordinate], [obj YCoordinate], 24, 42)];
            
            [mainScroll addSubview:imageTag];
            
            
        
            // Tag Container
            UIScrollView *tagContent = [[UIScrollView alloc] initWithFrame:CGRectMake(imageTag.frame.origin.x - 50, imageTag.frame.origin.y + 50, 150, 100)];
          //  [tagContent setTag:-index];
            
             [tagContent setTag:-[obj ImageTagId]]; // =====> tag id
            
            // Tag Title
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 130, 50)];
            title.text = [obj ImageTagTitle]; //=====> tag title
            title.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:[UIFont systemFontSize]];
            title.backgroundColor = [UIColor clearColor];
            title.lineBreakMode = NSLineBreakByWordWrapping;
            title.numberOfLines = 0;
            [title sizeToFit];
            [tagContent addSubview:title];
            
            UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 130, 50)];
            description.text = [obj ImageTagDescription]; // =======> tag description
            description.backgroundColor = [UIColor clearColor];
            description.font = [UIFont systemFontOfSize:12];
            description.lineBreakMode = NSLineBreakByWordWrapping;
            description.numberOfLines = 0;
            [description sizeToFit];
            [tagContent addSubview:description];
            
            [tagContent setContentSize:CGSizeMake(0, description.bounds.size.height + 20)];
            tagContent.backgroundColor = [UIColor lightGrayColor];
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
         
        CGFloat t = 8.0;
        CGAffineTransform leftQuake  = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, t);
        CGAffineTransform rightQuake = CGAffineTransformTranslate(CGAffineTransformIdentity, t, -t);
    
        ((UIButton *)[self.mainScroll viewWithTag:[sender tag]]).transform = leftQuake;  // starting point
   
        [UIView beginAnimations:@"earthquake" context:nil];
        [UIView setAnimationRepeatAutoreverses:YES]; // important
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(earthquakeEnded)];
    
        ((UIButton *)[self.mainScroll viewWithTag:[sender tag]]).transform = rightQuake; // end here & auto-reverse
        
        [UIView commitAnimations];
    }
    else
    {
        ((UIScrollView *)[self.mainScroll viewWithTag:-tagInx]).alpha = 0;
    }
    tagPressed =! tagPressed;
}

- (void)earthquakeEnded
{
    ((UIButton *)[self.mainScroll viewWithTag:tagInx]).transform = CGAffineTransformIdentity;
    ((UIScrollView *)[self.mainScroll viewWithTag:-tagInx]).alpha = 0.8;
}

- (void)viewDidLoad
{
    DbAccessor * dba = [[DbAccessor alloc]init];
    magazine=   [dba GetMagazine:0];

    
    [super viewDidLoad];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCloseMenu" object:nil userInfo:nil];
    mainScroll.delegate = self;
    lastOffset = 0, rightCount = 0;
    [self GetImage:0];
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
