//
//  EgyptProperties.m
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//
#import "PropertyAdvisorEnums.h"
#import "EgyptView.h"
#import "AppDelegate.h"
#import "DetailsView.h"
#import "PropertyManager.h"
#import "PropertyItem.h"
#import "SuggestedPropertyItem.h"
@interface EgyptView ()

@end

@implementation EgyptView
@synthesize secondHeader,myHomeBgNo,priceColorLbl,sqColorLbl,bathColorLbl,bidsColorLbl,priceArrowUp,priceArrowDown,sqArrowDown,sqArrowUp,bidsArrowdown,bidsArrowUp,bathArrowdown,bathArrowUp,tableViewOutlet,headerSceoll,line1,line2,line3,line4,redButton,rentBuy,countryScroll, propertyTypeScroll, maxPriceScroll, minPriceScroll,countryTable,propertyTable,minTable,maxTable,searchScroll,searchTf,countrySelected,propertySelected,minimumSelected,maximumSelected,propertyListCountLbl,favLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialitablzation
    }
    return self;
}

-(void)setEgyptViewAlignment
{
    if(((AppDelegate *)[UIApplication sharedApplication].delegate).menuOpen == 1)
    {
        [tableViewOutlet setFrame:CGRectMake(0, 74, 1024, 645)];
        [headerSceoll setFrame:CGRectMake(0, 39, 1024, 40)];
        [line1 setFrame:CGRectMake(530, 39, 2, 680)];
        [line2 setFrame:CGRectMake(650, 39, 2, 680)];
        [line3 setFrame:CGRectMake(760, 39, 2, 680)];
        [line4 setFrame:CGRectMake(860, 39, 2, 680)];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [tableViewOutlet setFrame:CGRectMake(48, 74, 1024, 645)];
        [headerSceoll setFrame:CGRectMake(48, 39, 1024, 40)];
        [line1 setFrame:CGRectMake(578, 39, 2, 680)];
        [line2 setFrame:CGRectMake(698, 39, 2, 680)];
        [line3 setFrame:CGRectMake(810, 39, 2, 680)];
        [line4 setFrame:CGRectMake(908, 39, 2, 680)];
        [UIView commitAnimations];
    }
    else
    {
        [tableViewOutlet setFrame:CGRectMake(48, 74, 1024, 645)];
        [headerSceoll setFrame:CGRectMake(48, 39, 1024, 40)];
        [line1 setFrame:CGRectMake(578, 39, 2, 680)];
        [line2 setFrame:CGRectMake(698, 39, 2, 680)];
        [line3 setFrame:CGRectMake(810, 39, 2, 680)];
        [line4 setFrame:CGRectMake(908, 39, 2, 680)];
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [tableViewOutlet setFrame:CGRectMake(0, 74, 1024, 645)];
        [headerSceoll setFrame:CGRectMake(0, 39, 1024, 40)];
        [line1 setFrame:CGRectMake(530, 39, 2, 680)];
        [line2 setFrame:CGRectMake(650, 39, 2, 680)];
        [line3 setFrame:CGRectMake(760, 39, 2, 680)];
        [line4 setFrame:CGRectMake(860, 39, 2, 680)];
        [UIView commitAnimations];
    }

}


