//
//  EgyptProperties.m
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import "EgyptView.h"
#import "AppDelegate.h"
#import "DetailsView.h"
@interface EgyptView ()

@end

@implementation EgyptView
@synthesize secondHeader,myHomeBgNo,priceColorLbl,sqColorLbl,bathColorLbl,bidsColorLbl,priceArrowUp,priceArrowDown,sqArrowDown,sqArrowUp,bidsArrowdown,bidsArrowUp,bathArrowdown,bathArrowUp,tableViewOutlet,headerSceoll,line1,line2,line3,line4,redButton,rentBuy,countryScroll, propertyTypeScroll, maxPriceScroll, minPriceScroll,countryTable,propertyTable,minTable,maxTable,searchScroll,searchTf,countrySelected,propertySelected,minimumSelected,maximumSelected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setEgyptViewAlignment
{
    if(((AppDelegate *)[UIApplication sharedApplication].delegate).menuOpen ==1)
    {
        [tableViewOutlet setFrame:CGRectMake(0, 74, 1024, 610)];
        [headerSceoll setFrame:CGRectMake(0, 39, 1024, 40)];
        [line1 setFrame:CGRectMake(470, 39, 2, 645)];
        [line2 setFrame:CGRectMake(600, 39, 2, 645)];
        [line3 setFrame:CGRectMake(730, 39, 2, 645)];
        [line4 setFrame:CGRectMake(860, 39, 2, 645)];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [tableViewOutlet setFrame:CGRectMake(48, 74, 1024, 610)];
        [headerSceoll setFrame:CGRectMake(48, 39, 1024, 40)];
        [line1 setFrame:CGRectMake(518, 39, 2, 645)];
        [line2 setFrame:CGRectMake(648, 39, 2, 645)];
        [line3 setFrame:CGRectMake(778, 39, 2, 645)];
        [line4 setFrame:CGRectMake(908, 39, 2, 645)];
        [UIView commitAnimations];
    }
    else
    {
        [tableViewOutlet setFrame:CGRectMake(48, 74, 1024, 610)];
        [headerSceoll setFrame:CGRectMake(48, 39, 1024, 40)];
        [line1 setFrame:CGRectMake(518, 39, 2, 645)];
        [line2 setFrame:CGRectMake(648, 39, 2, 645)];
        [line3 setFrame:CGRectMake(778, 39, 2, 645)];
        [line4 setFrame:CGRectMake(908, 39, 2, 645)];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [tableViewOutlet setFrame:CGRectMake(0, 74, 1024, 610)];
        [headerSceoll setFrame:CGRectMake(0, 39, 1024, 40)];
        [line1 setFrame:CGRectMake(470, 39, 2, 645)];
        [line2 setFrame:CGRectMake(600, 39, 2, 645)];
        [line3 setFrame:CGRectMake(730, 39, 2, 645)];
        [line4 setFrame:CGRectMake(860, 39, 2, 645)];
        [UIView commitAnimations];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableCloseMenu" object:nil userInfo:nil];
    
    resultFlag = TRUE;
    priceFlag = TRUE;
    sqFlag = TRUE;
    bidsFlag = TRUE;
    bathFlag = TRUE;
    finishScrolling = TRUE;
    [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
    [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
    [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
    [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
    
    tableViewOutlet.delegate = self;
    tableViewOutlet.scrollEnabled = YES;
    [searchScroll setHidden:YES];
    searchTf.delegate = self;
    countryData = [[NSMutableArray alloc] initWithObjects:@"New Cairo",@"6 Octobar",@"sheikh zaid",@"maadi",@"North coast",@"ِAl Shorok",@"UpTwon Cairo",@"Gouna",@"Marassi",@"Mohandessen", nil];
    
    propertyTypeData = [[NSMutableArray alloc] initWithObjects:@"Medical",@"Office",@"Duplex",@"Apartment",@"Chalet",@"Ground floor",@"shop",@"Ain sokhna",@"studio",@"El obour", nil];
    
    minData = [[NSMutableArray alloc] initWithObjects:@"100000",@"200000",@"300000",@"400000",@"500000",@"600000",@"700000",@"800000",@"900000",@"1000000", nil];
    
    maxData = [[NSMutableArray alloc] initWithObjects:@"100000",@"200000",@"300000",@"400000",@"500000",@"600000",@"700000",@"800000",@"900000",@"1000000", nil];
    
    
    
    cellBgFlag=FALSE;
    [secondHeader setBackgroundColor:[UIColor colorWithRed:0xda/255.0f
                                                      green:0xdf/255.0f
                                                       blue:0xe2/255.0f alpha:1]];
    
    [priceColorLbl setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                green:0x3f/255.0f
                                                 blue:0x50/255.0f alpha:1]];
    
    [sqColorLbl setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                green:0x3f/255.0f
                                                 blue:0x50/255.0f alpha:1]];
    
    [bidsColorLbl setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                green:0x3f/255.0f
                                                 blue:0x50/255.0f alpha:1]];
    
    [bathColorLbl setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                green:0x3f/255.0f
                                                 blue:0x50/255.0f alpha:1]];
    
    
    [self setEgyptViewAlignment];
    

    myHomeBgNo.backgroundColor=[UIColor grayColor];
        
    [priceArrowUp setBackgroundImage:[UIImage imageNamed:@"filter-arrow-up-white.png"] forState:UIControlStateNormal];
    [priceArrowUp setBackgroundImage:[UIImage imageNamed:@"filter-arrow-up.png"] forState:UIControlStateSelected];
    
    [sqArrowUp setBackgroundImage:[UIImage imageNamed:@"filter-arrow-up-white.png"] forState:UIControlStateNormal];
    [sqArrowUp setBackgroundImage:[UIImage imageNamed:@"filter-arrow-up.png"] forState:UIControlStateSelected];
    
    [bidsArrowUp setBackgroundImage:[UIImage imageNamed:@"filter-arrow-up-white.png"] forState:UIControlStateNormal];
    [bidsArrowUp setBackgroundImage:[UIImage imageNamed:@"filter-arrow-up.png"] forState:UIControlStateSelected];
    
    [bathArrowUp setBackgroundImage:[UIImage imageNamed:@"filter-arrow-up-white.png"] forState:UIControlStateNormal];
    [bathArrowUp setBackgroundImage:[UIImage imageNamed:@"filter-arrow-up.png"] forState:UIControlStateSelected];
    
    
    [priceArrowDown setBackgroundImage:[UIImage imageNamed:@"filter-arrow-down-white.png"] forState:UIControlStateNormal];
    [priceArrowDown setBackgroundImage:[UIImage imageNamed:@"filter-arrow-down.png"] forState:UIControlStateSelected];
    
    [sqArrowDown setBackgroundImage:[UIImage imageNamed:@"filter-arrow-down-white.png"] forState:UIControlStateNormal];
    [sqArrowDown setBackgroundImage:[UIImage imageNamed:@"filter-arrow-down.png"] forState:UIControlStateSelected];
    
    [bidsArrowdown setBackgroundImage:[UIImage imageNamed:@"filter-arrow-down-white.png"] forState:UIControlStateNormal];
    [bidsArrowdown setBackgroundImage:[UIImage imageNamed:@"filter-arrow-down.png"] forState:UIControlStateSelected];
    
    [bathArrowdown setBackgroundImage:[UIImage imageNamed:@"filter-arrow-down-white.png"] forState:UIControlStateNormal];
    [bathArrowdown setBackgroundImage:[UIImage imageNamed:@"filter-arrow-down.png"] forState:UIControlStateSelected];
    
    [priceArrowUp setSelected:YES];
    [sqArrowUp setSelected:YES];
    [bidsArrowUp setSelected:YES];
    [bathArrowUp setSelected:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(countryTableFlag)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownCell" owner:self options:nil];
        dropDownCell.cellText.text  = [countryData objectAtIndex:indexPath.row];
        return dropDownCell;
    }
    else if(propertyTableFlag)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownCell" owner:self options:nil];
        dropDownCell.cellText.text  = [propertyTypeData objectAtIndex:indexPath.row];
        return dropDownCell;
    }
    else if(minTableFlag)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownCell" owner:self options:nil];
        dropDownCell.cellText.text  = [minData objectAtIndex:indexPath.row];
        return dropDownCell;
    }
    else if(maxTableFlag)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownCell" owner:self options:nil];
        dropDownCell.cellText.text  = [maxData objectAtIndex:indexPath.row];
        return dropDownCell;
    }

    else
    {
     [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
    
   
    tableCell.cellTextDetails.text=@"jhkjqwhdkjhqkjwhdkjqwhdjhq wjdhgqw jkhgdjhqg wjkdhg qjkwdgkjhqgw jkdghqjw kgdjkhqgw djkhqgwd qwjhdgjhkqwgd kjghqw kjdgqwkhjdg hjqwg djghqwd qwjhdg qhjwg dhj";
    
    tableCell.price.text=@"10000";
    tableCell.sq.text=@"250";
    tableCell.bids.text=@"3";
    tableCell.bath.text=@"1";
    
    
    
     /////////////////////////////////////////Color/////////////////////////////////////
    
    [tableCell.price setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                  green:0x3f/255.0f
                                                   blue:0x50/255.0f alpha:1]];
    
    [tableCell.sq setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                               green:0x3f/255.0f
                                                blue:0x50/255.0f alpha:1]];
    
    [tableCell.bids setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                 green:0x3f/255.0f
                                                  blue:0x50/255.0f alpha:1]];
    
    [tableCell.bath setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                 green:0x3f/255.0f
                                                  blue:0x50/255.0f alpha:1]];
    
    [tableCell.share setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                 green:0x3f/255.0f
                                                  blue:0x50/255.0f alpha:1]];
    
    [tableCell.followLbl setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                 green:0x3f/255.0f
                                                  blue:0x50/255.0f alpha:1]];
    [tableCell.cellTextDetails setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                      green:0x3f/255.0f
                                                       blue:0x50/255.0f alpha:1]];
    
    [tableCell.cellTopicTextHeader setTextColor:[UIColor colorWithRed:0xc2/255.0f
                                                      green:0x39/255.0f
                                                       blue:0x29/255.0f alpha:1]];
    
    if((indexPath.row+1)%2!=0)
        [tableCell.imageBackgroud setBackgroundColor:[UIColor colorWithRed:0xec/255.0f
                                                                     green:0xf0/255.0f
                                                                      blue:0xf1/255.0f alpha:1]];
    else
        [tableCell.imageBackgroud setBackgroundColor:[UIColor colorWithRed:0xda/255.0f
                                                                     green:0xdf/255.0f
                                                                      blue:0xe2/255.0f alpha:1]];
    cellBgFlag=!cellBgFlag;
    
    
    return tableCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(countryTableFlag || propertyTableFlag || minTableFlag || maxTableFlag)
        return 30;
    else
        return 121;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(countryTableFlag)
        return countryData.count;
    else if(propertyTableFlag)
        return propertyTypeData.count;
    else if(minTableFlag)
        return minData.count;
    else if(maxTableFlag)
        return maxData.count;
    else
        return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];

    if(countryTableFlag)
    {
        countrySelected.text = [countryData objectAtIndex:indexPath.row];
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        countryFlag = FALSE;
        countryTableFlag = FALSE;
    }
    else if(propertyTableFlag)
    {
        propertySelected.text = [propertyTypeData objectAtIndex:indexPath.row];
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        propertyTypeFlag = FALSE;
        propertyTableFlag = FALSE;
    }
    else if(minTableFlag)
    {
        minimumSelected.text = [minData objectAtIndex:indexPath.row];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        minPriceFlag = FALSE;
        minTableFlag = FALSE;
    }
    else if(maxTableFlag)
    {
         maximumSelected.text = [maxData objectAtIndex:indexPath.row];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
         maxPriceFlag = FALSE;
    }
    
    [UIView commitAnimations];
    
    if(countryTableFlag == FALSE && propertyTableFlag == FALSE && minTableFlag == FALSE && maxTableFlag == FALSE)
    {
       tableViewOutlet.scrollEnabled = TRUE;
    }
    
    DetailsView *detailsView = [[DetailsView alloc] init];
    detailsView.view.frame    = self.view.bounds;
    [self.view addSubview:detailsView.view];
    [self addChildViewController:detailsView];
    
}

