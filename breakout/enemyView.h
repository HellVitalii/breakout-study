//
//  enemyView.h
//  breakout
//
//  Created by stager on 10/07/2019.
//  Copyright © 2019 sbs. All rights reserved.
//

#ifndef enemyView_h
#define enemyView_h
#import <UIKit/UIKit.h>
@interface EnemyView : UIView

@property (nonatomic, assign) int hp;


-(id)init;
-(id)initWithHp: (int)number;
-(id)initWithHp: (int)number andRect:(CGRect)rect;
-(bool)checkDeath: (int)damage;


@end
#endif /* enemyView_h */
