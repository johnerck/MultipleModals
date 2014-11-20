//
//  ViewController.m
//  MultipleModals
//
//  Created by John Erck on 11/20/14.
//  Copyright (c) 2014 Above Market. All rights reserved.
//

#import "ViewController.h"
#import "MyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static BOOL doAgain = YES; // So when red appears again, we don't endlessly cycle (for testing)
- (void)viewDidAppear:(BOOL)animated
{
    // Invoke super
    [super viewDidAppear:animated];
    
    // Prevent loop when we dismiss all the way back to red (for testing)
    if (doAgain)
    {
        // Okay here's where the demo code starts...
        
        // PRESENTING a full stack of modals WITHOUT animation WORKS and results in the user
        // only seeing orange when this red view controller "appears" (red never actually appears, which is great)...
        
        MyViewController *purple = [[MyViewController alloc] init];
        purple.title = @"purple"; // For use in MyViewController's dealloc method
        purple.view.backgroundColor = [UIColor purpleColor];
        [self presentViewController:purple animated:NO completion:^{ // Purple successfully gets presented and the user never sees purple, great.
            NSLog(@"Purple?");
            MyViewController *green = [[MyViewController alloc] init];
            green.view.backgroundColor = [UIColor greenColor];
            green.title = @"green"; // For use in MyViewController's dealloc method
            [purple presentViewController:green animated:NO completion:^{ // Green successfully gets presented and the user never sees green, great.
                NSLog(@"Green?");
                MyViewController *orange = [[MyViewController alloc] init];
                orange.view.backgroundColor = [UIColor orangeColor];
                orange.title = @"orange"; // For use in MyViewController's dealloc method
                [green presentViewController:orange animated:NO completion:^{ // Orange successfully gets presented and the user DOES see orange, great.
                    NSLog(@"Orange?");
                    // FOR TESTING PURPOSES... dismiss after 5 seconds...
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        doAgain = NO; // Prevent viewDidAppear loop (related to my testing code)...
                        
                        // THIS IS MY BUG HERE. WHEN I WANT TO **ANIMATE** THE DISMISSAL OF ORANGE ALL THE WAY BACK TO RED, HOWEVER, I SEE PURPLE FOR A FLASH BEFORE RED!! WHY?
                        
                        // If I do not animate, things work as expected and I go from orange directly back to red in one flash. Why can't I go from orange back red WITH ANIMATION without seeing a flash of purple?
                        BOOL animateDismissalOfOrangeBackToRed = YES; // YES causes me to see a flash of purple before red, why?
                        [self dismissViewControllerAnimated:animateDismissalOfOrangeBackToRed completion:^{
                            NSLog(@"Back to red...");
                        }];
                    });
                }];
            }];
        }];
    }
}

- (void)viewDidLoad
{
    // Invoke super
    [super viewDidLoad];
    
    // Set self's background color
    self.view.backgroundColor = [UIColor redColor]; // Color of self, root VC
}

@end
