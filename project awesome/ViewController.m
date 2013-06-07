//
//  ViewController.m
//  project awesome
//
//  Created by Department of Radiology on 5/9/13.
//  Copyright (c) 2013 Department of Radiology. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController (){
    PopOverScreen *popScreen;
    UIPopoverController *popoverController;
    bool createAccount;
    bool login;
    
    NSString *currBackgroundPicture;
    NSString *currButtonPicture;
    NSString *currProfileName;
}

@end


@implementation ViewController



@synthesize btnCustomize;

-(void)ToDefault:(NSNotification *)Data {
    currBackgroundPicture = self.defaultBackgroundPath;
    currButtonPicture = @"None";
    
    [self UpdateScreen:nil];
    
    if ([popoverController isPopoverVisible]) {
        [popoverController dismissPopoverAnimated:YES];
    }
}

-(void)SetButtonBackground:(NSString*)name {
    currButtonPicture = name;
    
    //  UIButton *button = [UIButton appearance];
    //  [button set/BackgroundImage:[UIImage imageNamed:@"button.png"]
    //      forState:UIControlStateNormal];
    
    // [[UIButton appearance] setBackButtonBackgroundImage:customBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    for (UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UIButton class]])
        {
            UIImage *customBackground = [UIImage imageNamed:name];
            
            if([name isEqualToString:@"None"]) {
                customBackground = nil;
            }
            
            UIButton *btn = (UIButton*)view;
            
            [btn setBackgroundImage:customBackground
                           forState:UIControlStateNormal];
        }
    }

}

- (void)changeBackgroundView:(NSNotification *)Data {
    NSString *filename = [Data userInfo];
    currBackgroundPicture = filename;
    NSLog(currBackgroundPicture);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:(NSString *)filename]];
    
    for (UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UIView class]]) {
            UIView *tmp = (UIView*)view;
            
            //tmp.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[Data userInfo]]];
        }
    }
    
    [popoverController dismissPopoverAnimated:YES];
    [popScreen dismissBackgroundPop];
}

- (void)SetIP:(NSNotification *)Data {
    [self set_ip_button:self];
    [popoverController dismissPopoverAnimated:YES];
}

-(void)changeButtonShape:(NSNotification *)Data{
    NSString *filename = [Data userInfo];
    [self SetButtonBackground:filename];
    [popScreen dismissButtonPop];
    [popoverController dismissPopoverAnimated:YES];
}

- (IBAction)menuTrigger:(id)sender {
    [self CustomizeScreen:sender];
}


- (IBAction)CustomizeScreen:(id)sender {
    
    if ([popoverController isPopoverVisible]) {
        [popoverController dismissPopoverAnimated:YES];
    } else {
        //the rectangle here is the frame of the object that presents the popover,
        //in this case, the UIButton…
        
        
        CGRect popRect = CGRectMake(10,
                                    10,
                                    self.btnCustomize.width,
                                    self.btnCustomize.width);
        [popoverController presentPopoverFromRect:popRect
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    }
}




- (void)get_url:(NSString*)url {
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}
- (void)send_input:(NSString*)str {
    NSString *base = [NSString stringWithFormat:@"http://%@/%@", self.ip_field.text, str];
    [self get_url:base];
}

-(void) SetKeyMappings:(NSNotification *)Data {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Key Mappings" message:@"Choose the name of the program you are using" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Osirix", @"GE", nil];
    [alert setAlertViewStyle:UIAlertViewStyleDefault];
    [alert setTag:3];
    [alert show];
    [popoverController dismissPopoverAnimated:YES];

}

