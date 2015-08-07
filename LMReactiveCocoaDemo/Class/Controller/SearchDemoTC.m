//
//  SearchDemoTC.m
//  LMReactiveCocoaDemo
//
//  Created by 李蒙 on 15/8/7.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "SearchDemoTC.h"
#import <ReactiveCocoa.h>
#import <LMKit.h>

@interface SearchDemoTC ()

@property (strong, nonatomic) NSMutableArray *searchTexts;

@property (strong, nonatomic) NSArray *searchResults;

@property(assign, nonatomic, getter = isSearching) BOOL searching;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchDemoTC

- (NSMutableArray *)searchTexts {
    
    if (!_searchTexts) {
        
        self.searchTexts = [NSMutableArray array];
        
        for (NSInteger index = 0; index < 20; index++) {
            
            switch ([self lm_randomInteger:0 to:2]) {
                case 0:
                    [_searchTexts addObject:[self lm_randomChinese:[self lm_randomInteger:2 to:4]]];
                    break;
                case 1:
                    [_searchTexts addObject:[self lm_randomEnglish:[self lm_randomInteger:3 to:5]]];
                    break;
                case 2:
                    [_searchTexts addObject:@([self lm_randomInteger:0 to:999]).stringValue];
                    break;
                default:
                    break;
            }
        }
    }
    
    return _searchTexts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    RAC(self, searchResults) = [self rac_liftSelector:@selector(search:) withSignals:[[self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)] map:^id(RACTuple *tuple) {
        
        return tuple.second;
        
    }], nil];
    
    RAC(self, searching) = [[RACSignal merge:@[[[self rac_signalForSelector:@selector(searchDisplayControllerDidBeginSearch:) fromProtocol:@protocol(UISearchDisplayDelegate)] mapReplace:@YES], [[self rac_signalForSelector:@selector(searchDisplayControllerDidEndSearch:) fromProtocol:@protocol(UISearchDisplayDelegate)] mapReplace:@NO]]] doNext:^(id x) {
        
        if ([x boolValue]) {
            LMLog(@"打开搜索");
        } else {
            LMLog(@"取消搜索");
        }
    }];
}

- (NSArray *)search:(NSString *)searchText
{
    NSMutableArray *results = [NSMutableArray array];
    
    for (NSString *text in self.searchTexts) {
        
        if([[text lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) {
            
            [results addObject:text];
        }
    }
    
    return results;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearching) {
        
        return self.searchResults.count;
    }
    
    return self.searchTexts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.isSearching ? self.searchResults[indexPath.row] : self.searchTexts[indexPath.row];
    
    return cell;
}

@end
