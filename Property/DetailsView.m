//
//  DetailsView.m
//  Property
//
//  Created by mohamed Alaa El-Din on 10/25/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "DetailsView.h"
#import "AppDelegate.h"
#import "MagazineImageItem.h"
#import "DbAccessor.h"
#import "EgyptView.h"
#import "PropertyManager.h"
#import "PropertyItem.h"
#import "SuggestedPropertyItem.h"
@interface DetailsView ()

@end

@implementation DetailsView
@synthesize propertyName,scrollContainer,nextOutlet,previousOutlet,imageScroll,pageControl,dataContentScroll,CurrentPropertyId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)setDetailsViewAlignment
{
    if(((AppDelegate *)[UIApplication sharedApplication].delegate).menuOpen ==1)
    {
        [self.scrollContainer setFrame:CGRectMake(1024, 0, 1024, 719)];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [self.scrollContainer setFrame:CGRectMake(48, 0, 1024, 719)];
        [UIView commitAnimations];
    }
    else
    {
        [self.scrollContainer setFrame:CGRectMake(1024, 0, 1024, 719)];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [self.scrollContainer setFrame:CGRectMake(0, 0, 1024, 719)];
        [UIView commitAnimations];
    }

}
PropertyManager * propertyManager;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(propertyFacts:) withObject:nil afterDelay:0.000001];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableCloseMenu" object:nil userInfo:nil];
    
    [self setDetailsViewAlignment];
    
     propertyManager = [[PropertyManager alloc]init];
     [propertyManager LoadSinlgleProperty:CurrentPropertyId];
    
    
    propertyName.text = propertyManager.CurrentPrperty.PropertyTitle;
    
       imageCount=[propertyManager.CurrentPrperty.ImageList count];
    if (imageCount <= 1)
        nextOutlet.hidden = YES;
    
    previousOutlet.hidden = YES;
    
    int x = 0;
    
    for(NSString  * imagepath in propertyManager.CurrentPrperty.ImageList)
    {
        UIImage*img =[[UIImage alloc] initWithContentsOfFile:imagepath];
        UIImageView *currentImage = [[UIImageView alloc] initWithImage:img];
        [currentImage setFrame:CGRectMake(x, 0, 1024, 413)];
        [imageScroll addSubview:currentImage];
        x += 1024;
    }
    
    [imageScroll setContentSize:CGSizeMake(1024*imageCount, 413)];
    imageScroll.showsHorizontalScrollIndicator = NO;
    [imageScroll setDelegate:self];
    lastOffset = 0, rightCount = 0;
    
    pageControl.numberOfPages = imageCount;
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    if(lastOffset < scrollView.contentOffset.x)
    {
        if(rightCount < imageCount-1)
        {
            rightCount++;
            [previousOutlet setHidden:NO];
            lastOffset = 1024*rightCount;
            
        }
        if(rightCount == imageCount-1)
            [nextOutlet setHidden:YES];
    }
    else if(lastOffset > scrollView.contentOffset.x)
    {
        
        if(rightCount != 0 )
        {
            rightCount--;
            [nextOutlet setHidden:NO];
            lastOffset = (1024 * (rightCount + 1)) - 1024;
        }
        if(rightCount == 0)
            [previousOutlet setHidden:YES];
        
    }
    pageControl.currentPage = rightCount;
    [scrollView setContentOffset:CGPointMake(lastOffset, 0) animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setPropertyName:nil];
    [self setScrollContainer:nil];
    [self setNextOutlet:nil];
    [self setPreviousOutlet:nil];
    [self setImageScroll:nil];
    [self setNextOutlet:nil];
    [self setPageControl:nil];
    [self setActiveLinkImg:nil];
    [self setDataContentScroll:nil];
    [super viewDidUnload];
}
- (IBAction)propertyFacts:(id)sender {
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [self.activeLinkImg setFrame:CGRectMake(0, 450, 243, 52)];
    [UIView commitAnimations];
    
    for(UIView *subview in [dataContentScroll subviews])
        [subview removeFromSuperview];
    
    
    // price , type , size 
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
    price.text = @"Price:";
    price.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    price.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:price];
    
    UILabel *priceTxt = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 50)];
    priceTxt.text =[NSString stringWithFormat:@"%.2f %@",propertyManager.CurrentPrperty.PriceFrom,propertyManager.CurrentPrperty.Currency];
    priceTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:priceTxt];
    
    UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 50)];
    type.text = @"Type:";
    type.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    type.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:type];
    
    UILabel *typeTxt = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 50)];
    typeTxt.text = propertyManager.CurrentPrperty.PropertyType;
    typeTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:typeTxt];
      
    UILabel *size = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 50)];
    size.text = @"Size:";
    size.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    size.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:size];
    
    UILabel *sizeTxt = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    sizeTxt.text = [NSString stringWithFormat:@"%.2f sqm",propertyManager.CurrentPrperty.AreaFrom];
    sizeTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:sizeTxt];
    
    
    //payment method , delivery date , for
    UILabel *paymentMethod = [[UILabel alloc] initWithFrame:CGRectMake(300, 0, 200, 50)];
    paymentMethod.text = @"Payment Method:";
    paymentMethod.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    paymentMethod.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:paymentMethod];
    
    UILabel *paymentMethodTxt = [[UILabel alloc] initWithFrame:CGRectMake(450, 0, 200, 50)];
    paymentMethodTxt.text = @"Cash";
    paymentMethodTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:paymentMethodTxt];
    
    UILabel *deliveryDate = [[UILabel alloc] initWithFrame:CGRectMake(300, 50, 200, 50)];
    deliveryDate.text = @"Delivery Date:";
    deliveryDate.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    deliveryDate.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:deliveryDate];
    
    UILabel *deliveryDateTxt = [[UILabel alloc] initWithFrame:CGRectMake(450, 50, 200, 50)];
    deliveryDateTxt.text = @"Ready to move in";
    deliveryDateTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:deliveryDateTxt];
    
    UILabel *forr = [[UILabel alloc] initWithFrame:CGRectMake(300, 100, 200, 50)];
    forr.text = @"for:";
    forr.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    forr.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:forr];
    
    UILabel *forrTxt = [[UILabel alloc] initWithFrame:CGRectMake(450, 100, 200, 50)];
    forrTxt.text = propertyManager.CurrentPrperty.SaleType;
    forrTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:forrTxt]; 
}

