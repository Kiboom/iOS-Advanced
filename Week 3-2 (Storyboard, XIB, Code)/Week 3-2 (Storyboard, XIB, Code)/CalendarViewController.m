//
//  CalendarViewController.m
//  Week 3-2 (Storyboard, XIB, Code)
//
//  Created by 김기범 on 2016. 6. 29..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()
@property NSInteger screenWidth;
@property NSInteger screenHeight;
@property CGFloat horzOffset;
@property CGFloat vertOffset;
@property CGFloat vertStart;
@property NSArray<NSString *> *weekDays;
@property NSDateComponents *currentCalendar;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initiateIvars];
    [self drawWeekDays];
    [self drawCalendarOfMonth:_currentCalendar.month
                       ofYear:_currentCalendar.year];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initiateIvars {
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    _horzOffset = _screenWidth/8;
    _vertOffset = 40;
    _vertStart = 150.0;
    
    _weekDays = @[@"일", @"월", @"화", @"수", @"목", @"금", @"토"];
    _currentCalendar = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                       fromDate:[NSDate date]];
    self.navigationItem.title = [NSString stringWithFormat:@"%ld년 %ld월", _currentCalendar.year, _currentCalendar.month];
}


- (void)drawWeekDays {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat x = _horzOffset;
    CGFloat y = _vertStart;
    CGFloat width = 30;
    CGFloat height = 20;
    
    for(int i=0 ; i<7 ; i++) {
        UILabel *weekDay = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:weekDay];
        weekDay.textAlignment = NSTextAlignmentCenter;
        weekDay.text = _weekDays[i];
        x += _horzOffset;
    }
}


- (void)drawCalendarOfMonth:(NSInteger)month ofYear:(NSInteger)year {
    NSDate *date = [self dateWithMonth:month ofYear:year];
    NSInteger weekDayOfFirstDay = [self weekDayOfFirstDayOfDate:date];  // 일요일=0, 월요일=1, ..., 토요일=6
    NSInteger numOfDays = [self numberOfDaysOfDate:date];
    NSInteger xPos = weekDayOfFirstDay;
    NSInteger yPos = 0;
    
    for(int day=1 ; day<=numOfDays ; day++) {
        CGRect frame = CGRectMake(_horzOffset*(xPos+1), _vertStart+_vertOffset*(yPos+1), 30, 20);
        [self drawLabelOfDay:day withFrame:frame];
        if( (++xPos) % 7 == 0 ) {     // if the next day is end of the week...
            xPos = 0;
            yPos++;
        }
    }
}


- (NSDate *)dateWithMonth:(NSInteger)month ofYear:(NSInteger)year {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    components.month = month;
    components.year = year;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:components];
}


- (NSInteger)weekDayOfFirstDayOfDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekDay = [calendar component:NSCalendarUnitWeekday fromDate:date];
    return weekDay-1;
}


- (NSInteger)numberOfDaysOfDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit:NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}


- (void)drawLabelOfDay:(int)day withFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d", day];
    [self.view addSubview:label];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