-(void) initKeyMappings {
    self.key_mappings = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *osirix_mappings = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *GE_mappings = [[NSMutableDictionary alloc] init];

    
    [GE_mappings setObject:@"65" forKey:@"Annotate"];
    [GE_mappings setObject:@"68" forKey:@"Dist"];
    [GE_mappings setObject:@"82" forKey:@"ROI"];
    [GE_mappings setObject:@"83" forKey:@"Select"];
    [GE_mappings setObject:@"67" forKey:@"Cine"];
    [GE_mappings setObject:@"80" forKey:@"Deselect"];
    [GE_mappings setObject:@"79" forKey:@"Reset"];
    [GE_mappings setObject:@"66" forKey:@"Smat"];
    [GE_mappings setObject:@"86" forKey:@"Screen-Cine"];
    [GE_mappings setObject:@"76" forKey:@"Angle"];
    [GE_mappings setObject:@"38" forKey:@"NextSeries"];
    [GE_mappings setObject:@"40" forKey:@"PrevSeries"];
    [GE_mappings setObject:@"38" forKey:@"NextPatient"];
    [GE_mappings setObject:@"40" forKey:@"PrevPatient"];
    
    
    
    
    [osirix_mappings setObject:@"84" forKey:@"Annotate"];
    [osirix_mappings setObject:@"76" forKey:@"Dist"];
    [osirix_mappings setObject:@"82" forKey:@"ROI"];
    [osirix_mappings setObject:@"83" forKey:@"Select"];
    [osirix_mappings setObject:@"67" forKey:@"Cine"];
    [osirix_mappings setObject:@"80" forKey:@"Deselect"];
    [osirix_mappings setObject:@"91,82" forKey:@"Reset"];
    [osirix_mappings setObject:@"66" forKey:@"Smat"];
    [osirix_mappings setObject:@"86" forKey:@"Screen-Cine"];
    [osirix_mappings setObject:@"65" forKey:@"Angle"];
    [osirix_mappings setObject:@"91,39" forKey:@"NextSeries"];
    [osirix_mappings setObject:@"91,37" forKey:@"PrevSeries"];
    [osirix_mappings setObject:@"38,91,39" forKey:@"NextPatient"];
    [osirix_mappings setObject:@"38,91,37" forKey:@"PrevPatient"];
    
    
    
    [self.key_mappings setObject:osirix_mappings forKey:@"Osirix"];
    [self.key_mappings setObject:GE_mappings forKey:@"GE"];
}

-(NSString*)getKeyCodesForAction:(NSString*)action {
    NSMutableDictionary *dict = [self.key_mappings objectForKey:self.currKeyScheme];
    return [dict objectForKey:action];
}

-(void)pressKeys:(NSString*) keys {
    [self send_input:[@"input=keyboard&keycodes=" stringByAppendingString:keys]];
}

-(void)performKeyAction:(NSString*) action {
    NSString *keycodes = [self getKeyCodesForAction:action];
    [self pressKeys:keycodes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initKeyMappings];
    self.currKeyScheme = @"Osirix";
    
    UIImage *customBackground = [UIImage imageNamed:@"play.png"];
    [self.cine_play_pause_btn setBackgroundImage:customBackground
                   forState:UIControlStateNormal];
    [self.cine_play_pause_btn setTitleColor:[UIColor clearColor]  forState:UIControlStateNormal];
    [self.cine_play_pause_btn setTitleColor:[UIColor clearColor]  forState:UIControlStateHighlighted];
    self.cine_play_pause_btn.layer.cornerRadius = 50;
    
    createAccount = false;
    login = false;
    
    currBackgroundPicture = self.defaultBackgroundPath;
    currButtonPicture = @"None";
    currProfileName = @"None";
    
    popScreen = [[PopOverScreen alloc] initWithNibName:@"PopOverScreen" bundle:nil];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:popScreen];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBackgroundView:) name:@"ChangeBackground" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonShape:) name:@"ChangeButton" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToDefault:) name:@"MakeDefault" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SaveSettings:) name:@"SaveSettings" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SetIP:) name:@"SetIP" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SetKeyMappings:) name:@"SetKeyMappings" object:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self.mousepad.layer setBorderWidth:4.0];
    [self.left_click_label.layer setBorderWidth:4.0];
    [self.right_click_label.layer setBorderWidth:4.0];
    
    UIColor *borderColor = [UIColor colorWithRed:82.0f/255.0f green:148.0f/255.0f blue:199.0f/255.0f alpha:1];
    [self.mousepad.layer setBorderColor: borderColor.CGColor];
    [self.left_click_label.layer setBorderColor: borderColor.CGColor];
    [self.right_click_label.layer setBorderColor: borderColor.CGColor];
     
    self.counter = 0;
    [self.two_finger_right setNumberOfTouchesRequired:2];
    [self.left_hold setMinimumPressDuration:0];
    self.inZoomMode = false;
    self.inPanMode = false;
    [self.z_tap_twice setNumberOfTouchesRequired:2];
    //CGAffineTransform trans = zCGAffineTransformMakeRotation(M_PI * 0.5);
    //self.scroll_view.transform = trans;
    self.scrollerPrevYOffset = 0.0;
    [self.swipe_on_mousepad_gesture setNumberOfTouchesRequired:2];
    [self.swipe_on_mousepad_gesture setDirection: UISwipeGestureRecognizerDirectionRight];
    [self.left_swipe_mousepad setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.left_swipe_mousepad setNumberOfTouchesRequired:2];
    [self.mouse_pan setMaximumNumberOfTouches:3];
    self.time_last_pad_click = 0;
    self.needs_to_mouseup_on_endpan = false;
    [self.middle_click setNumberOfTouchesRequired:3];
    
    self.defaultBackgroundPath = @"texture1.jpg";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:self.defaultBackgroundPath]];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"scroll-wheel1.jpg"] drawInRect:self.scroll_area_label.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.scroll_area_label.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.popout_view.layer.cornerRadius = 10;
    self.popout_view.layer.masksToBounds = YES;
    [self.popout_view.layer setBorderColor: borderColor.CGColor];
    [self.popout_view.layer setBorderWidth:5.0f];
    
    [self.v_bar_label_drag_scroll setBackgroundColor:borderColor];
    self.v_bar_label_drag_scroll.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}

