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
@synthesize propertyName,scrollContainer,nextOutlet,previousOutlet,imageScroll,pageControl,dataContentScroll,CurrentPropertyId,headerScroll;
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


-(void)openImageDetails
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5];
    if(!opened)
    {
        ((UIScrollView *)[self.view viewWithTag:100]).alpha = 0.8;
        ((UIScrollView *)[self.view viewWithTag:200]).alpha = 0.8;
    }
    else
    {
         ((UIScrollView *)[self.view viewWithTag:100]).alpha = 0;
        ((UIScrollView *)[self.view viewWithTag:200]).alpha = 0;
    }
    [UIView commitAnimations];
    opened =! opened;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    UIButton *imageTap = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageTap setBackgroundColor:[UIColor clearColor]];
    [imageTap addTarget:self action:@selector(openImageDetails) forControlEvents:UIControlEventTouchUpInside];
    [imageTap setFrame:CGRectMake(0, 0, 1024, 719)];
    [imageScroll addSubview:imageTap];

    
    imageScroll.pagingEnabled = YES;
    imageScroll.bounces = NO;
    headerScroll.backgroundColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableCloseMenu" object:nil userInfo:nil];
    
    [self setDetailsViewAlignment];
    
     propertyManager = [[PropertyManager alloc]init];
     [propertyManager LoadSinlgleProperty:CurrentPropertyId];
    
    [self related];
    [self contactAndFacts];
    
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
        [currentImage setFrame:CGRectMake(x, 0, 1024, 719)];
        [imageScroll addSubview:currentImage];
        x += 1024;
    }
    
    [imageScroll setContentSize:CGSizeMake(1024*imageCount, 719)];
    [imageTap setFrame:CGRectMake(0, 0, 1024*imageCount, 719)];
    imageScroll.showsHorizontalScrollIndicator = NO;
    [imageScroll setDelegate:self];
    lastOffset = 0, rightCount = 0;
    
    pageControl.numberOfPages = imageCount;
    [self loadDescription];
    
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

-(void) loadDescription
{
    UIScrollView *imageDetailsLayer = [[UIScrollView alloc] init];
    [imageDetailsLayer setFrame:CGRectMake(0, 639, 1024, 80)];
    [imageDetailsLayer setBackgroundColor:[UIColor blackColor]];
    [imageDetailsLayer setAlpha:0.5];
    
    
    UILabel *imageTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 600, 50)];
    [imageTitle setBackgroundColor:[UIColor clearColor]];
    [imageTitle setTextColor:[UIColor whiteColor]];
    [imageTitle setText:propertyManager.CurrentPrperty.PropertyTitle];
    imageTitle.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:[UIFont systemFontSize]];
    imageTitle.backgroundColor = [UIColor clearColor];
    imageTitle.lineBreakMode = NSLineBreakByWordWrapping;
    imageTitle.numberOfLines = 0;
    [imageTitle sizeToFit];
    [imageDetailsLayer addSubview:imageTitle];
    
    UILabel *imageDescription = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 900, 50)];
    [imageDescription setBackgroundColor:[UIColor clearColor]];
    [imageDescription setTextColor:[UIColor lightGrayColor]];
    [imageDescription setText:propertyManager.CurrentPrperty.PropertyDescription];
    imageDescription.font = [UIFont systemFontOfSize:12];
    imageDescription.lineBreakMode = NSLineBreakByWordWrapping;
    imageDescription.numberOfLines = 0;
    [imageDescription sizeToFit];
    [imageDetailsLayer addSubview:imageDescription];
    
    [self.view addSubview:imageDetailsLayer];
}


