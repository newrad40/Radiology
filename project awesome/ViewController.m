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



@end