- (void)viewDidUnload {
    [self setMousepad:nil];
    [self setMousepad:nil];
    [self setLeft_click_label:nil];
    [self setRight_click_label:nil];
    [self setTest_output:nil];
    [self setMouse_pan:nil];
    [self setMouse_pan:nil];
    [self setMouse_pan:nil];
    [self setTap_click:nil];
    [self setLeft_click_gesture:nil];
    [self setRight_click_gest:nil];
    [self setTwo_finger_right:nil];
    [self setIp_field:nil];
    [self setW1:nil];
    [self setW2:nil];
    [self setW3:nil];
    [self setW4:nil];
    [self setW5:nil];
    [self setA:nil];
    [self setB:nil];
    [self setR:nil];
    [self setD:nil];
    [self setL:nil];
    [self setLeft_hold:nil];
    [self setDynamic_level:nil];
    [self setDynamic_zoom:nil];
    [self setLevel_mask:nil];
    [self setLevel_pan:nil];
    [self setTwo_finger_pan_mask:nil];
    [self setZ:nil];
    [self setOn_z_pan:nil];
    [self setZ_tap:nil];
    [self setZ_tap_twice:nil];
    [self setOverlay:nil];
    [self setSlider:nil];
    [self setSliding_button:nil];
    [self setPopout_view:nil];
    [self setScroll_view:nil];
    [self setCt_levels_view:nil];
    [self setCine_slider:nil];
    [self setSwipe_on_mousepad_gesture:nil];
    [self setXray_series_view:nil];
    [self setSliding_scroll_view:nil];
    [self setCt_func_btns_view:nil];
    [self setUltrasound_func_btns_view:nil];
    [self setXray_func_btns_view:nil];
    [self setCine_view:nil];
    [self setMenu_release:nil];
    [self setLeft_swipe_mousepad:nil];
    [self setBtnCustomize:nil];
    [self setBtnLogIn:nil];
    [self setBtnCreateAccount:nil];
    [self LogIn:nil];
    [self AddAccount:nil];
    
    [self setMiddle_click:nil];
    [self setScroll_area_label:nil];
    [self setScroller_active_label:nil];
    [self setPopout_menu_mask:nil];
    [self setV_bar_label_drag_scroll:nil];
    [self setCine_play_pause_btn:nil];
    [super viewDidUnload];
}

