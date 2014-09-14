//
//  ANUViewController.h
//  ManageFiles
//
//  Created by Anuja on 9/14/14.
//  Copyright (c) 2014 AnujAroshA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANUViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *placeHolderLabel;

- (IBAction)createAction:(UIButton *)sender;
- (IBAction)readAction:(UIButton *)sender;
- (IBAction)deleteAction:(UIButton *)sender;

@end
