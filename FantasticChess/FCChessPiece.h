//
//  FCChessPiece.h
//  FantasticChess
//
//  Created by MOVE on 14-6-3.
//  Copyright (c) 2014年 vision. All rights reserved.
//

typedef NS_ENUM(NSInteger, FCDirection) {
    FCForward  = 0,
    FCCrosswise    = 1,
    FCRetreat  = 2,
};

#import <Foundation/Foundation.h>

@interface FCChessPiece : NSObject

@property (nonatomic) FCDirection nextStepDirection;
@property (nonatomic) NSArray * chessPieceSteps;

@end
