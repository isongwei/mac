//
//  Popvc.m
//  MacTool
//
//  Created by Song on 2018/6/28.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "Popvc.h"
#import "DragDropView.h"

@interface Popvc ()<NSTableViewDataSource,NSTabViewDelegate>
@property (weak) IBOutlet NSTableView *tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property (weak) IBOutlet NSSearchField *mySearchField;
@end

@implementation Popvc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initData];
    
}

-(void)initView{
    
    NSActionCell *searchCell = [[self.mySearchField cell]searchButtonCell];
    NSActionCell *cancelCell = [[self.mySearchField cell]cancelButtonCell];
    
    searchCell.target = self;
    searchCell.action = @selector(searchButtonClicked:);
    
    cancelCell.target = self;
    cancelCell.action = @selector(cancellButtonClicked:);
    
}
#pragma mark --  点击搜索按钮
- (void)searchButtonClicked:(id)sender {
    NSLog(@"search\n");
    NSSearchField *search = sender;
    NSLog(@"%@", search.stringValue);
}

#pragma mark -- 点击取消按钮
- (void)cancellButtonClicked:(id)sender {
    NSLog(@"cancell");
    self.mySearchField.stringValue = @"";
}

-(void)initData{
    NSString *rootPath = NSHomeDirectory();
    NSArray * arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData",rootPath] error:nil];
    NSLog(@"rootPath--%@",arr);
    _dataArr = [NSMutableArray array];
    for (NSString * str in arr) {
        if ([str rangeOfString: @"."].length == 0) {
            if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData/%@/Build/Products/Release-iphoneos",NSHomeDirectory(),str]]){
                NSArray * detailArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData/%@/Build/Products/Release-iphoneos",NSHomeDirectory(),str] error:nil];
                    NSLog(@"--%@",detailArr);
                for (NSString * ss in detailArr) {
                    if ([ss rangeOfString:@".app"].location == ss.length-4) {
                        
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        
                        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData/%@/Build/Products/Release-iphoneos/%@",NSHomeDirectory(),str,ss] error:nil];
                        NSDate *fileModDate = [fileAttributes objectForKey:NSFileModificationDate];

                        
                        
                        [_dataArr addObject:[NSString stringWithFormat:@"%@-%@",fileModDate,ss]];
                    }
                }
            }
        }
    }
    [_tableView reloadData];
    
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return _dataArr.count;
    
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    
    if (_dataArr.count) {
        NSTableCellView * cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
        cell.textField.stringValue = _dataArr[row];
        return cell;
    }else{
        return nil;
    }
    
    
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    NSLog(@"row-%li",row);
    
    
    NSArray * detailArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData/%@/Build/Products/Release-iphoneos",NSHomeDirectory(),_dataArr[row]] error:nil];
    
    
    return 1;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectTableColumn:(nullable NSTableColumn *)tableColumn{
    
    
    NSLog(@"tableColumn-%@",tableColumn);
    return 1;
}

@end