- (IBAction)on_pan:(id)sender {
    
    if([sender numberOfTouches] == 2 && !self.inPanMode && !self.inZoomMode) {
        [self scrollerFun:sender :0.32];
        return;
    }
    
    if([sender numberOfTouches] == 3) {
        [self scrollerFun:sender :1.28];
        return;
    }

    
    if([sender state] == UIGestureRecognizerStateBegan)
    {
        NSDate *date = [NSDate date];
        if([date timeIntervalSince1970] - self.time_last_pad_click < 0.36) {
            self.needs_to_mouseup_on_endpan = true;
            [self send_input:@"input=mouse&event=left_down"];
        }
    }
    
    self.counter++;
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
  
    int max_component = MAX(abs(velocity.x), abs(velocity.y));
    int l_scale;
    if(max_component < 500) {
        l_scale = 25;
    } else if (max_component > 5000) {
        l_scale = 7;
    } else {
        l_scale = (max_component - 500.0) / 4500.0 * 18.0 + 7;
    }
    
    float trans_x = velocity.x / l_scale;
    float trans_y = velocity.y / l_scale;
    
    if(abs(trans_x) < 2 && abs(trans_y) < 2) {
        if (abs(trans_x) > abs(trans_y)) {
            trans_x = trans_x > 0 ? 2 : -2;
        } else {
            trans_x = trans_x > 0 ? 2 : -2;
        }
    }
    
    int x_step = (int) trans_x;
    int y_step = (int) trans_y;
    int num_steps = 1;
    int remainder_x = 0;
    int remainder_y = 0;
    
    if (trans_x > 10 && trans_y > 10) {
        x_step /= 10;
        y_step /= 10;
        num_steps = 10;
        remainder_x = (int) trans_x % 10;
        remainder_y = (int) trans_y % 10;
    }
    
    
    if (self.counter % 2 == 0) {
        NSString *event1 = [NSString stringWithFormat:@"input=mouse&event=move&x-step=%d&y-step=%d&num-steps=%d&delay=2", x_step, y_step, num_steps];
        
        NSString *event2 = [NSString stringWithFormat:@"input=mouse&event=move&x-step=%d&y-step=%d&num-steps=%d&delay=2", remainder_x, remainder_y, 1];

        //self.label.text = [NSString stringWithFormat:@"%2f, %2f, %d", velocity.x, velocity.y,
                           //self.counter];
        [self send_input:event1];
        [self send_input:event2];
    }
    
    if([sender state] == UIGestureRecognizerStateEnded)
    {
        // only in here for the hell of it
        self.counter = 0;
        if (self.needs_to_mouseup_on_endpan) {
            [self send_input:@"input=mouse&event=left_up"];
            self.needs_to_mouseup_on_endpan = false;
        }
    }
}


- (IBAction)on_middle_click:(id)sender {
    [self send_input:@"input=mouse&event=middle_click"];
}

- (IBAction)left_click:(id)sender {
    [self send_input:@"input=mouse&event=click"];
    NSDate *date = [NSDate date];
    self.time_last_pad_click = [date timeIntervalSince1970];
}
- (IBAction)right_click:(id)sender {
    [self send_input:@"input=mouse&event=right_click"];
}
- (IBAction)on_w1:(id)sender {
    [self send_input:@"input=keyboard&keycodes=49"];
}
- (IBAction)on_w2:(id)sender {
    [self send_input:@"input=keyboard&keycodes=50"];
}
- (IBAction)on_w3:(id)sender {
    [self send_input:@"input=keyboard&keycodes=51"];
}
- (IBAction)on_w4:(id)sender {
    [self send_input:@"input=keyboard&keycodes=52"];
}
- (IBAction)on_w5:(id)sender {
    [self send_input:@"input=keyboard&keycodes=53"];
}
- (IBAction)on_annotate:(id)sender {
    [self send_input:@"input=keyboard&keycodes=65"];
}
- (IBAction)on_b:(id)sender {
    [self send_input:@"input=keyboard&keycodes=66"];
}
- (IBAction)on_r:(id)sender {
    [self send_input:@"input=keyboard&keycodes=73"];
}
- (IBAction)on_dist:(id)sender {
    [self performKeyAction:@"Dist"];
}
- (IBAction)on_cin:(id)sender {
    [self performKeyAction:@"Cine"];
}
- (IBAction)on_select:(id)sender {
    [self performKeyAction:@"Select"];
}
- (IBAction)on_deselect:(id)sender {
    [self performKeyAction:@"Deselect"];
}
- (IBAction)on_roi:(id)sender {
    [self performKeyAction:@"ROI"];
}
- (IBAction)on_reset:(id)sender {
    [self performKeyAction:@"Reset"];
}
- (IBAction)on_smat:(id)sender {
    [self performKeyAction:@"Smat"];
}
- (IBAction)on_screen_cine:(id)sender {
    [self performKeyAction:@"Screen-Cine"];
}
- (IBAction)on_angle:(id)sender {
    [self performKeyAction:@"Angle"];
}
- (IBAction)on_6:(id)sender {
    [self send_input:@"input=keyboard&keycodes=54"];
}
- (IBAction)on_7:(id)sender {
    [self send_input:@"input=keyboard&keycodes=55"];
}
- (IBAction)on_8:(id)sender {
    [self send_input:@"input=keyboard&keycodes=56"];
}
- (IBAction)on_9:(id)sender {
    [self send_input:@"input=keyboard&keycodes=57"];
}
- (IBAction)on_10:(id)sender {
    [self send_input:@"input=keyboard&keycodes=48"];
}


