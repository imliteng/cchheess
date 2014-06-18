//
//  FCChessConmandAnalyze.h
//  FantasticChess
//
//  Created by MOVE on 14-5-20.
//  Copyright (c) 2014年 vision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCChessConmandAnalyze : NSObject


@property(nonatomic,strong)NSArray *range1;
@property(nonatomic,strong)NSArray *range2;
@property(nonatomic,strong)NSArray *range3;
@property(nonatomic,strong)NSArray *range4;
@property(nonatomic,strong)NSArray *range5;
@property(nonatomic,strong)NSArray *range6;
@property(nonatomic,strong)NSArray *range7;
@property(nonatomic,strong)NSArray *range8;
@property(nonatomic,strong)NSArray *range9;
@property(nonatomic,strong)NSArray *range0;
@property(nonatomic,strong)NSArray *range10;

@property(nonatomic,strong)NSMutableArray * chessPieceRule;

-(BOOL)verificationCommandCorrect:(NSString*)cmdStr;

-(void)initChesspieceRule;

@end