- (IBAction)priceUp:(id)sender {
    [priceArrowUp setSelected:YES];
    [priceArrowDown setSelected:NO];
}

- (IBAction)priceDown:(id)sender {
    [priceArrowUp setSelected:NO];
    [priceArrowDown setSelected:YES];
}

- (IBAction)sqUp:(id)sender {
    [sqArrowUp setSelected:YES];
    [sqArrowDown setSelected:NO];
}

- (IBAction)sqDown:(id)sender {
    [sqArrowUp setSelected:NO];
    [sqArrowDown setSelected:YES];
}

- (IBAction)bidsUp:(id)sender {
    [bidsArrowUp setSelected:YES];
    [bidsArrowdown setSelected:NO];
}

- (IBAction)bidsDown:(id)sender {
    [bidsArrowUp setSelected:NO];
    [bidsArrowdown setSelected:YES];
}

- (IBAction)bathUp:(id)sender {
    [bathArrowUp setSelected:YES];
    [bathArrowdown setSelected:NO];
}

- (IBAction)bathDown:(id)sender {
    [bathArrowUp setSelected:NO];
    [bathArrowdown setSelected:YES];
}

- (IBAction)FilterHome:(id)sender {
    if(resultFlag)
    {
        [redButton setFrame:CGRectMake(1, 0, 138, 40)];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [redButton setFrame:CGRectMake(175, 0, 138, 40)];
        [UIView commitAnimations];
        resultFlag = FALSE;
    }
}

