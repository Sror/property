//
//  SplashView.m
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/18/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "SplashView.h"
#import "DashBoard.h"
#import "PropertyAdvisorUpdater.h"
#import "DbAccessor.h"

#import "MagazineImageTag.h"
#import "Magazine.h"
#import "MagazineImageItem.h"

@interface SplashView ()

@end

@implementation SplashView

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
    PropertyAdvisorUpdater * paUpdater = [[PropertyAdvisorUpdater alloc]init];
    paUpdater.viewController = self;
    [paUpdater  checkForInitialUpdate:self];
    
    
    
   }


-(void)FinishLoading 
{
    [self performSelector:@selector(goDashBoard:) withObject:nil afterDelay:2.0];
}

-(IBAction)goDashBoard:(id)sender
{
    DashBoard *dashBoard=[[DashBoard alloc] init];
    [self.navigationController pushViewController:dashBoard animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
