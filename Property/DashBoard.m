//
//  DashBoard.m
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/18/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "DashBoard.h"
#import "MagazineView.h"
#import "EgyptView.h"
#import "AppDelegate.h"
@interface DashBoard ()

@end

@implementation DashBoard
@synthesize commercialProperty,containerView,internationalProperties,egyptPropeties,magazin,menuScroll,showMenuBtn,selectedImageArrow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Tab 1
    
    [commercialProperty setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                           green:0x14/255.0f
                                                            blue:0x2e/255.0f alpha:1]];
    
    //Tab 2
    [internationalProperties setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                           green:0x14/255.0f
                                                            blue:0x2e/255.0f alpha:1]];
    //Tab 3
    [egyptPropeties setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                           green:0x14/255.0f
                                                            blue:0x2e/255.0f alpha:1]];
    //Tab4
    [magazin setBackgroundColor:[UIColor colorWithRed:0xd3/255.0f
                                                green:0x1f/255.0f
                                                 blue:0x28/255.0f alpha:1]];
    
    //load default tab ( magazine )
    MagazineView *magazineView = [[MagazineView alloc] init];
    magazineView.view.frame    = containerView.bounds;
    [self.containerView addSubview:magazineView.view];
    [self addChildViewController:magazineView];
    menuScroll.frame=CGRectMake(0, 1400, 53, 684);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goCommercial:(id)sender {
    ((AppDelegate *)[UIApplication sharedApplication].delegate).selectedTab = 1;
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [commercialProperty setBackgroundColor:[UIColor colorWithRed:0xd3/255.0f
                                                           green:0x1f/255.0f
                                                            blue:0x28/255.0f alpha:1]];
    [internationalProperties setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                           green:0x14/255.0f
                                                            blue:0x2e/255.0f alpha:1]];
    [egyptPropeties setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                           green:0x14/255.0f
                                                            blue:0x2e/255.0f alpha:1]];
    [magazin setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                           green:0x14/255.0f
                                                            blue:0x2e/255.0f alpha:1]];
    
    menuY = commercialProperty.frame.origin.y + ( commercialProperty.frame.size.height /2 );
    [selectedImageArrow setFrame:CGRectMake(39,menuY, 9, 18)];
    [UIView commitAnimations];

   
}

- (IBAction)goInternational:(id)sender {
    ((AppDelegate *)[UIApplication sharedApplication].delegate).selectedTab = 2;
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [internationalProperties setBackgroundColor:[UIColor colorWithRed:0xd3/255.0f
                                                           green:0x1f/255.0f
                                                            blue:0x28/255.0f alpha:1]];
    [commercialProperty setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                                green:0x14/255.0f
                                                                 blue:0x2e/255.0f alpha:1]];
    [egyptPropeties setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                       green:0x14/255.0f
                                                        blue:0x2e/255.0f alpha:1]];
    [magazin setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                green:0x14/255.0f
                                                 blue:0x2e/255.0f alpha:1]];
    
    menuY = internationalProperties.frame.origin.y + ( internationalProperties.frame.size.height /2 );
    [selectedImageArrow setFrame:CGRectMake(39,menuY, 9, 18)];
    [UIView commitAnimations];
}

- (IBAction)goEgypt:(id)sender {
    ((AppDelegate *)[UIApplication sharedApplication].delegate).selectedTab = 3;
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [egyptPropeties setBackgroundColor:[UIColor colorWithRed:0xd3/255.0f
                                                           green:0x1f/255.0f
                                                            blue:0x28/255.0f alpha:1]];
    [internationalProperties setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                                green:0x14/255.0f
                                                                 blue:0x2e/255.0f alpha:1]];
    [commercialProperty setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                       green:0x14/255.0f
                                                        blue:0x2e/255.0f alpha:1]];
    [magazin setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                green:0x14/255.0f
                                                 blue:0x2e/255.0f alpha:1]];
    
    menuY = egyptPropeties.frame.origin.y + ( egyptPropeties.frame.size.height /2 );
    [selectedImageArrow setFrame:CGRectMake(39,menuY, 9, 18)];
    
    [UIView commitAnimations];
    
    NSArray *views = [containerView subviews];
    for (UIView *v in views)
        [v removeFromSuperview];
    
    EgyptView *egyptView = [[EgyptView alloc] init];
    egyptView.view.frame    = containerView.bounds;
    [self.containerView addSubview:egyptView.view];
    [self addChildViewController:egyptView];
}

- (IBAction)goMagazine:(id)sender {
    ((AppDelegate *)[UIApplication sharedApplication].delegate).selectedTab = 4;
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [magazin setBackgroundColor:[UIColor colorWithRed:0xd3/255.0f
                                                           green:0x1f/255.0f
                                                            blue:0x28/255.0f alpha:1]];
    [internationalProperties setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                                green:0x14/255.0f
                                                                 blue:0x2e/255.0f alpha:1]];
    [egyptPropeties setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                       green:0x14/255.0f
                                                        blue:0x2e/255.0f alpha:1]];
    [commercialProperty setBackgroundColor:[UIColor colorWithRed:0x0b/255.0f
                                                green:0x14/255.0f
                                                 blue:0x2e/255.0f alpha:1]];
    
    menuY = magazin.frame.origin.y + ( magazin.frame.size.height /2 );
    [selectedImageArrow setFrame:CGRectMake(39,menuY, 9, 18)];

    [UIView commitAnimations];
    NSArray *views = [containerView subviews];
    for (UIView *v in views)
        [v removeFromSuperview];
    
    MagazineView *magazineView = [[MagazineView alloc] init];
    magazineView.view.frame    = containerView.bounds;
    [self.containerView addSubview:magazineView.view];
    [self addChildViewController:magazineView];
}

- (IBAction)goYouTube:(id)sender {
}

- (IBAction)goTwitter:(id)sender {
}

- (IBAction)goFacebook:(id)sender {
}

- (IBAction)goContact:(id)sender {
}
- (IBAction)showMenu:(id)sender {
    
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    if(showMenuFlag)
    {
        ((AppDelegate *)[UIApplication sharedApplication].delegate).menuOpen = 0;
        menuScroll.frame=CGRectMake(0, 1400, 53, 684);
        [showMenuBtn setBackgroundImage:[UIImage imageNamed:@"bottom-tab-bar-btn.png"] forState:UIControlStateNormal];
    }
    else
    {
        ((AppDelegate *)[UIApplication sharedApplication].delegate).menuOpen = 1;
         menuScroll.frame=CGRectMake(0, 0, 53, 684);
        [showMenuBtn setBackgroundImage:[UIImage imageNamed:@"bottom-tab-bar-btn.png"] forState:UIControlStateNormal];
    }
    [UIView commitAnimations];
    showMenuFlag =! showMenuFlag;
    
    switch (((AppDelegate *)[UIApplication sharedApplication].delegate).selectedTab) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            EgyptView *egyptView = [[EgyptView alloc] init];
            egyptView.view.frame    = containerView.bounds;
            [self.containerView addSubview:egyptView.view];
            [self addChildViewController:egyptView];
        }
            break;
        case 4:
        {
            MagazineView *magazineView = [[MagazineView alloc] init];
            magazineView.view.frame    = containerView.bounds;
            [self.containerView addSubview:magazineView.view];
            [self addChildViewController:magazineView];
        }
            break;
        default:
            break;
    }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
@end
