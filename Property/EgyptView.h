//
//  EgyptView.h
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/21/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCell.h"
#import "DropDownCell.h"

@interface EgyptView : UIViewController <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    IBOutlet TableCell *tableCell;
    IBOutlet DropDownCell *dropDownCell;
    BOOL cellBgFlag, priceFlag, sqFlag, bidsFlag, bathFlag, countryFlag, propertyTypeFlag, maxPriceFlag, minPriceFlag, rentFlag, countryTableFlag, propertyTableFlag, minTableFlag, maxTableFlag, searchFlag, finishScrolling,resultFlag;
    NSMutableArray *countryData, *propertyTypeData, *maxData, *minData;
}
@property (strong, nonatomic) IBOutlet UIImageView *secondHeader;
@property (strong, nonatomic) IBOutlet UIImageView *myHomeBgNo;

@property (strong, nonatomic) IBOutlet UILabel *priceColorLbl;
@property (strong, nonatomic) IBOutlet UILabel *sqColorLbl;
@property (strong, nonatomic) IBOutlet UILabel *bidsColorLbl;
@property (strong, nonatomic) IBOutlet UILabel *bathColorLbl;
@property (strong, nonatomic) IBOutlet UILabel *countrySelected;
@property (strong, nonatomic) IBOutlet UILabel *propertySelected;
@property (strong, nonatomic) IBOutlet UILabel *minimumSelected;
@property (strong, nonatomic) IBOutlet UILabel *maximumSelected;

@property (strong, nonatomic) IBOutlet UITextField *searchTf;

@property (strong, nonatomic) IBOutlet UIButton *priceArrowUp;
@property (strong, nonatomic) IBOutlet UIButton *priceArrowDown;
@property (strong, nonatomic) IBOutlet UIButton *sqArrowUp;
@property (strong, nonatomic) IBOutlet UIButton *sqArrowDown;
@property (strong, nonatomic) IBOutlet UIButton *bidsArrowUp;
@property (strong, nonatomic) IBOutlet UIButton *bidsArrowdown;
@property (strong, nonatomic) IBOutlet UIButton *bathArrowUp;
@property (strong, nonatomic) IBOutlet UIButton *bathArrowdown;
@property (strong, nonatomic) IBOutlet UIButton *redButton;
@property (strong, nonatomic) IBOutlet UIButton *rentBuy;

@property (strong, nonatomic) IBOutlet UITableView *tableViewOutlet;
@property (strong, nonatomic) IBOutlet UIScrollView *searchScroll;

@property (strong, nonatomic) IBOutlet UIScrollView *headerSceoll;
@property (strong, nonatomic) IBOutlet UIImageView *line1;
@property (strong, nonatomic) IBOutlet UIImageView *line4;
@property (strong, nonatomic) IBOutlet UIImageView *line3;
@property (strong, nonatomic) IBOutlet UIImageView *line2;

@property (strong, nonatomic) IBOutlet UITableView *countryTable;
@property (strong, nonatomic) IBOutlet UITableView *propertyTable;
@property (strong, nonatomic) IBOutlet UITableView *minTable;
@property (strong, nonatomic) IBOutlet UITableView *maxTable;

- (IBAction)priceUp:(id)sender;
- (IBAction)priceDown:(id)sender;
- (IBAction)sqUp:(id)sender;
- (IBAction)sqDown:(id)sender;
- (IBAction)bidsUp:(id)sender;
- (IBAction)bidsDown:(id)sender;
- (IBAction)bathUp:(id)sender;
- (IBAction)bathDown:(id)sender;

- (IBAction)FilterHome:(id)sender;
- (IBAction)results:(id)sender;
- (IBAction)pricetoggle:(id)sender;
- (IBAction)sqToggle:(id)sender;
- (IBAction)bidsToggle:(id)sender;
- (IBAction)bathToggle:(id)sender;
- (IBAction)searchToggle:(id)sender;

- (IBAction)country:(id)sender;
- (IBAction)propertyType:(id)sender;
- (IBAction)rentBuy:(id)sender;
- (IBAction)minimumPrice:(id)sender;
- (IBAction)maximumPrice:(id)sender;
- (IBAction)goSearch:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *countryScroll;
@property (strong, nonatomic) IBOutlet UIScrollView *propertyTypeScroll;
@property (strong, nonatomic) IBOutlet UIScrollView *minPriceScroll;
@property (strong, nonatomic) IBOutlet UIScrollView *maxPriceScroll;

@end
