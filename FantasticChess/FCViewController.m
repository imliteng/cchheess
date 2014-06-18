//
//  FCViewController.m
//  FantasticChess
//
//  Created by MOVE on 14-5-19.
//  Copyright (c) 2014年 vision. All rights reserved.
//

#import "FCViewController.h"
#import "FCChessConmandAnalyze.h"

@interface FCViewController ()

@end

@implementation FCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    FCChessConmandAnalyze* test=[[FCChessConmandAnalyze alloc] init];
    if([test verificationCommandCorrect:@"马二平一"])
        NSLog(@"ok");
    
    [test initChesspieceRule];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