PropertyManager * propertyManager;
int categryId=(int)egyptResidential;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)viewDidLoad
{
    
    rent = 1;
    propertyTypeId = 0;
    countryId = 0;
    
    favArray = [[NSMutableArray alloc] init];
    NSArray *arr = [self getArrayWithKey:@"FavouritesProperties"];
    favArray = [NSMutableArray arrayWithArray:arr];
    
    favLbl.text = [NSString stringWithFormat:@"%u",favArray.count];
    
    
    propertyManager = [[PropertyManager alloc]init];
    [propertyManager LoadFillingOptionLists];
    
     
   // PropertyItem * p =propertyManager.CurrentPrperty;
    
    //load all
    [propertyManager LoadPropertyList:countryId :propertyTypeId :rent :categryId];
    
    propertyListCountLbl.text = [NSString stringWithFormat:@"%d",[propertyManager.PropertyList count]];
    
    tableViewOutlet.bounces = NO;
    
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setEgyptViewAlignment) name:@"setEgyptViewAlignment" object:nil];
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"disableCloseMenu" object:nil userInfo:nil];
    
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
    
    DbAccessor *db = [[DbAccessor alloc] init];
    
    countryData = [NSMutableArray array];
    NSMutableArray *countrylist = [db LoadLocationList];
    for(FillingOptionItem *item in countrylist)
    {
        [countryData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",item.FillingOptionItemId],@"id",item.FillingOptionItemName,@"name", nil] ];
    }
    
    
    propertyTypeData = [NSMutableArray array];
    NSMutableArray *propertyTypeList = [db LoadPropertyTypeList];
    for(FillingOptionItem *item in propertyTypeList)
    {
        [propertyTypeData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",item.FillingOptionItemId],@"id",item.FillingOptionItemName,@"name", nil] ];
    }
    

    
  /*  maxData = [NSMutableArray array];
    NSMutableArray *countrylist = [db LoadLocationList];
    for(FillingOptionItem *item in countrylist)
    {
        [maxData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",item.FillingOptionItemId],@"id",item.FillingOptionItemName,@"name", nil] ];
    }*/
   // countryData = [[NSMutableArray alloc] initWithObjects:@"New Cairo",@"6 Octobar",@"sheikh zaid",@"maadi",@"North coast",@"ِAl Shorok",@"UpTwon Cairo",@"Gouna",@"Marassi",@"Mohandessen", nil];
    
   // propertyTypeData = [[NSMutableArray alloc] initWithObjects:@"Medical",@"Office",@"Duplex",@"Apartment",@"Chalet",@"Ground floor",@"shop",@"Ain sokhna",@"studio",@"El obour", nil];
    
  //  minData = [[NSMutableArray alloc] initWithObjects:@"100000",@"200000",@"300000",@"400000",@"500000",@"600000",@"700000",@"800000",@"900000",@"1000000", nil];
    
   // maxData = [[NSMutableArray alloc] initWithObjects:@"100000",@"200000",@"300000",@"400000",@"500000",@"600000",@"700000",@"800000",@"900000",@"1000000", nil];
    
    
    
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
//    tableViewOutlet.dataSource=propertyManager.PropertyList;
    
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
        dropDownCell.cellText.text  = [[countryData objectAtIndex:indexPath.row] valueForKey:@"name"];
        dropDownCell.cellText.textColor = [UIColor whiteColor];
        dropDownCell.backgroundColor = [UIColor clearColor];
        return dropDownCell;
    }
    else if(propertyTableFlag)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownCell" owner:self options:nil];
        dropDownCell.cellText.text  = [[propertyTypeData objectAtIndex:indexPath.row] valueForKey:@"name"];
        dropDownCell.cellText.textColor = [UIColor whiteColor];
        dropDownCell.backgroundColor = [UIColor clearColor];
        return dropDownCell;
    }
    else if(minTableFlag)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownCell" owner:self options:nil];
        dropDownCell.cellText.text  = [minData objectAtIndex:indexPath.row];
        dropDownCell.cellText.textColor = [UIColor whiteColor];
        dropDownCell.backgroundColor = [UIColor clearColor];
        return dropDownCell;
    }
    else if(maxTableFlag)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownCell" owner:self options:nil];
        dropDownCell.cellText.text  = [maxData objectAtIndex:indexPath.row];
        dropDownCell.cellText.textColor = [UIColor whiteColor];
        dropDownCell.backgroundColor = [UIColor clearColor];
        return dropDownCell;
    }
    else if (!resultFlag)
    {
        [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        
        [tableCell.followImage setBackgroundImage:[UIImage imageNamed:@"follow-active-icon.png"] forState:UIControlStateNormal];
        tableCell.followLbl.text=@"Following";
        tableCell.followLbl.textColor=[UIColor colorWithRed:0xc2/255.0f
                                                      green:0x39/255.0f
                                                       blue:0x29/255.0f alpha:1];

        
        tableCell.followBtn.enabled = NO;
        DbAccessor *db = [[DbAccessor alloc] init];
        PropertyItem * property = [db LoadProperty:[[NSString stringWithFormat:@"%@",[favArray objectAtIndex:indexPath.row]] integerValue]];
        
        tableCell.propertyId = property.PropertyItemId;
   
        tableCell.cellTextDetails.text = property.PropertyDescription;
        tableCell.cellTopicTextHeader.text = property.PropertyTitle;
        
        tableCell.price.text= [NSString stringWithFormat:@"%.2f %@",property.PriceFrom,property.Currency];
        tableCell.sq.text=[NSString stringWithFormat:@"%.2f sqm",property.AreaFrom];
        tableCell.bids.text=[NSString stringWithFormat:@"%d",property.BedRoomsFrom];
        tableCell.bath.text=[NSString stringWithFormat:@"%d",property.BathRoomsFrom];
        if(property.NumberOfImages != 0)
            tableCell.NumberOfImages.text=[NSString stringWithFormat:@"%d",property.NumberOfImages];
        else
            tableCell.NumberOfImages.text=[NSString stringWithFormat:@"%d",property.NumberOfImages +1];
        
        
        UIImage*img =[[UIImage alloc] initWithContentsOfFile:property.ThumbNail];
        
        tableCell.topicImage.image=img;
        
        
        
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
    else
    {
       
                
    [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
    
    PropertyItem * property =[propertyManager.PropertyList objectAtIndex:indexPath.row];
   
        BOOL found = FALSE;
        for(int i = 0 ; i < favArray.count ; i++ )
        {
            NSLog(@"%@ - %@",[NSString stringWithFormat:@"%li",property.PropertyItemId],[favArray objectAtIndex:i]);
            if([[NSString stringWithFormat:@"%li",property.PropertyItemId] isEqualToString:[favArray objectAtIndex:i]])
            {
                [tableCell.followImage setBackgroundImage:[UIImage imageNamed:@"follow-active-icon.png"] forState:UIControlStateNormal];
                tableCell.followLbl.text=@"Following";
                tableCell.followLbl.textColor=[UIColor colorWithRed:0xc2/255.0f
                                                    green:0x39/255.0f
                                                     blue:0x29/255.0f alpha:1];
                
                tableCell.followBtn.enabled = NO;
                found = TRUE;
                break;
            }
            
        }
        if(!found)
            [tableCell.followLbl setTextColor:[UIColor colorWithRed:0x2c/255.0f
                                                              green:0x3f/255.0f
                                                               blue:0x50/255.0f alpha:1]];
        
    tableCell.propertyId = property.PropertyItemId;
    tableCell.cellTextDetails.text = property.PropertyDescription;
    tableCell.cellTopicTextHeader.text = property.PropertyTitle;
        
    tableCell.price.text= [NSString stringWithFormat:@"%.2f %@",property.PriceFrom,property.Currency];
    tableCell.sq.text=[NSString stringWithFormat:@"%.2f sqm",property.AreaFrom];
    tableCell.bids.text=[NSString stringWithFormat:@"%d",property.BedRoomsFrom];
    tableCell.bath.text=[NSString stringWithFormat:@"%d",property.BathRoomsFrom];
    if(property.NumberOfImages != 0)
        tableCell.NumberOfImages.text=[NSString stringWithFormat:@"%d",property.NumberOfImages];
    else
        tableCell.NumberOfImages.text=[NSString stringWithFormat:@"%d",property.NumberOfImages +1];
        
    
    UIImage*img =[[UIImage alloc] initWithContentsOfFile:property.ThumbNail];
        
    tableCell.topicImage.image=img;
        
    
    
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
    else if (!resultFlag)
    {
         favLbl.text = [NSString stringWithFormat:@"%u",favArray.count];
        return favArray.count;
    }
    else
    {
        propertyListCountLbl.text = [NSString stringWithFormat:@"%d",[propertyManager.PropertyList count]];
        return [propertyManager.PropertyList count];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(countryTableFlag == FALSE && propertyTableFlag == FALSE && minTableFlag == FALSE && maxTableFlag == FALSE)
    {
        tableViewOutlet.scrollEnabled = TRUE;
        PropertyItem * selectedProperty = [propertyManager.PropertyList objectAtIndex:indexPath.row];
        
        DetailsView *detailsView = [[DetailsView alloc] init];
        detailsView.CurrentPropertyId = selectedProperty.PropertyItemId;
        detailsView.view.frame    = self.view.bounds;
        [self.view addSubview:detailsView.view];
        [self addChildViewController:detailsView];
    }

    
    [UIView  beginAnimations: @"Showinfo"context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];

    if(countryTableFlag)
    {
        countrySelected.text = [[countryData objectAtIndex:indexPath.row] valueForKey:@"name"];
        [countryScroll setFrame:CGRectMake(55, 40, 161, 0)];
        countryFlag = FALSE;
        countryTableFlag = FALSE;
         countryId = [[[countryData objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    }
    else if(propertyTableFlag)
    {
        propertySelected.text = [[propertyTypeData objectAtIndex:indexPath.row] valueForKey:@"name"];
        [propertyTypeScroll setFrame:CGRectMake(243, 40, 161, 0)];
        propertyTypeFlag = FALSE;
        propertyTableFlag = FALSE;
        propertyTypeId = [[[propertyTypeData objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];

    }
    else if(minTableFlag)
    {
        minimumSelected.text = [minData objectAtIndex:indexPath.row];
        [minPriceScroll setFrame:CGRectMake(580, 40, 161, 0)];
        minPriceFlag = FALSE;
        minTableFlag = FALSE;
        
        [propertyManager LoadPropertyList:countryId :propertyTypeId :rent :categryId];
        tableViewOutlet.scrollEnabled = YES;
        [tableViewOutlet reloadData];
    }
    else if(maxTableFlag)
    {
         maximumSelected.text = [maxData objectAtIndex:indexPath.row];
        [maxPriceScroll setFrame:CGRectMake(767, 40, 161, 0)];
         maxPriceFlag = FALSE;
         maxTableFlag = FALSE;
        
        [propertyManager LoadPropertyList:countryId :propertyTypeId :rent :categryId];
        tableViewOutlet.scrollEnabled = YES;
        [tableViewOutlet reloadData];
    }
    
    [UIView commitAnimations];
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
        
        NSArray *arr = [self getArrayWithKey:@"FavouritesProperties"];
        favArray = [NSMutableArray arrayWithArray:arr];
        
        tableViewOutlet.scrollEnabled = YES;
        [tableViewOutlet reloadData];
    }
}

- (NSArray *)getArrayWithKey:(NSString *)arrayKey{
	NSArray *userData = nil;
	
	if (arrayKey != nil) {
		NSObject *returnObject = [[NSUserDefaults standardUserDefaults] objectForKey:arrayKey];
		if ([returnObject isKindOfClass:[NSArray class]]) {
			userData = (NSArray *)returnObject;
		}
	}
	
	return userData;
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
        tableViewOutlet.scrollEnabled = YES;
        [tableViewOutlet reloadData];
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

- (IBAction)searchToggle:(id)sender
{
    if(!countryTableFlag && !propertyTableFlag && !minTableFlag && !maxTableFlag)
    {
        [propertyManager LoadPropertyList:countryId :propertyTypeId :rent :categryId];
        tableViewOutlet.scrollEnabled = YES;
        [tableViewOutlet reloadData];
    }
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
    {
       [rentBuy setBackgroundImage:[UIImage imageNamed:@"switch-buy.png"] forState:UIControlStateNormal];
        rent = 1;
    }
    else
    {
       [rentBuy setBackgroundImage:[UIImage imageNamed:@"switch-rent.png"] forState:UIControlStateNormal];
        rent = 2;
    }
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
