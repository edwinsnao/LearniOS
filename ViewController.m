//
//  ViewController.m
//  LearniOS
//
//  Created by fazhao on 2017/1/22.
//  Copyright © 2017年 fazhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
#define MARGINE 20
#define BUTTON_WIDTH 80
#define BUTTON_HEIGHT 30
#define CELL_WIDTH 100
#define CELL_HEIGHT 40
@end


@implementation ViewController
NSInteger bnIndex;
bool isLongPress = 0;
NSMutableArray* bnArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"viewDidLoad");
    self.view.backgroundColor = [UIColor whiteColor];

    //    bnArray = [[NSMutableArray alloc]init];

    //    UILongPressGestureRecognizer* gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    //    [self.view addGestureRecognizer:gesture];

    bnArray = [[NSMutableArray alloc]init];

    UILongPressGestureRecognizer* gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    gesture.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:gesture];
}

-(void) longPress:(UILongPressGestureRecognizer*)gesture
{
//    解决长按一次出现两次调用的bug
    if(isLongPress == 0){
        NSLog(@"longpress");
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];

        NSInteger count = bnArray.count;

        NSInteger row = count / 3;

        NSInteger col = count % 3;

        [btn setTitle:[NSString stringWithFormat:@"按钮%d",bnIndex] forState:UIControlStateNormal];
        btn.frame = CGRectMake(MARGINE + col * CELL_WIDTH, row * CELL_HEIGHT + MARGINE, BUTTON_WIDTH, BUTTON_HEIGHT);
        [btn addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside ];

        [bnArray addObject:btn];

        [self.view addSubview:btn];
        bnIndex++;
        isLongPress = 1;

    }else if(isLongPress == 1){
        isLongPress = 0;
    }
}

-(void) remove:(id)sender
{
    NSLog(@"sender");
    [sender removeFromSuperview];
    [bnArray removeObject:sender];
    [self rearrange];
}

-(void) rearrange
{
    NSLog(@"rearrange");
    for(int i = 0; i < bnArray.count;i++){
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        UIButton* btn = [bnArray objectAtIndex:i];
        btn.frame = CGRectMake(MARGINE + col * CELL_WIDTH, MARGINE + row * CELL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