- (IBAction)left_hold:(id)sender {
    if ([sender state] == UIGestureRecognizerStateBegan) {
        [self send_input:@"input=mouse&event=left_down"];
    }
    if ([sender state] == UIGestureRecognizerStateEnded) {
        [self send_input:@"input=mouse&event=left_up"];
    }
}

- (IBAction)on_dynamic_level:(id)sender {
    [self send_input:@"input=keyboard&keycodes=87"];
}

- (void) mask:(id)elem {
    [self.view bringSubviewToFront:self.level_mask];
    [self.view bringSubviewToFront:elem];
    self.level_mask.alpha = 0.8;
    [self.level_mask setFrame:CGRectMake(0,0,self.view.frame.size.height, self.view.frame.size.width)];
    self.level_mask.backgroundColor = [UIColor blackColor];
    self.level_mask.userInteractionEnabled = true;
    self.level_mask.hidden = false;
}

- (void) overlay:(id) elem {
    [self.view bringSubviewToFront:elem];
    [elem setAlpha:0.1];
    [elem setBackgroundColor:[UIColor blackColor]];
    [elem setFrame:CGRectMake(0,0,self.view.frame.size.height, self.view.frame.size.width)];
    [elem setUserInteractionEnabled:true];
    [elem setHidden:false];
}

- (void) un_overlay:(id) elem {
    [elem setHidden:true];
    [elem setUserInteractionEnabled:false];
}

- (void) unmask:(id)sender {
    self.level_mask.hidden = true;
    self.level_mask.userInteractionEnabled = false;
}
- (IBAction)on_two_finger_pan_overlay:(id)sender {
    if ([sender state] == UIGestureRecognizerStateBegan) {
        [self send_input:@"input=mouse&event=up,key,down&keycode=77"];
    } else if ([sender state] == UIGestureRecognizerStateEnded) {
        if (self.inZoomMode || self.inPanMode) {
            [self send_input:@"input=mouse&event=up,key,down&keycode=90"];
        } else {
            [self send_input:@"input=mouse&event=up,key&keycode=90"];
        }
    }
}

- (IBAction)on_level_pan:(id)sender {
    if ([sender state] == UIGestureRecognizerStateBegan) {
        [self mask:self.dynamic_level];
        [self send_input:@"input=keyboard&keycodes=87"];
        [self send_input:@"input=mouse&event=left_down"];
    } else if ([sender state] == UIGestureRecognizerStateEnded) {
        [self unmask:self.dynamic_level];
        [self send_input:@"input=mouse&event=left_up"];
    } else {
        [self on_pan:sender];
    }
}