- (void)contactAndFacts
{
    UIScrollView *imageDetailsLayer = [[UIScrollView alloc] init];
    [imageDetailsLayer setTag:200];
    [imageDetailsLayer setFrame:CGRectMake(0, 39, self.view.frame.size.width, 80)];
    [imageDetailsLayer setBackgroundColor:[UIColor blackColor]];
    [imageDetailsLayer setAlpha:0];
    
    
    UILabel *imageTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 60, 50)];
    [imageTitle setBackgroundColor:[UIColor clearColor]];
    [imageTitle setTextColor:[UIColor whiteColor]];
    [imageTitle setText:@"Contacts"];
    imageTitle.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:[UIFont systemFontSize]];
    imageTitle.backgroundColor = [UIColor clearColor];
    imageTitle.lineBreakMode = NSLineBreakByWordWrapping;
    imageTitle.numberOfLines = 0;
    [imageTitle sizeToFit];
    [imageDetailsLayer addSubview:imageTitle];
    
    
    
    UILabel *Tel = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 200, 50)];
    [Tel setTextColor:[UIColor whiteColor]];
    Tel.text = @"Tel:";
    Tel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    Tel.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:Tel];
    
    UILabel *TelTxt = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 200, 50)];
    [TelTxt setTextColor:[UIColor lightGrayColor]];
    [TelTxt setFont:[UIFont systemFontOfSize:12]];
    TelTxt.text = @"23423423";
    TelTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:TelTxt];
    
    UILabel *mobile = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 200, 50)];
    [mobile setTextColor:[UIColor whiteColor]];
    mobile.text = @"Mobile:";
    mobile.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    mobile.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:mobile];
    
    UILabel *mobileTxt = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 200, 50)];
    [mobileTxt setTextColor:[UIColor lightGrayColor]];
    [mobileTxt setFont:[UIFont systemFontOfSize:12]];
    mobileTxt.text = @"012342434";
    mobileTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:mobileTxt];
    
    UILabel *fax = [[UILabel alloc] initWithFrame:CGRectMake(350,0 , 200, 50)];
    [fax setTextColor:[UIColor whiteColor]];
    fax.text = @"Fax:";
    fax.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    fax.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:fax];
    
    UILabel *faxTxt = [[UILabel alloc] initWithFrame:CGRectMake(380, 0, 200, 50)];
    [faxTxt setTextColor:[UIColor lightGrayColor]];
    [faxTxt setFont:[UIFont systemFontOfSize:12]];
    faxTxt.text = @"345234212";
    faxTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:faxTxt];
    
    UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(450, 0, 200, 50)];
    [email setTextColor:[UIColor whiteColor]];
    email.text = @"Email:";
    email.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    email.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:email];
    
    UILabel *emailTxt = [[UILabel alloc] initWithFrame:CGRectMake(490, 0, 200, 50)];
    [emailTxt setTextColor:[UIColor lightGrayColor]];;
    [emailTxt setFont:[UIFont systemFontOfSize:12]];
    emailTxt.text = @"info@property-advisor.net";
    emailTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:emailTxt];
    
    
    
    /*UILabel *Txt = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 400, 50)];
    [Tel setTextColor:[UIColor lightGrayColor]];
    Txt.text = @"Interested in this property ?!";
    Txt.font = [UIFont systemFontOfSize:19];
    Txt.backgroundColor = [UIColor clearColor];
    [dataContentScroll addSubview:Txt];*/
    
    
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
    
    
    
    
    //Facts
    
    UILabel *imageTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, 60, 50)];
    [imageTitle2 setBackgroundColor:[UIColor clearColor]];
    [imageTitle2 setTextColor:[UIColor whiteColor]];
    [imageTitle2 setText:@"Facts"];
    imageTitle2.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:[UIFont systemFontSize]];
    imageTitle2.backgroundColor = [UIColor clearColor];
    imageTitle2.lineBreakMode = NSLineBreakByWordWrapping;
    imageTitle2.numberOfLines = 0;
    [imageTitle2 sizeToFit];
    [imageDetailsLayer addSubview:imageTitle2];
    
    
    // price , type , size
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(110, 40, 200, 50)];
    price.text = @"Price:";
    [price setTextColor:[UIColor whiteColor]];
    price.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    price.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:price];
    
    UILabel *priceTxt = [[UILabel alloc] initWithFrame:CGRectMake(150, 40, 200, 50)];
    [priceTxt setTextColor:[UIColor lightGrayColor]];
    priceTxt.font = [UIFont systemFontOfSize:12];
    priceTxt.text =[NSString stringWithFormat:@"%.2f %@",propertyManager.CurrentPrperty.PriceFrom,propertyManager.CurrentPrperty.Currency];
    priceTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:priceTxt];
    
    UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(250, 40, 200, 50)];
    [type setTextColor:[UIColor whiteColor]];
    type.text = @"Type:";
    type.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    type.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:type];
    
    UILabel *typeTxt = [[UILabel alloc] initWithFrame:CGRectMake(285, 40, 200, 50)];
    [typeTxt setTextColor:[UIColor lightGrayColor]];
    typeTxt.font = [UIFont systemFontOfSize:12];
    typeTxt.text = propertyManager.CurrentPrperty.PropertyType;
    typeTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:typeTxt];
    
    UILabel *size = [[UILabel alloc] initWithFrame:CGRectMake(340, 40, 200, 50)];
    [size setTextColor:[UIColor whiteColor]];
    size.text = @"Size:";
    size.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    size.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:size];
    
    UILabel *sizeTxt = [[UILabel alloc] initWithFrame:CGRectMake(370, 40, 200, 50)];
    sizeTxt.font = [UIFont systemFontOfSize:12];
    [sizeTxt setTextColor:[UIColor lightGrayColor]];
    sizeTxt.text = [NSString stringWithFormat:@"%.2f sqm",propertyManager.CurrentPrperty.AreaFrom];
    sizeTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:sizeTxt];
    
    
    //payment method , delivery date , for
    UILabel *paymentMethod = [[UILabel alloc] initWithFrame:CGRectMake(450, 40, 200, 50)];
    [paymentMethod setTextColor:[UIColor whiteColor]];
    paymentMethod.text = @"Payment Method:";
    paymentMethod.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    paymentMethod.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:paymentMethod];
    
    UILabel *paymentMethodTxt = [[UILabel alloc] initWithFrame:CGRectMake(555, 40, 200, 50)];
    paymentMethodTxt.font = [UIFont systemFontOfSize:12];
    [paymentMethodTxt setTextColor:[UIColor lightGrayColor]];
    paymentMethodTxt.text = @"Cash";
    paymentMethodTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:paymentMethodTxt];
    
    UILabel *deliveryDate = [[UILabel alloc] initWithFrame:CGRectMake(600, 40, 200, 50)];
    [deliveryDate setTextColor:[UIColor whiteColor]];
    deliveryDate.text = @"Delivery Date:";
    deliveryDate.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    deliveryDate.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:deliveryDate];
    
    UILabel *deliveryDateTxt = [[UILabel alloc] initWithFrame:CGRectMake(685, 40, 200, 50)];
    deliveryDateTxt.font = [UIFont systemFontOfSize:12];
    [deliveryDateTxt setTextColor:[UIColor lightGrayColor]];
    deliveryDateTxt.text = @"Ready to move in";
    deliveryDateTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:deliveryDateTxt];
    
    UILabel *forr = [[UILabel alloc] initWithFrame:CGRectMake(800, 40, 200, 50)];
    [forr setTextColor:[UIColor whiteColor]];
    forr.text = @"for:";
    forr.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    forr.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:forr];
    
    UILabel *forrTxt = [[UILabel alloc] initWithFrame:CGRectMake(830, 40, 200, 50)];
    forrTxt.font = [UIFont systemFontOfSize:12];
    [forrTxt setTextColor:[UIColor lightGrayColor]];
    forrTxt.text = propertyManager.CurrentPrperty.SaleType;
    forrTxt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:forrTxt];
    
    [self.view addSubview:imageDetailsLayer];


}

