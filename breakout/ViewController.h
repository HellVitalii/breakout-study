//
//  ViewController.h
//  breakout
//
//  Created by stager on 08/07/2019.
//  Copyright © 2019 sbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "enemyView.h"



@interface ViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *enemyViews;
@property (nonatomic, retain) UIView *warBall;
@property (nonatomic, retain) NSTimer *timer;

@property (retain, nonatomic) IBOutlet UIButton *startBtn;

@property (retain, nonatomic) IBOutlet UIButton *stopBtn;



@end

