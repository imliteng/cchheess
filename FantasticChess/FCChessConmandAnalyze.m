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
@synthesize range10=_range10;
@synthesize chessPieceRule=_chessPieceRule;


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
        _range10=[NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",nil];
        
        _range0=[NSArray arrayWithObjects:@"进",@"平",@"退",nil];
        
        _chessPieceRule=[NSMutableArray array];
        
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

// 用于生成则规则的棋子命令
-(NSMutableArray*)createRegulationCmd:(NSString*)ChessName
{
    NSMutableArray * RegulationArray=[NSMutableArray array];
    NSString *RegulationString=@"";
    for (NSString * tmStr0 in _range0)
    {
        
        if ([tmStr0 isEqualToString:@"进"])
        {
            if ([ChessName isEqualToString:@"将"] || [ChessName isEqualToString:@"帅"])
            {
                for (NSString *tmStr1 in _range2)
                {
                    for (NSString *tmStr2 in _range1)
                    {
                        RegulationString=[NSString stringWithFormat:@"%@%@%@%@",ChessName,tmStr1,tmStr0,tmStr2];
                        [RegulationArray addObject:RegulationString];
                    }
                }
            }
            
            if([tmStr0 isEqualToString:@"士"])
            {
                for (NSString *tmStr1 in _range2)
                {
                    for (NSString *tmStr2 in _range2)
                    {
                        if (![tmStr1 isEqualToString:tmStr2])
                        {
                            RegulationString=[NSString stringWithFormat:@"%@%@%@%@",ChessName,tmStr1,tmStr0,tmStr2];
                            [RegulationArray addObject:RegulationString];
                        }
                    }
                }
            }
            
            if([tmStr0 isEqualToString:@"相"] || [tmStr0 isEqualToString:@"象"])
            {
                for (NSString *tmStr1 in _range3)
                {
                    for (NSString *tmStr2 in _range3)
                    {
                        if (![tmStr1 isEqualToString:tmStr2])
                        {
                            RegulationString=[NSString stringWithFormat:@"%@%@%@%@",ChessName,tmStr1,tmStr0,tmStr2];
                            [RegulationArray addObject:RegulationString];
                        }
                    }
                }
            }
            
        }
        
        if([tmStr0 isEqualToString:@"平"])
        {
            if ([ChessName isEqualToString:@"将"] || [ChessName isEqualToString:@"帅"])
            {
                for (NSString *tmStr1 in _range2)
                {
                    for (NSString *tmStr2 in _range2)
                    {
                        if (![tmStr1 isEqualToString:tmStr2])
                        {
                            RegulationString=[NSString stringWithFormat:@"%@%@%@%@",ChessName,tmStr1,tmStr0,tmStr2];
                            [RegulationArray addObject:RegulationString];
                        }
                    }
                }
            }
        }
        
        if([tmStr0 isEqualToString:@"退"])
        {
            
            if ([ChessName isEqualToString:@"将"] || [ChessName isEqualToString:@"帅"])
            {
                for (NSString *tmStr1 in _range2)
                {
                    for (NSString *tmStr2 in _range1)
                    {
                        if (![tmStr1 isEqualToString:tmStr2])
                        {
                            RegulationString=[NSString stringWithFormat:@"%@%@%@%@",ChessName,tmStr1,tmStr0,tmStr2];
                            [RegulationArray addObject:RegulationString];
                        }
                    }
                }
            }
            
            if([tmStr0 isEqualToString:@"士"])
            {
                for (NSString *tmStr1 in _range2)
                {
                    for (NSString *tmStr2 in _range2)
                    {
                        if (![tmStr1 isEqualToString:tmStr2])
                        {
                            RegulationString=[NSString stringWithFormat:@"%@%@%@%@",ChessName,tmStr1,tmStr0,tmStr2];
                            [RegulationArray addObject:RegulationString];
                        }
                    }
                }
            }
            
            if([tmStr0 isEqualToString:@"相"] || [tmStr0 isEqualToString:@"象"])
            {
                for (NSString * tmStr1 in _range3) {
                    for (NSString * tmStr2 in _range3) {
                        if (![tmStr1 isEqualToString:tmStr2]) {
                            if (![tmStr1 isEqualToString:tmStr2])
                            {
                                RegulationString=[NSString stringWithFormat:@"%@%@%@%@",ChessName,tmStr1,tmStr0,tmStr2];
                                [RegulationArray addObject:RegulationString];
                            }
                        }
                    }
                }
            }
            
        }
    }
    return RegulationArray;
}

-(NSMutableArray*)createRegulationCmdEx:(NSString*)ChessName
{
    NSMutableArray * RegulationArray=[NSMutableArray array];
    NSString *RegulationString=@"";
    if ( [ChessName isEqualToString:@"将"] || [ChessName isEqualToString:@"帅"] )
    {
        for ( NSString * tmStr1 in _range2 ) {
            for ( NSString * tmStr2 in _range0 ) {
                if ([tmStr2 isEqualToString:@"进"]) {
                    NSUInteger DirectionY =[self exchangeDirectionFlag:tmStr1];
                    
                }
            }
        }
    }
    
    return RegulationArray;
}


-(NSUInteger)exchangeDirectionFlag:(NSString*)directionFlag
{
    if ([directionFlag isEqualToString:@"一"]) {
        return 1;
    }else if ([directionFlag isEqualToString:@"二"]) {
        return 2;
    }else if ([directionFlag isEqualToString:@"三"]) {
        return 3;
    }else if ([directionFlag isEqualToString:@"四"]) {
        return 4;
    }else if ([directionFlag isEqualToString:@"五"]) {
        return 5;
    }else if ([directionFlag isEqualToString:@"六"]) {
        return 6;
    }else if ([directionFlag isEqualToString:@"七"]) {
        return 7;
    }else if ([directionFlag isEqualToString:@"八"]) {
        return 8;
    }else if ([directionFlag isEqualToString:@"九"]) {
        return 9;
    }else {
        return 0;
    }
}


// 进步棋谱的正确性判断

-(BOOL)goRule:(NSUInteger)chessPieceTag currentLocation:(NSUInteger)currentLocation nextStepLocation:(NSUInteger)nextStepLocation
{
    if (0==chessPieceTag) // 将 帅
    {
        if( currentLocation>=4 && currentLocation<=6 && 1==nextStepLocation )
        {
            return YES;
        }
    }
    
    if (1==chessPieceTag) //士 仕
    {
        if (currentLocation>=4 && currentLocation<=6 && nextStepLocation >=4  && nextStepLocation<=6 )
        {
            if (1==abs(currentLocation-nextStepLocation) && currentLocation!=nextStepLocation)
            {
                return YES;
            }
        }
    }
    
    if (2==chessPieceTag) // 相 象
    {
        if ( 1 == currentLocation )
        {
            if ( 3 == nextStepLocation )
            {
                return YES;
            }
        }
        
        if ( 3 == currentLocation || 5 == currentLocation || 7 == currentLocation )
        {
            if ( currentLocation-2 == nextStepLocation || currentLocation+2 == nextStepLocation)
            {
                return YES;
            }
        }
        
        if ( 9 == currentLocation )
        {
            if (7 == nextStepLocation)
            {
                return YES;
            }
        }
    }
    
    if ( 3 == chessPieceTag ) // 马
    {
        if (1 == currentLocation && ( currentLocation+1 == nextStepLocation || currentLocation+2 == nextStepLocation))
        {
            return YES;
        }
        
        if (2 == currentLocation && ( currentLocation+1 == nextStepLocation || currentLocation+2 == nextStepLocation || currentLocation-1 == nextStepLocation))
        {
            return YES;
        }
        
        if (8 == currentLocation && (currentLocation-1 == nextStepLocation || currentLocation-2 == nextStepLocation || currentLocation+1 == nextStepLocation))
        {
            return YES;
        }
        
        if (9 == currentLocation && (currentLocation-1 == nextStepLocation || currentLocation-2 == nextStepLocation))
        {
            return YES;
        }
        
        if ((nextStepLocation == currentLocation+1) || (nextStepLocation == currentLocation+2) || (nextStepLocation == currentLocation-1) || (nextStepLocation == currentLocation-2))
        {
            return YES;
        }
    }
    
    if ( 4 == chessPieceTag ) // 车
    {
        if ( nextStepLocation >=1 &&  nextStepLocation <=9 )
        {
            return YES;
        }
    }
    
    if ( 5 == chessPieceTag ) // 炮
    {
        if ( nextStepLocation >=1 &&  nextStepLocation <=9 )
        {
            return YES;
        }
    }
    
    if ( 6 == chessPieceTag ) // 兵 卒
    {
        if (1 == nextStepLocation )
        {
            return YES;
        }
    }
    
    return NO;
}

// 平步棋谱的正确性判断

-(BOOL)crosswiseRule:(NSUInteger)chessPieceTag currentLocation:(NSUInteger)currentLocation nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( 0 == chessPieceTag ) // 将 帅
    {
        if ( currentLocation>=4 && currentLocation<=6 &&  nextStepLocation>=4 && nextStepLocation<=6 )
        {
            if (currentLocation != nextStepLocation && 1==abs(currentLocation - nextStepLocation))
            {
                return YES;
            }
        }
    }
    
    if ( 4 == chessPieceTag ) // 车
    {
        if ( nextStepLocation >= 1 && nextStepLocation <= 9 && currentLocation !=nextStepLocation )
        {
            return YES;
        }
    }
    
    if ( 5 == chessPieceTag ) // 炮
    {
        if ( nextStepLocation>=1 && nextStepLocation <= 9 && currentLocation !=nextStepLocation )
        {
            return YES;
        }
    }
    
    if ( 6 == chessPieceTag ) // 兵 卒
    {
        if ( currentLocation!=nextStepLocation && 1==abs( currentLocation-nextStepLocation ))
        {
            return YES;
        }
    }
    
    return NO;
}

