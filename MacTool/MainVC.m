//
//  MainVC.m
//  MacTool
//
//  Created by Song on 2018/6/28.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "MainVC.h"
#import "Popvc.h"

@interface MainVC ()<NSTableViewDataSource,NSTabViewDelegate>
@property (weak) IBOutlet NSTableView *tableView;



@property(nonatomic,strong)NSArray * dataArr;



@end

@implementation MainVC



- (NSString *)runCommand:(NSString *)commandToRun
{
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c" ,
                          [NSString stringWithFormat:@"%@", commandToRun],
                          nil];
    NSLog(@"run command: %@",commandToRun);
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file = [pipe fileHandleForReading];
    
    
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    
    return [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
//    [self runCommand:@"ls"];
    
    /*
     /Users/zhangsongwei/Library/Developer/Xcode/DerivedData/MacTool-eknomxmlskbuzucylxvwgnbodmhh/Build/Products/Debug
     */
    
    
//    NSString shellPath = @"/Users/lengshengren/Desktop/tool/LSUnusedResources-master/simian/bin";
//    //脚本路径
//    NSString* path =[shellPaht stringByAppendingString:@"/aksimian.sh"];
//
//    NSTask *task = [[NSTask alloc] init];
//    [task setLaunchPath: @"/bin/sh"];
//    //数组index 0 shell路径, 如果shell 脚本有输入参数,可以加入数组里，index 1 可以输入$1 @[path,@"$1"],依次延后。
//    NSArray *arguments =@[path];
//    [task setArguments: arguments];
//    [task launch];
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/"];
    
    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-l" , nil];
    [task setArguments: @[@""]];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data
                                   encoding: NSUTF8StringEncoding];
    
    NSMutableArray * arr = [NSMutableArray array];
    for (NSString * str in [string componentsSeparatedByString:@"\n"]) {
        if (str.length > 0) {
            [arr addObject:str];
        }
    }
    
    _dataArr = arr;
    NSLog (@"got\n%@", string);
    NSLog (@"got\n%@", arr);
    
    [_tableView reloadData];
    
    
    
    
    
}
-(void)openRoot{
    
    AuthorizationRef authorizationRef;
    OSStatus status;
    
    status = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment, kAuthorizationFlagDefaults, &authorizationRef);
    
    // Run the tool using the authorization reference
    char *tool = "/sbin/dmesg";
    char *args[] = {NULL};
    FILE *pipe = NULL;
    
    status = AuthorizationExecuteWithPrivileges(authorizationRef, tool, kAuthorizationFlagDefaults, args, &pipe);
    
    // Print to standard output
    char readBuffer[128];
    if (status == errAuthorizationSuccess)
    {
        for (;;)
        {
            int bytesRead = read(fileno(pipe), readBuffer, sizeof(readBuffer));
            if (bytesRead < 1) break;
            write(fileno(stdout), readBuffer, bytesRead);
        }
    } else
    {
        NSLog(@"Authorization Result Code: %d", status);
    }
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
    
    return 1;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectTableColumn:(nullable NSTableColumn *)tableColumn{
    
    
    NSLog(@"tableColumn-%@",tableColumn);
    return 1;
}

@end