- (IBAction)results:(id)sender {
    if(!resultFlag)
    {
        [redButton setFrame:CGRectMake(175, 0, 138, 40)];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [redButton setFrame:CGRectMake(1, 0, 138, 40)];
        [UIView commitAnimations];
        resultFlag = TRUE;
    }
}

- (IBAction)pricetoggle:(id)sender {
    if(!priceFlag)
    {
        [priceArrowUp setSelected:YES];
        [priceArrowDown setSelected:NO];
    }
    else
    {
        [priceArrowUp setSelected:NO];
        [priceArrowDown setSelected:YES];
    }
    priceFlag =! priceFlag;
}

- (IBAction)sqToggle:(id)sender {
    if(!sqFlag)
    {
        [sqArrowUp setSelected:YES];
        [sqArrowDown setSelected:NO];
    }
    else
    {
        [sqArrowUp setSelected:NO];
        [sqArrowDown setSelected:YES];
        
    }
     sqFlag =! sqFlag;
}

- (IBAction)bidsToggle:(id)sender {
    if(!bidsFlag)
    {
        [bidsArrowUp setSelected:YES];
        [bidsArrowdown setSelected:NO];
    }
    else
    {
        [bidsArrowUp setSelected:NO];
        [bidsArrowdown setSelected:YES];
    }
    bidsFlag =! bidsFlag;
}

