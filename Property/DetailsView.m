//
//  DetailsView.m
//  Property
//
//  Created by mohamed Alaa El-Din on 10/25/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "DetailsView.h"

@interface DetailsView ()

@end

@implementation DetailsView
@synthesize propertyName;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPropertyName:nil];
    [super viewDidUnload];
}
- (IBAction)back:(id)sender {
}
@end