- (IBAction)on_z_pan:(id)sender {
    if ([sender state] == UIGestureRecognizerStateBegan) {
        [self mask:self.z];
        [self overlay:self.overlay];
        [self on_z:sender];
        [self send_input:@"input=mouse&event=left_down"];
        if ([sender numberOfTouches] == 1) {
            self.inZoomMode = true;
            self.inPanMode = false;
        } else if ([sender numberOfTouches] == 2) {
            self.inZoomMode = false;
            self.inPanMode = true;
        }
    } else if ([sender state] == UIGestureRecognizerStateEnded) {
        [self unmask:self.z];
        [self un_overlay:self.overlay];
        self.inPanMode = false;
        self.inZoomMode = false;
        usleep(15000);
        [self send_input:@"input=mouse&event=left_up"];
    } else {
        if (self.inPanMode && [sender numberOfTouches] == 1) {
            [self on_z:sender];
            [self send_input:@"input=mouse&event=left_up"];
            [self send_input:@"input=mouse&event=left_down"];
            self.inPanMode = false;
            self.inZoomMode = true;
        }
        [self on_pan:sender];
    }
}
- (IBAction)on_next_series:(id)sender {
    [self performKeyAction:@"NextSeries"];
}
- (IBAction)on_prev_series:(id)sender {
    [self performKeyAction:@"PrevSeries"];
}

- (IBAction)on_next_patient:(id)sender {
    [self performKeyAction:@"NextPatient"];
}
- (IBAction)on_prev_patient:(id)sender {
    [self performKeyAction:@"PrevPatient"];
}

- (void)on_z:(id)sender {
    if ([sender numberOfTouches] == 1) {
        [self send_input:@"input=keyboard&keycodes=90"];
    } else if ([sender numberOfTouches] == 2) {
        [self send_input:@"input=keyboard&keycodes=77"];
    }
}
- (IBAction)on_z_once:(id)sender {
    [self on_z:sender];
}
- (IBAction)on_z_tap_twice:(id)sender {
    [self on_z:sender];
}
-(void) tick:(NSTimer *)timer {
    NSString *str = [NSString stringWithFormat:@"input=mouse&event=scroll&scroll=%d", self.const_scroll_factor];
    [self send_input:str];
}
- (IBAction)on_slide_button:(id)sender {
    if ([sender state] == UIGestureRecognizerStateBegan) {
        self.original_slider_center = self.sliding_button.center.y;
        self.const_scroll_timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                   target:self
                                                                 selector:@selector(tick:)
                                                                 userInfo:nil
                                                             repeats:YES];
    } else if ([sender state] == UIGestureRecognizerStateEnded) {
        [self.sliding_button setCenter:CGPointMake(self.sliding_button.center.x, self.original_slider_center)];
        [self.const_scroll_timer invalidate];
    } else {
        CGPoint translation = [sender translationInView:self.view];
        [self.sliding_button setCenter:CGPointMake(self.sliding_button.center.x, self.original_slider_center + translation.y)];
        self.const_scroll_factor = (int) (translation.y / 10);
    }
}

- (void)sendScrollSignal:(int)movement {
    [self send_input:[NSString stringWithFormat:@"input=mouse&event=scroll&scroll=%d", movement]];
}

- (double)getScrollerCurYOffset:(id)sender {
    double blah = 1.0 * [(UIPanGestureRecognizer*)sender translationInView:self.view].y;
    //printf("blah=%f\n", blah);
    return blah;
}

- (int)computeScrollerNecessaryMovement:(double)curYOffset :(double)movementsPerPixel {
    double idealNumMovements = (curYOffset - self.scrollerPrevYOffset) * movementsPerPixel;
    int actualNumMovements = (int)round(idealNumMovements);
    
    self.scrollerPrevYOffset += actualNumMovements / movementsPerPixel;
    //printf("actualNumMovements=%d\n",actualNumMovements);
    return actualNumMovements;
}

- (void)checkForNewScrollGesture:(id)sender {
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        self.scrollerPrevYOffset = 0.0;
        //printf("woof!\n");
    }
}

- (void)scrollerFun:(id)sender :(double)movementsPerPixel {
    [self checkForNewScrollGesture:sender];
    double curYOffset = [self getScrollerCurYOffset:sender];
    int movement = [self computeScrollerNecessaryMovement:curYOffset :movementsPerPixel];
    if (movement != 0) {
        [self sendScrollSignal:movement];
    }
}