// 退步棋谱的正确性判断

-(BOOL)backRule:(NSUInteger)chessPieceTag currentLocation:(NSUInteger)currentLocation nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( 0 == chessPieceTag ) // 将 帅
    {
        if ( currentLocation>=4 && currentLocation<=6 && 1==nextStepLocation )
        {
            return YES;
        }
    }
    
    if ( 1 == chessPieceTag ) //士 仕
    {
        if (currentLocation>=4 && currentLocation<=6 && nextStepLocation >=4  && nextStepLocation<=6 )
        {
            if (1==abs(currentLocation-nextStepLocation) && currentLocation!=nextStepLocation)
            {
                return YES;
            }
        }
    }
    
    if ( 2 == chessPieceTag ) // 相 象
    {
        if ( 1 == currentLocation && 3 == nextStepLocation )
        {
            return YES;
        }
        
        if ( 3 == currentLocation || 5 == currentLocation || 7 == currentLocation )
        {
            if ( currentLocation-2 == nextStepLocation || currentLocation+2 == nextStepLocation)
            {
                return YES;
            }
        }
        
        if ( 9 == currentLocation && 7 == nextStepLocation )
        {
            return YES;
        }
    }
    
    if ( 3 == chessPieceTag ) // 马
    {
        if (1 == currentLocation && ( currentLocation+1 == nextStepLocation || currentLocation+2 == nextStepLocation))
        {
            return YES;
        }
        
        if (2 == currentLocation && ( currentLocation+1 == nextStepLocation || currentLocation+2 == nextStepLocation || currentLocation-1 == nextStepLocation))
        {
            return YES;
        }
        
        if (8 == currentLocation && (currentLocation-1 == nextStepLocation || currentLocation-2 == nextStepLocation || currentLocation+1 == nextStepLocation))
        {
            return YES;
        }
        
        if (9 == currentLocation && (currentLocation-1 == nextStepLocation || currentLocation-2 == nextStepLocation))
        {
            return YES;
        }
        
        if ((nextStepLocation == currentLocation+1) || (nextStepLocation == currentLocation+2) || (nextStepLocation == currentLocation-1) || (nextStepLocation == currentLocation-2))
        {
            return YES;
        }
    }
    
    if ( 4 == chessPieceTag ) // 车
    {
        if ( nextStepLocation>=1 && nextStepLocation<=9 )
        {
            return YES;
        }
    }
    
    if ( 5 == chessPieceTag )
    {
        if ( nextStepLocation>=1 && nextStepLocation<=9 ) // 炮
        {
            return YES;
        }
    }
    
    if ( 6 == chessPieceTag ) // 兵 卒
    {
        if ( 1 == nextStepLocation )
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)frontChesspieceGoRule:(NSUInteger)chessPieceTag nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( 3 == chessPieceTag )
    {
        return YES;
    }
    
    if ( 4 == chessPieceTag )
    {
        if ( nextStepLocation <= 8 )
        {
            return YES;
        }
    }
    
    if ( 5 == chessPieceTag )
    {
        if ( nextStepLocation <= 8 )
        {
            return YES;
        }
    }
    
    if ( 6 == chessPieceTag)
    {
        if ( 1== nextStepLocation)
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)frontChesspieceCrosswiseRule:(NSUInteger)chessPieceTag nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( 4 == chessPieceTag )
    {
        return YES;
    }
    
    if ( 5 == chessPieceTag )
    {
        return YES;
    }
    
    if ( 6 == chessPieceTag )
    {
        if ( 1 == nextStepLocation )
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)frontChesspieceBackRule:(NSUInteger)chessPieceTag nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( 1 == chessPieceTag )
    {
        if ( 5 == nextStepLocation )
        {
            return YES;
        }
    }
    
    if ( 2 == chessPieceTag )
    {
        if (1 == nextStepLocation || 5 == nextStepLocation || 9 == nextStepLocation)
        {
            return YES;
        }
    }
    
    if ( 3 == chessPieceTag )
    {
        return YES;
    }
    
    if ( 4 == chessPieceTag )
    {
        if ( nextStepLocation <= 8 )
        {
            return YES;
        }
    }
    
    if ( 5 == chessPieceTag )
    {
        if ( nextStepLocation <= 8 )
        {
            return YES;
        }
    }
    
    if ( 6 == chessPieceTag )
    {
        if ( 1 == nextStepLocation )
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)latterChesspieceGoRule:(NSUInteger)chessPieceTag nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( 1 == chessPieceTag )
    {
        if ( 5 == nextStepLocation )
        {
            return YES;
        }
    }
    
    if ( 2 == chessPieceTag )
    {
        if ( 1 == nextStepLocation || 5 == nextStepLocation || 5 == nextStepLocation || 7 == nextStepLocation )
        {
            return YES;
        }
    }
    
    if ( 3 == chessPieceTag )
    {
        return YES;
    }
    
    if ( 4 == chessPieceTag )
    {
        if (nextStepLocation<=8)
        {
            return YES;
        }
    }
    
    if ( 5 == chessPieceTag )
    {
        if (nextStepLocation<=8)
        {
            return YES;
        }
    }
    
    if ( 6 == chessPieceTag )
    {
        if ( 1 == nextStepLocation )
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)latterChesspieceCrosswiseRule:(NSUInteger)chessPieceTag nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( 4 == chessPieceTag )
    {
        return YES;
    }
    
    if ( 5 == chessPieceTag )
    {
        return YES;
    }
    
    if ( 6 == chessPieceTag )
    {
        if ( 1 == nextStepLocation )
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)latterChesspieceBackRule:(NSUInteger)chessPieceTag nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( 3 == chessPieceTag )
    {
        return YES;
    }
    
    if ( 4 == chessPieceTag )
    {
        if ( nextStepLocation <= 8 )
        {
            return YES;
        }
    }
    
    if ( 5 == chessPieceTag )
    {
        if ( nextStepLocation <= 8 )
        {
            return YES;
        }
    }
    
    if ( 6 == chessPieceTag )
    {
        if ( 1 == nextStepLocation )
        {
            return YES;
        }
    }
    return NO;
}

