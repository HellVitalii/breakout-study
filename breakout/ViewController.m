//
//  ViewController.m
//  breakout
//
//  Created by stager on 08/07/2019.
//  Copyright © 2019 sbs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

CGPoint speedVector;
bool touchesFlag = false;

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    touchesFlag = true;
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    touchesFlag = false;
}

-(BOOL) checkCollision:(UIView*)ball view:(UIView*)view{
    
    double distX = fabs(ball.center.x - view.center.x);
    double distY = fabs(ball.center.y - view.center.y);
    
//    double dx=distX - view.frame.size.height/2;
//    double dy=distY - view.frame.size.width/2;
//    if (dx*dx+dy*dy<=ball.frame.size.width*ball.frame.size.width) {
//        speedVector.x *=-1;
//        speedVector.y *=-1;
//        return true;
//    }
//
    if (distX > (view.frame.size.width/2 + ball.frame.size.width/2)) { return false; }
    if (distY > (view.frame.size.height/2 + ball.frame.size.height/2)) { return false; }
    
    if (distX <= view.frame.size.height/2 + ball.frame.size.height/2 ) {
        speedVector.y *= -1;
        return true;
    }
    if (distY <= view.frame.size.width/2  + ball.frame.size.width/2 ) {
        speedVector.x *= -1;
        return true;
    }
    
    return false;
}

- (void)moveBall:(NSTimer*)timer {
    
    int damage=5;
    double addingSpeed=0.1;
    
    if (touchesFlag) speedVector.y += addingSpeed;
        [self.warBall setFrame:CGRectMake(
                                      self.warBall.frame.origin.x+speedVector.x,
                                      self.warBall.frame.origin.y+speedVector.y,
                                      self.warBall.frame.size.width,
                                      self.warBall.frame.size.height)];

    if(self.view.frame.size.width<self.warBall.frame.size.width/2+self.warBall.frame.origin.x
       || 10>self.warBall.frame.size.width/2+self.warBall.frame.origin.x) {
        speedVector.x*=-1;
        
    }
    if(self.view.frame.size.height<self.warBall.frame.size.height/2+self.warBall.frame.origin.y
       || 10>self.warBall.frame.size.height/2+self.warBall.frame.origin.y) {
        speedVector.y*=-1;
    }
    /*for (UIView *view in [self.enemyViews copy])
    {
        if ([self checkCollision:self.warBall view:view])
        {
            [view removeFromSuperview];
            [self.enemyViews removeObject:view];
            [view autorelease];
        }
    }*/
    //NSUInteger size = ;
    for (NSInteger i = [self.enemyViews count]-1; i >= 0; i--)
    {
        EnemyView *view = self.enemyViews[i];
        if ([self checkCollision:self.warBall view:view])
        {
            if ([view checkDeath:damage])
            {
                [view removeFromSuperview];
                [self.enemyViews removeObject:view];
                //[view release];
            }
           
        }
    }
    
    
//    [timer invalidate];
//    timer = nil;
}



- (IBAction)startButton {
    
    self.enemyViews = [[NSMutableArray alloc] init];
    self.warBall = [[UIView alloc] init];
    [self.warBall autorelease];
    [self.enemyViews autorelease];
    
    
    CGFloat startX = 50.0, startY = 100.0, width = 60.0, height = 30.0;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            CGRect viewRect = CGRectMake(startX+j*120, startY+i*120, width, height);
            EnemyView *view = [[EnemyView alloc] initWithHp:10 andRect:viewRect];
            view.backgroundColor = [UIColor grayColor];
            [self.view addSubview:view];
            [view autorelease];
            [self.enemyViews addObject:view];
        }
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 700, 20, 20)];
    [view autorelease];
    [self.view addSubview:view];
    self.warBall = [view retain];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0, 20, 20)] CGPath]];
    [[self.warBall layer] addSublayer:circleLayer];
    
    int x = (arc4random()%10)-5;
    int y = (arc4random()%5)-5;
    speedVector = CGPointMake(x, y);
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(moveBall:) userInfo:nil repeats:true];
    
    self.startBtn.enabled = false;
    self.stopBtn.enabled = true;
  
}

- (IBAction)stop {
    [self.timer invalidate];
    self.timer = nil;
    
    for (NSInteger i = [self.enemyViews count]-1; i >= 0; i--)
    {
        EnemyView *view = self.enemyViews[i];
        [view removeFromSuperview];
        [self.enemyViews removeObject:view];
        //[view release];
    }
    //[self.enemyViews release];
    
    [self.warBall removeFromSuperview];
    //[self.warBall release];
    
    self.startBtn.enabled = true;
    self.stopBtn.enabled = false;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stopBtn.enabled = false;
    
}


- (void)dealloc {
   
    [_startBtn release];
    [_stopBtn release];
    self.enemyViews = nil;
    [super dealloc];
}
@end