- (IBAction)handleScroll:(id)sender {
    if ([(UIPanGestureRecognizer*)sender numberOfTouches] == 1) {
        //printf("1\n");
        [self scrollerFun:sender :0.08];
    } else if ([(UIPanGestureRecognizer*)sender numberOfTouches] == 2) {
        //printf("2\n");
        [self scrollerFun:sender :0.32];
    } else if ([(UIPanGestureRecognizer*)sender numberOfTouches] >= 3) {
        //printf("3\n");
        [self scrollerFun:sender :1.28];
    }
}

//Use for when someone is trying to log into their account
- (IBAction)LogIn:(id)sender {
    login = true;
    createAccount = false;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In" message:@"Enter Your Profile Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *textField = [alert textFieldAtIndex:0];
    [alert setTag:1];
    [alert show];
}

-(void)UpdateScreen:(NSString *)name{
    //Update background color
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:currBackgroundPicture]];
    
    UIImage *customBackground = [UIImage imageNamed:currButtonPicture];
    
    //  UIButton *button = [UIButton appearance];
    //  [button set/BackgroundImage:[UIImage imageNamed:@"button.png"]
    //      forState:UIControlStateNormal];
    
    // [[UIButton appearance] setBackButtonBackgroundImage:customBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    for (UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)view;
            
            [btn setBackgroundImage:customBackground
                           forState:UIControlStateNormal];
        }
    }
    
}

//
-(void)LoginToProfile:(NSString *)name{
  /*
    NSString *filePath = [[@"/Users/christopherfontas/Desktop/Stanford/Senior_Year/cs194/Radiology-master/Profiles/" stringByAppendingString:name] stringByAppendingString:@".txt"];
    NSLog(filePath);
    NSString *filesContent = [[NSString alloc] initWithContentsOfFile:filePath];
    
    NSLog(@"CONTENT!");
    NSLog(filesContent);
 */
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if([prefs objectForKey:name]){
        NSMutableDictionary *dictionary = (NSMutableDictionary*)[prefs objectForKey:name];
        
        NSLog(@"Welcome!");
        currProfileName = name;
        currBackgroundPicture = [dictionary objectForKey:@"background"];
        currButtonPicture = [dictionary objectForKey:@"buttons"];
        self.ip_field.text = [dictionary objectForKey:@"ip"];
        
        [self UpdateScreen:name];
    }else{
        NSLog(@"That profile doesn't exist");
    }
    
}

-(void)SaveSettings:(NSNotification *)Data {
    
    if(![currProfileName isEqual: @"None"]){
        
        NSLog(@"SAVING!");
        NSLog(currProfileName);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
      
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:currBackgroundPicture forKey:@"background"];
        [dictionary setObject:currButtonPicture forKey:@"buttons"];
        [dictionary setObject:self.ip_field.text forKey:@"ip"];
        
        [prefs setObject:dictionary forKey:currProfileName];
    }
    
    if ([popoverController isPopoverVisible]) {
        [popoverController dismissPopoverAnimated:YES];
    }
}


-(void)AddAccount:(NSString *)name{
    
    //Check to see if name is already taken
  
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
      
    if ([prefs objectForKey:name]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"User name already taken"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert setAlertViewStyle:UIAlertViewStyleDefault];
        [alert show];
        return;
    }
    
    NSLog(@"Adding account");
    currProfileName = name;
    [prefs setObject:@"" forKey:name];
    [self SaveSettings:nil];
    [popoverController dismissPopoverAnimated:YES];
}
/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *name = [alertView textFieldAtIndex:0].text;
        // name contains the entered value
        NSLog(name);
        if(login){
            [self LoginToProfile:name];
        } else if(createAccount){
            [self AddAccount:name];
        }

    }
}*/

//Use when someone is trying to create a new account.
- (IBAction)CreateAccount:(id)sender {
    createAccount = true;
    login = false;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create Account" message:@"Enter Your Desired Profile Name Please" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *textField = [alert textFieldAtIndex:0];
    [alert setTag:2];
    [alert show];
}