- (IBAction)description:(id)sender {
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [self.activeLinkImg setFrame:CGRectMake(244, 450, 243, 52)];
    [UIView commitAnimations];
    
    
    for(UIView *subview in [dataContentScroll subviews])
        [subview removeFromSuperview];
    
    
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 950, 50)];
    description.text = propertyManager.CurrentPrperty.PropertyDescription;
    description.lineBreakMode = NSLineBreakByWordWrapping;
    description.numberOfLines = 0;
    [description sizeToFit];
    description.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:description];
    
}

- (IBAction)contact:(id)sender {
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [self.activeLinkImg setFrame:CGRectMake(488, 450, 243, 52)];
    [UIView commitAnimations];
    
    
    
    for(UIView *subview in [dataContentScroll subviews])
        [subview removeFromSuperview];
    
    
    UILabel *Tel = [[UILabel alloc] initWithFrame:CGRectMake(600, 0, 200, 50)];
    Tel.text = @"Tel:";
    Tel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    Tel.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:Tel];
    
    UILabel *TelTxt = [[UILabel alloc] initWithFrame:CGRectMake(670, 0, 200, 50)];
    TelTxt.text = @"23423423";
    TelTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:TelTxt];
    
    UILabel *mobile = [[UILabel alloc] initWithFrame:CGRectMake(600, 40, 200, 50)];
    mobile.text = @"Mobile:";
    mobile.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    mobile.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:mobile];
    
    UILabel *mobileTxt = [[UILabel alloc] initWithFrame:CGRectMake(670, 40, 200, 50)];
    mobileTxt.text = @"012342434";
    mobileTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:mobileTxt];
    
    UILabel *fax = [[UILabel alloc] initWithFrame:CGRectMake(600,80 , 200, 50)];
    fax.text = @"Fax:";
    fax.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    fax.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:fax];
    
    UILabel *faxTxt = [[UILabel alloc] initWithFrame:CGRectMake(670, 80, 200, 50)];
    faxTxt.text = @"345234212";
    faxTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:faxTxt];
    
    UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(600, 120, 200, 50)];
    email.text = @"Email:";
    email.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    email.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:email];
    
    UILabel *emailTxt = [[UILabel alloc] initWithFrame:CGRectMake(670, 120, 200, 50)];
    emailTxt.text = @"info@property-advisor.net";
    emailTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:emailTxt];
    
    
    
    UILabel *Txt = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 400, 50)];
    Txt.text = @"Interested in this property ?!";
    Txt.font = [UIFont systemFontOfSize:19];
    Txt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:Txt];
    
    
    UIButton *arrangeToSeeProperty = [UIButton buttonWithType:UIButtonTypeCustom];
    arrangeToSeeProperty.frame = CGRectMake(70, 90, 180, 30);
    arrangeToSeeProperty.backgroundColor = [UIColor redColor];
        [dataContentScroll addSubview:arrangeToSeeProperty];
    
    UILabel *arrangeToSeePropertyTxt = [[UILabel alloc] initWithFrame:CGRectMake(85, 80, 200, 50)];
    arrangeToSeePropertyTxt.text = @"arrange tos see property";
    arrangeToSeePropertyTxt.font = [UIFont systemFontOfSize:13];
    arrangeToSeePropertyTxt.textColor = [UIColor whiteColor];
    arrangeToSeePropertyTxt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:arrangeToSeePropertyTxt];


}