- (IBAction)bathToggle:(id)sender {
    if(!bathFlag)
    {
        [bathArrowUp setSelected:YES];
        [bathArrowdown setSelected:NO];
    }
    else
    {
        [bathArrowUp setSelected:NO];
        [bathArrowdown setSelected:YES];
    }
    bathFlag =! bathFlag;
}

- (IBAction)searchToggle:(id)sender {
    if(!searchFlag)
    {
       [searchScroll setHidden:NO];
       [searchTf becomeFirstResponder];
    }
    else
        [searchScroll setHidden:YES];
    searchFlag =! searchFlag;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    finishScrolling = TRUE;
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    finishScrolling = FALSE;
}
- (IBAction)country:(id)sender {
    

    if(finishScrolling)
    {
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    if(!countryFlag)
    {
        tableViewOutlet.scrollEnabled = FALSE;
        [countryScroll setFrame:CGRectMake(55, 40, 161, 413)];
        countryFlag = TRUE;
        
        countryTableFlag = TRUE;
        propertyTableFlag = FALSE;
        minTableFlag = FALSE;
        maxTableFlag = FALSE;
        
        minPriceFlag = FALSE;
        propertyTypeFlag = FALSE;
        maxPriceFlag = FALSE;
        
        [countryTable reloadData];
        
    
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
    }
    else
    {
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        tableViewOutlet.scrollEnabled = TRUE;
        countryFlag = FALSE;
        countryFlag = FALSE;
        countryTableFlag = FALSE;
        propertyTableFlag = FALSE;
        minTableFlag = FALSE;
        maxTableFlag = FALSE;
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
    }
    [UIView commitAnimations];
    }
}

