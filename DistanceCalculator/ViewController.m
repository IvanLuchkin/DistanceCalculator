//
//  ViewController.m
//  DistanceCalculator
//
//  Created by Ivan Luchkin on 20.07.2020.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *request;

@property (weak, nonatomic) IBOutlet UITextField *startingLocation;

@property (weak, nonatomic) IBOutlet UITextField *firstDestination;
@property (weak, nonatomic) IBOutlet UILabel *firstDistance;


@property (weak, nonatomic) IBOutlet UITextField *secondDestination;
@property (weak, nonatomic) IBOutlet UILabel *secondDistance;


@property (weak, nonatomic) IBOutlet UITextField *thirdDestination;
@property (weak, nonatomic) IBOutlet UILabel *thirdDistance;

@property (weak, nonatomic) IBOutlet UITextField *fourthDestination;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UILabel *fourthDistance;

@end

@implementation ViewController

- (IBAction)calculateButtonTapped:(id)sender {
    self.calculateButton.enabled = NO;
    self.request = [DGDistanceRequest alloc];
    
    NSString *startingLoc = self.startingLocation.text;
    NSString *firstDest = self.firstDestination.text;
    NSString *secondDest = self.secondDestination.text;
    NSString *thirdDest = self.thirdDestination.text;
    NSString *fourthDest = self.fourthDestination.text;

    
    NSArray *dests = @[firstDest, secondDest, thirdDest, fourthDest];
    
    self.request = [self.request initWithLocationDescriptions:dests sourceDescription:startingLoc];
    __weak ViewController *weakSelf = self;
    
    self.request.callback = ^(NSArray *results) {
        ViewController *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        NSNull *badResult = [NSNull null];
        
        if(results[0] != badResult) {
            strongSelf.firstDistance.text = [NSString stringWithFormat:@"%.2f km", ([results[0] floatValue] / 1000)];
        } else {
            strongSelf.firstDistance.text = @"Unknown Location";
        }
        
        if(results[1] != badResult) {
            strongSelf.secondDistance.text = [NSString stringWithFormat:@"%.2f km", ([results[1] floatValue] / 1000)];
        } else {
            strongSelf.secondDistance.text = @"Unknown Location";
        }
        
        if(results[2] != badResult) {
            strongSelf.thirdDistance.text = [NSString stringWithFormat:@"%.2f km", ([results[2] floatValue] / 1000)];
        } else {
            strongSelf.thirdDistance.text = @"Unknown Location";
        }
        
        if(results[3] != badResult) {
            strongSelf.fourthDistance.text = [NSString stringWithFormat:@"%.2f km", ([results[3] floatValue] / 1000)];
        } else {
            strongSelf.fourthDistance.text = @"Unknown Location";
        }
        
        strongSelf.request = nil;
        strongSelf.calculateButton.enabled = YES;
    };
    [self.request start];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