- (IBAction)related:(id)sender {
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [self.activeLinkImg setFrame:CGRectMake(732, 450, 243, 52)];
    [UIView commitAnimations];
    
    
    for(UIView *subview in [dataContentScroll subviews])
        [subview removeFromSuperview];
    
    
    UILabel *Txt = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 400, 50)];
    Txt.text = @"You might also be intereste in..";
    Txt.font = [UIFont systemFontOfSize:16];
    Txt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:Txt];
    
    UIScrollView *relatedScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 40, 950, 200)];
    [dataContentScroll addSubview:relatedScroll];
    
    int x = 0;
     
    for(SuggestedPropertyItem *suggesteditem in propertyManager.CurrentPrperty.SuggestedPropertyList)
    {
        UIImage*img =[[UIImage alloc] initWithContentsOfFile:suggesteditem.ThumbNail];
        UIImageView *currentImage = [[UIImageView alloc] initWithImage:img];
        [currentImage setFrame:CGRectMake(x, 0, 180, 70)];
        [relatedScroll addSubview:currentImage];
        
        UILabel *Txt = [[UILabel alloc] initWithFrame:CGRectMake(x+5, 75, 180, 50)];
        Txt.text =suggesteditem.PropertyTitle;
        Txt.lineBreakMode = NSLineBreakByWordWrapping;
        Txt.numberOfLines = 0;
        [Txt sizeToFit];
        Txt.font = [UIFont systemFontOfSize:13];
        Txt.backgroundColor = [UIColor clearColor];
        [relatedScroll addSubview:Txt];
        
        x += 182;
    }
    [relatedScroll setContentSize:CGSizeMake(182*imageCount, 200)];
}

- (IBAction)back:(id)sender {
    EgyptView *egyptView = [[EgyptView alloc] init];
    egyptView.view.frame    = self.view.bounds;
    [self.view addSubview:egyptView.view];
    [self addChildViewController:egyptView];
}
- (IBAction)next:(id)sender {
    if(rightCount < imageCount-1)
    {
        rightCount++;
        [previousOutlet setHidden:NO];
        lastOffset = 1024*rightCount;
    }
    if(rightCount == imageCount-1)
        [nextOutlet setHidden:YES];
    
    pageControl.currentPage = rightCount;
    [imageScroll setContentOffset:CGPointMake(lastOffset, 0) animated:YES];
}

- (IBAction)previous:(id)sender {
    if(rightCount != 0 )
    {
        rightCount--;
        [nextOutlet setHidden:NO];
        lastOffset = (1024 * (rightCount + 1)) - 1024;
    }
    if(rightCount == 0)
        [previousOutlet setHidden:YES];
    
    pageControl.currentPage = rightCount;
    [imageScroll setContentOffset:CGPointMake(lastOffset, 0) animated:YES];
}

- (IBAction)follow:(id)sender {
}

- (IBAction)share:(id)sender {
}
@end
