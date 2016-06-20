//
//  VideoViewController.m
//  asapGF
//
//  Created by rodrigoe on 19-06-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "VideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HomeViewController.h"

@interface VideoViewController ()
@property (nonatomic) MPMoviePlayerController* moviePlayer;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Setting up the video
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"uLatinaCR_video" ofType:@"mp4"];
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    
    self.moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:theurl];
    
    [self.moviePlayer setControlStyle:MPMovieControlStyleNone];
    [self.moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
    [self.moviePlayer.view setFrame:self.view.frame ];
    [self.moviePlayer setShouldAutoplay:YES];
    [self.moviePlayer prepareToPlay];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationBecameActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [self.view addSubview:self.moviePlayer.view];
    [self.view sendSubviewToBack:self.moviePlayer.view];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moviePlayerDidFinish:(NSNotification *)note
{
    if (note.object == self.moviePlayer) {
        NSInteger reason = [[note.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
        if (reason == MPMovieFinishReasonPlaybackEnded)
        {
            HomeViewController *homeView = [[HomeViewController alloc]
                                            initWithNibName:@"dashboard_style_1" bundle:nil];
            [[self navigationController] pushViewController:homeView animated:YES];
        }
    }
}
- (void)applicationBecameActive:(NSNotification *)note
{
    [self.moviePlayer play];
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