-(BOOL)pawnsRule:(NSUInteger)pawnCount ruleType:(NSUInteger)ruleType nextStepLocation:(NSUInteger)nextStepLocation
{
    if ( pawnCount >= 3)
    {
        if ( 1 == ruleType )  //进步
        {
            if ( 1 == nextStepLocation )
            {
                return YES;
            }
        }
        
        if ( 2 == ruleType )  //平步
        {
            if ( 1 == nextStepLocation )
            {
                return YES;
            }
        }
    }
    return NO;
}

-(NSUInteger)translateChesspieceName:(NSString*)ChesspieceName
{
    if ( [ChesspieceName isEqualToString:@"将"] || [ChesspieceName isEqualToString:@"帅"] )
    {
        return 0;
    }
    
    if ( [ChesspieceName isEqualToString:@"士"] || [ChesspieceName isEqualToString:@"仕"] )
    {
        return 1;
    }
    
    if ( [ChesspieceName isEqualToString:@"象"] || [ChesspieceName isEqualToString:@"相"] )
    {
        return 2;
    }
    
    if ( [ChesspieceName isEqualToString:@"马"] )
    {
        return 3;
    }
    
    if ( [ChesspieceName isEqualToString:@"车"] )
    {
        return 4;
    }
    
    if ( [ChesspieceName isEqualToString:@"炮"] )
    {
        return 5;
    }
    
    if ( [ChesspieceName isEqualToString:@"兵"] || [ChesspieceName isEqualToString:@"卒"] )
    {
        return 6;
    }
    
    return 404;
}


