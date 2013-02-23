//
//  ViewController.m
//  CVUMoviePlayerViewExample
//
//  Created by Claudiu-Vlad Ursache on 23.02.13.
//  Copyright (c) 2013 c.v.ursache. All rights reserved.
//

#import "ViewController.h"
#import "CVUMoviePlayerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    CGRect frame = CGRectMake(0, 0, 300, 300);
//    NSURL* videoURL = [NSURL URLWithString:@"https://devimages.apple.com.edgekey.net/resources/http-streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
//    CVUMoviePlayerView* moviePlayerView = [[CVUMoviePlayerView alloc] initWithFrame:frame videoURL:videoURL];
//    moviePlayerView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:moviePlayerView];
    
    
    CGRect frame = CGRectMake(0, 0, 300, 300);
    UIImage* placeholderImage = [UIImage imageNamed:@"video_placeholder_image.png"];
    NSURL* videoURL = [NSURL URLWithString:@"https://devimages.apple.com.edgekey.net/resources/http-streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
    CVUMoviePlayerView* moviePlayerView = [[CVUMoviePlayerView alloc] initWithFrame:frame placeholderImage:placeholderImage videoURL:videoURL];
    
    
    UIImage* placeholderPlayVideoButtonImage = [UIImage imageNamed:@"play_button.png"];
    [moviePlayerView.placeholderPlayVideoButton setImage:placeholderPlayVideoButtonImage forState:UIControlStateNormal];
    [self.view addSubview:moviePlayerView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
