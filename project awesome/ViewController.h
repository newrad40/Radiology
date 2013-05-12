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
@property (weak, nonatomic) IBOutlet UIButton *w1;
@property (weak, nonatomic) IBOutlet UIButton *w2;
@property (weak, nonatomic) IBOutlet UIButton *w3;
@property (weak, nonatomic) IBOutlet UIButton *w4;
@property (weak, nonatomic) IBOutlet UIButton *w5;
@property (weak, nonatomic) IBOutlet UIButton *A;
@property (weak, nonatomic) IBOutlet UIButton *B;
@property (weak, nonatomic) IBOutlet UIButton *R;
@property (weak, nonatomic) IBOutlet UIButton *D;
@property (weak, nonatomic) IBOutlet UIButton *L;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *left_hold;
@property (weak, nonatomic) IBOutlet UIButton *dynamic_level;
@property (weak, nonatomic) IBOutlet UIButton *dynamic_zoom;
@property (weak, nonatomic) IBOutlet UILabel *level_mask;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *level_pan;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *two_finger_pan_mask;
@property (weak, nonatomic) IBOutlet UIButton *z;
@property bool inZoomMode;
@property bool inPanMode;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *on_z_pan;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *z_tap;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *z_tap_twice;
@property (weak, nonatomic) IBOutlet UILabel *overlay;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *sliding_button;
@property float original_slider_center;
@property NSTimer *const_scroll_timer;
@property int const_scroll_factor;
@end