- (IBAction)set_ip_button:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"IP" message:@"Enter the IP address of the workstation" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.text = self.ip_field.text;
    [alert setTag:0];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    // ip field
    if (alertView.tag == 0) {
        if (buttonIndex == 1) {
            self.ip_field.text = [[alertView textFieldAtIndex:0] text];
        }
    } else if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            NSString *name = [[alertView textFieldAtIndex:0] text];
            [self LoginToProfile:name];
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            NSString *name = [[alertView textFieldAtIndex:0] text];
            [self AddAccount:name];
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            self.currKeyScheme = @"Osirix";
        } else if (buttonIndex == 1) {
            self.currKeyScheme = @"GE";
        }
    }
}

- (IBAction)popout_show:(id)sender {
    if ([[sender titleLabel].text isEqualToString:@">"]) {
        [sender setTitle:@"<" forState:UIControlStateNormal];
        [self mask:self.popout_menu_mask];
        [self.view bringSubviewToFront:self.popout_view];
        [self.view bringSubviewToFront:self.menu_release];
        self.popout_view.hidden = false;
        
    } else {
        [sender setTitle:@">" forState:UIControlStateNormal];
        self.popout_view.hidden = true;
        [self unmask:self.popout_menu_mask];
    }
}

- (IBAction)start_cine_play:(id)sender {
    if ([[sender titleLabel].text isEqualToString:@"|>"]) {
        [self cine_slider_change:sender];
        self.const_scroll_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        [sender setTitle:@"||" forState:UIControlStateNormal];
         UIImage *customBackground = [UIImage imageNamed:@"pause.png"];
        [self.cine_play_pause_btn setBackgroundImage:customBackground
                                            forState:UIControlStateNormal];
    } else {
        [self end_cine_play:sender];
        [sender setTitle:@"|>" forState:UIControlStateNormal];
        UIImage *customBackground = [UIImage imageNamed:@"play.png"];
        [self.cine_play_pause_btn setBackgroundImage:customBackground
                                            forState:UIControlStateNormal];
    }
}

- (IBAction)end_cine_play:(id)sender {
    [self.const_scroll_timer invalidate];
}
- (IBAction)cine_slider_change:(id)sender {
    self.const_scroll_factor = (int) (self.cine_slider.value * 20);
}
- (IBAction)swipe_on_mousepad2:(id)sender {
    // right mousepad swipe, 2 fingers
    //self.test_output.text = @"Right";
    [self performKeyAction:@"NextSeries"];
}
- (IBAction)swipe_on_mousepad1:(id)sender {
    // left mousepad swipe, 2 fingers
    //self.test_output.text = @"Left";
    [self performKeyAction:@"PrevSeries"];
}


- (IBAction)show_ct_screen:(id)sender {
    self.ct_func_btns_view.hidden = false;
    
    self.xray_func_btns_view.hidden = true;
    self.xray_series_view.hidden = true;
    self.ultrasound_func_btns_view.hidden = true;
    
    self.scroll_view.hidden = false;
    self.sliding_scroll_view.hidden = false;
    self.cine_view.hidden = true;
    [self popout_show:self.menu_release];
}
- (IBAction)show_ultrasound:(id)sender {
    self.ct_func_btns_view.hidden = true;
    
    self.xray_func_btns_view.hidden = true;
    self.xray_series_view.hidden = true;
    self.ultrasound_func_btns_view.hidden = false;
    
    self.scroll_view.hidden = true;
    self.sliding_scroll_view.hidden = false;
    self.cine_view.hidden = false;
    [self popout_show:self.menu_release];
}
- (IBAction)show_xray_screen:(id)sender {
    self.ct_func_btns_view.hidden = true;
    
    self.xray_func_btns_view.hidden = FALSE;
    self.xray_series_view.hidden = FALSE;
    self.ultrasound_func_btns_view.hidden = TRUE;
    
    self.scroll_view.hidden = true;
    self.sliding_scroll_view.hidden = true;
    self.cine_view.hidden = true;
    [self popout_show:self.menu_release];
}

- (IBAction)on_tap_popout_mask:(id)sender {
    [self popout_show:self.menu_release];
}




@end