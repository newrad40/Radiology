//
//  PopOverScreen.m
//  project awesome
//
//  Created by Christopher Fontas on 5/29/13.
//  Copyright (c) 2013 Department of Radiology. All rights reserved.
//

#import "PopOverScreen.h"
#import "ViewController.h"

@interface PopOverScreen (){
    ButtonOptions *buttonScreen;
    UIPopoverController *buttonController;
    BackGroundOptions *backgroundScreen;
    UIPopoverController *backgroundController;
    ViewController *parentVC;
}

@end

@implementation PopOverScreen


@synthesize optionsArray;

-(void)dismissBackgroundPop{
    [backgroundController dismissPopoverAnimated:YES];
}

-(void)dismissButtonPop {
    [buttonController dismissPopoverAnimated:YES];
}

-(void)ShowButtonOptions{
    
    if ([buttonController isPopoverVisible]) {
        [buttonController dismissPopoverAnimated:YES];
    } else {
        //the rectangle here is the frame of the object that presents the popover,
        //in this case, the UIButton…
        
        
        CGRect popRect = CGRectMake(10,
                                    10,
                                    150,
                                    150);
        [buttonController presentPopoverFromRect:popRect
                                              inView:self.view
                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                            animated:YES];
    }
}


- (void)ShowBackgroundOptions
{
    if ([backgroundController isPopoverVisible]) {
        [backgroundController dismissPopoverAnimated:YES];
    } else {
        //the rectangle here is the frame of the object that presents the popover,
        //in this case, the UIButton…
        
        
        CGRect popRect = CGRectMake(10,
                                    10,
                                    150,
                                    150);
        [backgroundController presentPopoverFromRect:popRect
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    }
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.optionsArray =
    [NSArray arrayWithObjects:@"Background", @"Buttons", @"Save Settings", @"Revert to Default", @"Set IP", @"Set Key Mappings", nil];
    
    backgroundScreen = [[BackGroundOptions alloc] initWithNibName:@"BackGroundOptions" bundle:nil];
    backgroundController = [[UIPopoverController alloc] initWithContentViewController:backgroundScreen];
    
    
    buttonScreen = [[ButtonOptions alloc] initWithNibName:@"ButtonOptions" bundle:nil];
    
    buttonController = [[UIPopoverController alloc] initWithContentViewController:buttonScreen];
    
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.optionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.optionsArray objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    int selectedEntry = indexPath.row;
    switch(selectedEntry){
        case 0:
            [self ShowBackgroundOptions];
            break;
        case 1:
          [self ShowButtonOptions];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveSettings" object:self userInfo:@""];
            break;
        case 3:
             [[NSNotificationCenter defaultCenter] postNotificationName:@"MakeDefault" object:self userInfo:@""];
            break;
        case 4:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SetIP" object:self userInfo:@""];
            break;
        case 5:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SetKeyMappings" object:self userInfo:@""];
            break;
    }

}



@end
