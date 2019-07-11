//
//  enemyView.m
//  breakout
//
//  Created by stager on 10/07/2019.
//  Copyright © 2019 sbs. All rights reserved.
//

#import "enemyView.h"

@implementation EnemyView

@synthesize hp;
-(id)init {
    return [self initWithHp:1];
}

-(id)initWithHp:(int)number {
    return [self initWithHp:number andRect:CGRectMake(0, 0, 0, 0)];
    
}

-(id) initWithHp:(int)number andRect:(CGRect)rect {
    
    if (self = [super initWithFrame:rect]) {
        self.hp = number;
        return self;
    }
    return nil;
}

-(bool) checkDeath:(int)damage{
    
    self.hp -= damage;
    if (self.hp <= 0) {
        return true;
    }
    return false;
}

@end
