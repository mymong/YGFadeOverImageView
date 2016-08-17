//
//  ViewController.m
//  Test11FadeOverImageView
//
//  Created by Jason Yang on 16/8/17.
//  Copyright © 2016年 YG. All rights reserved.
//

#import "ViewController.h"
#import "FadeOverImageView.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet FadeOverImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSliderValueChanged:(UISlider *)sender {
    self.durationLabel.text = [NSString stringWithFormat:@"%.1f", sender.value];
    self.imageView.duration = [self.durationLabel.text floatValue];
}

- (IBAction)onSegmentControlValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.imageView sd_cancelCurrentImageLoad];
            [self.imageView setImage:nil];
            break;
        case 1:
            [self.imageView sd_cancelCurrentImageLoad];
            [self.imageView setImage:[UIImage imageNamed:@"Sample"]];
            break;
        case 2: {
            NSURL *url = [NSURL URLWithString:@"http://img06.tooopen.com/images/20160815/tooopen_sy_175638814153.jpg"];
            SDWebImageManager *mgr = [SDWebImageManager sharedManager];
            NSString *key = [mgr cacheKeyForURL:url];
            [mgr.imageCache removeImageForKey:key];
            [self.imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageDelayPlaceholder];
            break;
        }
        default:
            break;
    }
}

@end
