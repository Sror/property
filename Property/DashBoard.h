//
//  DashBoard.h
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/18/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashBoard : UIViewController
{
    BOOL showMenuFlag;
    int menuY;
    UIImageView * selectedImageArrow;
}
@property (strong, nonatomic) IBOutlet UIButton *commercialProperty;
@property (strong, nonatomic) IBOutlet UIButton *internationalProperties;
@property (strong, nonatomic) IBOutlet UIButton *egyptPropeties;
@property (strong, nonatomic) IBOutlet UIButton *magazin;
@property (strong, nonatomic) IBOutlet UIButton *showMenuBtn;
@property (strong, nonatomic) IBOutlet UIImageView *selectedImageArrow;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) IBOutlet UIScrollView *menuScroll;
- (IBAction)goCommercial:(id)sender;
- (IBAction)goInternational:(id)sender;
- (IBAction)goEgypt:(id)sender;
- (IBAction)goMagazine:(id)sender;
- (IBAction)goYouTube:(id)sender;
- (IBAction)goTwitter:(id)sender;
- (IBAction)goFacebook:(id)sender;
- (IBAction)goContact:(id)sender;
- (IBAction)showMenu:(id)sender;
@end
