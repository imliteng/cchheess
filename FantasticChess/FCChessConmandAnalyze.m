//
//  FCChessConmandAnalyze.m
//  FantasticChess
//
//  Created by MOVE on 14-5-20.
//  Copyright (c) 2014年 vision. All rights reserved.
//

#import "FCChessConmandAnalyze.h"



@implementation FCChessConmandAnalyze


@synthesize range1=_range1;
@synthesize range2=_range2;
@synthesize range3=_range3;
@synthesize range4=_range4;
@synthesize range5=_range5;
@synthesize range6=_range6;
@synthesize range7=_range7;
@synthesize range8=_range8;
@synthesize range9=_range9;
@synthesize range0=_range0;


-(id)init
{
    if ((self = [super init])) {
        _range1=[NSArray arrayWithObjects:@"一", nil];
        _range2=[NSArray arrayWithObjects:@"四",@"五",@"六",nil];
        _range3=[NSArray arrayWithObjects:@"一",@"三",@"五",@"七",@"九",nil];
        _range4=[NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",nil];
        _range5=[NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",nil];
        
        _range6=[NSArray arrayWithObjects:@"将",@"士",@"象",@"马",@"车",@"炮",@"卒",nil];
        _range7=[NSArray arrayWithObjects:@"帅",@"相",@"兵",nil];
        _range8=[NSArray arrayWithObjects:@"前",@"中",@"后",nil];
        _range9=[NSArray arrayWithObjects:@"二",@"三",@"四",@"五",nil];
        
        _range0=[NSArray arrayWithObjects:@"进",@"平",@"退",nil];
        
	}
	return self;
}

// 用于验证 识别命令是否合规
-(BOOL)verificationCommandCorrect:(NSString*)cmdStr
{
    if (4 != [cmdStr length]) {
        return NO;
    }
    
    NSString * command_1=[cmdStr substringToIndex:1];
    NSString * command_2=[cmdStr substringWithRange:NSMakeRange(1, 1)];
    NSString * command_3=[cmdStr substringWithRange:NSMakeRange(2, 1)];
    NSString * command_4=[cmdStr substringFromIndex:3];
    
    if ([_range6 containsObject:command_1] || [_range7 containsObject:command_1] || [_range8 containsObject:command_1] || [_range9 containsObject:command_1]) {
        if ([command_1 isEqualToString:@"中"] || [_range9 containsObject:command_1]) {  // 中 二 三 四 五 为 命 令
            if ([command_2 isEqualToString:@"兵"] || [command_2 isEqualToString:@"卒"]) {
                    if(![self isCmdChessPiecesMoveRight:command_2 Direction:command_3 Move:command_4])
                        return NO;
            }else{
                return NO;
            }
        }else{
            if ([command_1 isEqualToString:@"前"] || [command_1 isEqualToString:@"后"]) {  // 前 后 为 第 一 命 令 符
                if ([command_2 isEqualToString:@"士"] || [command_2 isEqualToString:@"马"] || [command_2 isEqualToString:@"车"] ||
                    [command_2 isEqualToString:@"炮"] ||  [command_2 isEqualToString:@"兵"] || [command_2 isEqualToString:@"卒"]) {
                        if(![self isCmdChessPiecesMoveRight:command_2 Direction:command_3 Move:command_4])
                            return NO;
                }else{
                    return NO;
                }
            }else{ // 棋 子 名 为 第 一 命 令 符
                if ([self isCmdChessPiecesLocationRight:command_1 Location:command_2]) {
                    if(![self isCmdChessPiecesMoveRight:command_1 Direction:command_3 Move:command_4])
                        return NO;
                }else{
                    return NO;
                }
            }
        }
    }else{
        return NO;
    }
    return YES;
}


// 用于确认棋子位置是否符合规则
-(BOOL)isCmdChessPiecesLocationRight:(NSString*)cpName Location:(NSString*)cpLocation
{
    if ([cpName isEqualToString:@"将"] || [cpName isEqualToString:@"帅"] || [cpName isEqualToString:@"士"]) {
        if ( [_range2 containsObject:cpLocation] ) {
            return YES;
        }
    }else if([cpName isEqualToString:@"相"] || [cpName isEqualToString:@"象"]) {
        if ( [_range3 containsObject:cpLocation] ) {
            return YES;
        }
    }else if([cpName isEqualToString:@"马"] || [cpName isEqualToString:@"车"] || [cpName isEqualToString:@"炮"] || [cpName isEqualToString:@"兵"] || [cpName isEqualToString:@"卒"]) {
        if ( [_range4 containsObject:cpLocation] ) {
            return YES;
        }
    }else{
        return NO;
    }
    return NO;
}

// 用于确认棋子走步是否符合规则
-(BOOL)isCmdChessPiecesMoveRight:(NSString*)cpName Direction:(NSString*)direction Move:(NSString*)cpLocation
{
    if ([direction isEqualToString:@"进"]) {
        if ([cpName isEqualToString:@"将"] || [cpName isEqualToString:@"帅"] || [cpName isEqualToString:@"兵"]) {
            if(![_range1 containsObject:cpLocation])
                return NO;
        }else if([cpName isEqualToString:@"车"] || [cpName isEqualToString:@"马"] || [cpName isEqualToString:@"炮"]) {
            if(![_range5 containsObject:cpLocation])
                return NO;
        }else if([cpName isEqualToString:@"士"]) {
            if(![_range2 containsObject:cpLocation])
                return NO;
        }else if([cpName isEqualToString:@"相"] || [cpName isEqualToString:@"象"]) {
            if(![_range3 containsObject:cpLocation])
                return NO;
        }else
            return NO;
    }else if ([direction isEqualToString:@"平"]) {
        if ([cpName isEqualToString:@"将"] || [cpName isEqualToString:@"帅"]) {
            if(![_range2 containsObject:cpLocation])
                return NO;
        }else if([cpName isEqualToString:@"炮"] || [cpName isEqualToString:@"车"] || [cpName isEqualToString:@"兵"] || [cpName isEqualToString:@"卒"]) {
            if(![_range5 containsObject:cpLocation])
                return NO;
        }else
            return NO;
    }else if ([direction isEqualToString:@"退"]) {
        if([cpName isEqualToString:@"将"] || [cpName isEqualToString:@"帅"]) {
            if(![_range1 containsObject:cpLocation])
                return NO;
        }else if([cpName isEqualToString:@"车"] || [cpName isEqualToString:@"马"] || [cpName isEqualToString:@"炮"]) {
            if(![_range5 containsObject:cpLocation])
                return NO;
        }else if([cpName isEqualToString:@"相"] || [cpName isEqualToString:@"象"]) {
            if(![_range3 containsObject:cpLocation])
                return NO;
        }else if([cpName isEqualToString:@"士"]) {
            if(![_range2 containsObject:cpLocation])
                return NO;
        }else
            return NO;
    }else
        return NO;
    return YES;
}

@end