// 枚举 标准 棋谱 所有棋步
-(void)initChesspieceRule
{
    for ( NSString * tmArr_1 in _range5 )
    {
        for ( NSString * tmArr_2 in _range10 )
        {
            if([self goRule:[self translateChesspieceName:@"将"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"将%@进%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"帅%@进%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
            
            if ([self crosswiseRule:[self translateChesspieceName:@"将"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"将%@平%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"帅%@平%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
            
            if ([self backRule:[self translateChesspieceName:@"将"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"将%@退%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"帅%@退%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
        }
    }
    
    for ( NSString * tmArr_1 in _range5 )
    {
        for ( NSString * tmArr_2 in _range5 )
        {
            if ([self goRule:[self translateChesspieceName:@"士"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"士%@进%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"仕%@进%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
            
            if ([self backRule:[self translateChesspieceName:@"士"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"士%@退%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"仕%@退%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
        }
    }
    
    for ( NSString * tmArr_1 in _range5 )
    {
        for ( NSString * tmArr_2 in _range5 )
        {
            if ([self goRule:[self translateChesspieceName:@"象"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"象%@进%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"相%@进%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
            
            if ([self backRule:[self translateChesspieceName:@"象"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"象%@退%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"相%@退%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
        }
    }
    
    for ( NSString * tmArr_1 in _range5 )
    {
        for ( NSString * tmArr_2 in _range5 )
        {
            if ([self goRule:[self translateChesspieceName:@"马"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"马%@进%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
            }
            
            if ([self backRule:[self translateChesspieceName:@"马"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"马%@退%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
            }
        }
    }
    
    for ( NSString * tmArr_1 in _range5 )
    {
        for ( NSString * tmArr_2 in _range10 )
        {
            if ([self goRule:[self translateChesspieceName:@"车"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"车%@进%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
            }
            
            if ([self crosswiseRule:[self translateChesspieceName:@"车"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"车%@平%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
            }
            
            if ([self backRule:[self translateChesspieceName:@"车"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"车%@退%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
            }
        }
    }
    
    for ( NSString * tmArr_1 in _range5 )
    {
        for ( NSString * tmArr_2 in _range10 )
        {
            if ([self goRule:[self translateChesspieceName:@"炮"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"炮%@进%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
            }
            
            if ([self crosswiseRule:[self translateChesspieceName:@"炮"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"炮%@平%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
            }
            
            if ([self backRule:[self translateChesspieceName:@"炮"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"炮%@退%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
            }
        }
    }
    
    for ( NSString * tmArr_1 in _range5 )
    {
        for ( NSString * tmArr_2 in _range5 )
        {
            if ([self goRule:[self translateChesspieceName:@"兵"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"兵%@进%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"卒%@进%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
            
            if ([self crosswiseRule:[self translateChesspieceName:@"兵"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"兵%@平%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"卒%@平%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
            
            if ([self backRule:[self translateChesspieceName:@"兵"] currentLocation:[self exchangeDirectionFlag:tmArr_1] nextStepLocation:[self exchangeDirectionFlag:tmArr_2]])
            {
                NSString * moveStr= [NSString stringWithFormat:@"兵%@退%@",tmArr_1,tmArr_2];
                NSString * moveStrX= [NSString stringWithFormat:@"卒%@退%@",tmArr_1,tmArr_2];
                NSLog(@"%@",moveStr);
                [_chessPieceRule addObject:moveStr];
                [_chessPieceRule addObject:moveStrX];
            }
        }
    }

}

@end
