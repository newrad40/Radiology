//
//  ViewController.h
//  project awesome
//
//  Created by Department of Radiology on 5/9/13.
//  Copyright (c) 2013 Department of Radiology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopOverScreen.h"
#import "BackGroundOptions.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnLogIn;
- (IBAction)LogIn:(id)sender;

-(IBAction)AddAccount:(NSString *)name;
-(IBAction)LoginToProfile:(NSString *)name;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCustomize;

@property (weak, nonatomic) IBOutlet UIButton *btnCreateAccount;
- (IBAction)CreateAccount:(id)sender;

- (IBAction)CustomizeScreen:(id)sender;

-(void)SetButtonBackground:(NSString*)name;
@property (weak, nonatomic) IBOutlet UIButton *cine_play_pause_btn;


- (IBAction)handleScroll:(id)sender;
@property double scrollerPrevYOffset;
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
@property (weak, nonatomic) IBOutlet UIView *popout_view;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *left_swipe_mousepad;

@property (weak, nonatomic) IBOutlet UIView *scroll_view;
@property (weak, nonatomic) IBOutlet UIView *ct_levels_view;
@property (weak, nonatomic) IBOutlet UISlider *cine_slider;
@property (weak, nonatomic) IBOutlet UIView *cine_view;

@property (weak, nonatomic) IBOutlet UILabel *v_bar_label_drag_scroll;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe_on_mousepad_gesture;
-(NSString*)getKeyCodesForAction:(NSString*)action;
@property (weak, nonatomic) IBOutlet UIView *xray_series_view;
@property (weak, nonatomic) IBOutlet UIView *sliding_scroll_view;
@property (weak, nonatomic) IBOutlet UIView *ct_func_btns_view;
@property (weak, nonatomic) IBOutlet UIView *ultrasound_func_btns_view;
@property (weak, nonatomic) IBOutlet UIView *xray_func_btns_view;
-(void)pressKeys:(NSString*) keys;
@property (weak, nonatomic) IBOutlet UIButton *menu_release;
@property NSTimeInterval time_last_pad_click;
@property bool needs_to_mouseup_on_endpan;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *middle_click;
-(void)performKeyAction:(NSString*) action;
@property (weak, nonatomic) IBOutlet UILabel *scroller_active_label;

@property NSString *defaultBackgroundPath;
@property (weak, nonatomic) IBOutlet UILabel *scroll_area_label;
@property (weak, nonatomic) IBOutlet UILabel *popout_menu_mask;


@property NSMutableDictionary *key_mappings;
-(void) initKeyMappings;
@property NSString *currKeyScheme;

@end