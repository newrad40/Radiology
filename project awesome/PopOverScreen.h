//
//  PopOverScreen.h
//  project awesome
//
//  Created by Christopher Fontas on 5/29/13.
//  Copyright (c) 2013 Department of Radiology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "BackGroundOptions.h"
#import "ButtonOptions.h"

@interface PopOverScreen : UITableViewController

@property (nonatomic, retain) NSArray *optionsArray;
-(void)dismissBackgroundPop;
-(void)dismissButtonPop;


@end
