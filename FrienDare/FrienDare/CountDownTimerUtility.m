//
//  CountDownTimerUtility.m
//  CountDownTimer
//
//  Created by abdus on 3/26/13.
//  Copyright (c) 2013 abdus.me. All rights reserved.
//

#import "CountDownTimerUtility.h"

@implementation CountDownTimerUtility
@synthesize delegate;

-(void)startCountDownTimerWithTime:(int)time andUILabel:(UILabel *)currentLabel
{
    self.countDownTime = time;
    actualTime = time;
    label = currentLabel;
    [self StartCountDownTimer];
}

-(void)invalidateCurrentCountDownTimer
{
    [self InvalidateCountDownTimer];
}

#pragma mark -
#pragma mark count Down Timer
-(void)InvalidateCountDownTimer
{
    self.countDownTime =actualTime;
    if (CountDownTimer!=nil)
    {
        if ([CountDownTimer isValid])
        {
            [CountDownTimer invalidate];
            
        }
        CountDownTimer=nil;
    }
}

-(void)StartCountDownTimer
{
    [self InvalidateCountDownTimer];
    CountDownTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(DecrementCounterValue) userInfo:nil repeats:YES];
    
    label.text=[NSString stringWithFormat:@"%d:00", actualTime];
}

-(void)DecrementCounterValue
{
    if (self.countDownTime>0)
	{
         self.countDownTime--;
        if (self.countDownTime<10)
        {
            label.text=[NSString stringWithFormat:@"0%d:00",self.countDownTime];
        }
        else
        {
            label.text=[NSString stringWithFormat:@"%d:00",self.countDownTime];
        }
       
    }
    else
	{
        [self InvalidateCountDownTimer];
        [self performSelectorOnMainThread:@selector(CountDownTimeFinish) withObject:nil waitUntilDone:NO];
    }
}

-(void)CountDownTimeFinish
{
    [delegate timesUpWithLabel:label];
}


@end


