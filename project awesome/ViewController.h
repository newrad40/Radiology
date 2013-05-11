//
//  ViewController.h
//  project awesome
//
//  Created by Department of Radiology on 5/9/13.
//  Copyright (c) 2013 Department of Radiology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *mousepad;
@property (weak, nonatomic) IBOutlet UILabel *left_click_label;
@property (weak, nonatomic) IBOutlet UILabel *right_click_label;
@property (weak, nonatomic) IBOutlet UILabel *test_output;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *mouse_pan;
@property int counter;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_click;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *left_click_gesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *right_click_gest;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *two_finger_right;
@property (weak, nonatomic) IBOutlet UITextField *ip_field;
-(void)get_url:(NSString*)url;
-(void)send_input:(NSString*)str;

@end
