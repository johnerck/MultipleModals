//
//  MyViewController.m
//  MultipleModals
//
//  Created by John Erck on 11/20/14.
//  Copyright (c) 2014 Above Market. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)dealloc
{
    NSLog(@"Inside dealloc self.title = %@", self.title);
}

@end
