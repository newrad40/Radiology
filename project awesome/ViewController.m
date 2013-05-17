//
//  ViewController.m
//  project awesome
//
//  Created by Department of Radiology on 5/9/13.
//  Copyright (c) 2013 Department of Radiology. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController


- (void)get_url:(NSString*)url {
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}
- (void)send_input:(NSString*)str {
    NSString *base = [NSString stringWithFormat:@"http://%@/%@", self.ip_field.text, str];
    [self get_url:base];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.mousepad.layer setBorderWidth:4.0];
    [self.left_click_label.layer setBorderWidth:4.0];
    [self.right_click_label.layer setBorderWidth:4.0];
    self.counter = 0;
    [self.two_finger_right setNumberOfTouchesRequired:2];
    [self.left_hold setMinimumPressDuration:0];
    self.inZoomMode = false;
    self.inPanMode = false;
    [self.z_tap_twice setNumberOfTouchesRequired:2];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * 0.5);
    self.slider.transform = trans;
    self.scrollerPrevYOffset = 0.0;
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
    [super viewDidUnload];
}

- (IBAction)on_pan:(id)sender {
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
    }
}

- (IBAction)left_click:(id)sender {
    [self send_input:@"input=mouse&event=click"];
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
- (IBAction)on_a:(id)sender {
    [self send_input:@"input=keyboard&keycodes=65"];
}
- (IBAction)on_b:(id)sender {
    [self send_input:@"input=keyboard&keycodes=66"];
}
- (IBAction)on_r:(id)sender {
    [self send_input:@"input=keyboard&keycodes=73"];
}
- (IBAction)on_d:(id)sender {
    [self send_input:@"input=keyboard&keycodes=68"];
}
- (IBAction)on_l:(id)sender {
    [self send_input:@"input=keyboard&keycodes=76"];
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
        [self send_input:@"input=keyboard&keycodes=77"];
        [self send_input:@"input=mouse&event=left_up"];
        [self send_input:@"input=mouse&event=left_down"];
    } else if ([sender state] == UIGestureRecognizerStateEnded) {
        [self send_input:@"input=keyboard&keycodes=90"];
        [self send_input:@"input=mouse&event=left_up"];
        if (self.inZoomMode || self.inPanMode) {
            [self send_input:@"input=mouse&event=left_down"];
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
    //self.test_output.text = [NSString stringWithFormat:@"input=mouse&event=scroll&scroll=%d", self.const_scroll_factor];
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
    char buf[1024];
    sprintf(buf, "http://10.31.37.33/input=mouse&event=scroll&scroll=%d", movement);
    NSString * serverAddress = @(buf);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
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
@end