- (void)related
{
    UIScrollView *imageDetailsLayer = [[UIScrollView alloc] init];
    [imageDetailsLayer setTag:100];
    [imageDetailsLayer setFrame:CGRectMake(self.view.frame.size.width - 150, 119, 150, 520)];
    [imageDetailsLayer setBackgroundColor:[UIColor blackColor]];
    [imageDetailsLayer setAlpha:0];
    
    
    UILabel *Txt = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
    Txt.text = @"Related";
    Txt.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:18];
    Txt.textColor = [UIColor whiteColor];
    Txt.backgroundColor = [UIColor clearColor];
    [imageDetailsLayer addSubview:Txt];
    
    
    
    int y = 50;
     
    for(SuggestedPropertyItem *suggesteditem in propertyManager.CurrentPrperty.SuggestedPropertyList)
    {
        UIImage*img =[[UIImage alloc] initWithContentsOfFile:suggesteditem.ThumbNail];
        UIImageView *currentImage = [[UIImageView alloc] initWithImage:img];
        [currentImage setFrame:CGRectMake(0, y, 150, 100)];
        [imageDetailsLayer addSubview:currentImage];
        
        UILabel *Txt = [[UILabel alloc] initWithFrame:CGRectMake(10, y+102, 130, 60)];
        Txt.text = suggesteditem.PropertyTitle;
        Txt.textColor = [UIColor whiteColor];
        Txt.lineBreakMode = NSLineBreakByWordWrapping;
        Txt.numberOfLines = 0;
        [Txt sizeToFit];
        Txt.font = [UIFont systemFontOfSize:13];
        Txt.backgroundColor = [UIColor clearColor];
        [imageDetailsLayer addSubview:Txt];
        
       // suggesteditem.PropertyItemId
        
        y += 175;
    }
    [self.view addSubview:imageDetailsLayer];
    [imageDetailsLayer setContentSize:CGSizeMake(150, y + 10)];
}

- (IBAction)back:(id)sender {
    EgyptView *egyptView = [[EgyptView alloc] init];
    egyptView.view.frame    = self.view.bounds;
    [self.view addSubview:egyptView.view];
    [self addChildViewController:egyptView];
}


- (IBAction)next:(id)sender {
    lastOffset = imageScroll.contentOffset.x + 1024;
    if(imageScroll.contentOffset.x < ((imageCount-1) * 1024) )
    {
        rightCount++;
        [imageScroll setContentOffset:CGPointMake(lastOffset, 0) animated:YES];
        [previousOutlet setHidden:NO];
    }
    if((imageScroll.contentOffset.x + 1024) == ((imageCount-1) * 1024))
        [nextOutlet setHidden:YES];
     pageControl.currentPage = rightCount;
}

- (IBAction)previous:(id)sender {
    lastOffset = imageScroll.contentOffset.x - 1024;
    if(imageScroll.contentOffset.x != 0 )
    {
        rightCount--;
        [imageScroll setContentOffset:CGPointMake(lastOffset, 0) animated:YES];
        [nextOutlet setHidden:NO];
    }
    if((imageScroll.contentOffset.x - 1024)== 0)
        [previousOutlet setHidden:YES];
     pageControl.currentPage = rightCount;
}

- (IBAction)follow:(id)sender {
}

- (IBAction)share:(id)sender {
}
@end