- (IBAction)propertyType:(id)sender {
    if(finishScrolling)
    {
        tableViewOutlet.scrollEnabled = FALSE;
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    if(!propertyTypeFlag)
    {
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 413)];
        propertyTypeFlag = TRUE;
        countryTableFlag = FALSE;
        propertyTableFlag = TRUE;
        minTableFlag = FALSE;
        maxTableFlag = FALSE;
        
        countryFlag = FALSE;
        minPriceFlag = FALSE;
        maxPriceFlag = FALSE;
        
        [propertyTable reloadData];
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
        
    }
    else
    {
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        propertyTableFlag = FALSE;
        tableViewOutlet.scrollEnabled = TRUE;
        propertyTypeFlag = FALSE;
        countryTableFlag = FALSE;
        propertyTableFlag = FALSE;
        minTableFlag = FALSE;
        maxTableFlag = FALSE;
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
    }
     [UIView commitAnimations];
    }
}
- (IBAction)rentBuy:(id)sender {
    if(rentFlag)
       [rentBuy setBackgroundImage:[UIImage imageNamed:@"switch-buy.png"] forState:UIControlStateNormal];
    else
       [rentBuy setBackgroundImage:[UIImage imageNamed:@"switch-rent.png"] forState:UIControlStateNormal];
    rentFlag =! rentFlag;
}

- (IBAction)minimumPrice:(id)sender {
    if(finishScrolling)
    {
        tableViewOutlet.scrollEnabled = FALSE;
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    if(!minPriceFlag)
    {
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 413)];
        minPriceFlag = TRUE;
        countryTableFlag = FALSE;
        propertyTableFlag = FALSE;
        minTableFlag = TRUE;
        maxTableFlag = FALSE;
        
        countryFlag = FALSE;
        propertyTypeFlag = FALSE;
        maxPriceFlag = FALSE;
        
        [minTable reloadData];
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
    }
    else
    {
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        minTableFlag = FALSE;
        tableViewOutlet.scrollEnabled = TRUE;
        minPriceFlag = FALSE;
        countryTableFlag = FALSE;
        propertyTableFlag = FALSE;
        minTableFlag = FALSE;
        maxTableFlag = FALSE;
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
    }
    [UIView commitAnimations];
    }
}

- (IBAction)maximumPrice:(id)sender {
    if(finishScrolling)
    {
        tableViewOutlet.scrollEnabled = FALSE;
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    if(!maxPriceFlag)
    {
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 413)];
        maxPriceFlag = TRUE;
        
        countryTableFlag = FALSE;
        propertyTableFlag = FALSE;
        minTableFlag = FALSE;
        maxTableFlag = TRUE;
        
        countryFlag = FALSE;
        minPriceFlag = FALSE;
        propertyTypeFlag = FALSE;
        [maxTable reloadData];
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
    }
    else
    {
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
        maxTableFlag = FALSE;
        tableViewOutlet.scrollEnabled = TRUE;
        maxPriceFlag = FALSE;
        countryTableFlag = FALSE;
        propertyTableFlag = FALSE;
        minTableFlag = FALSE;
        maxTableFlag = FALSE;
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
    }
    [UIView commitAnimations];
    }
}

- (IBAction)goSearch:(id)sender {
    searchFlag = FALSE;
    [searchTf resignFirstResponder];
    [searchScroll setHidden:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    searchFlag = FALSE;
    [searchScroll setHidden:YES];
    [textField resignFirstResponder];
    return YES;
}
@end
