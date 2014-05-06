//
//  GQTTypeSelectViewController.m
//  learning_OC
//
//  Created by test on 4/29/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTTypeSelectViewController.h"

#import "GQTCommons.h"
#import "NSObject+SBJson.h"
#import "UITools.h"

@interface GQTTypeSelectViewController (){
    GQTypeInfo *m_currentTypeInfo;
}

@property (retain, nonatomic) GQTypeInfo *m_currentTypeInfo;

- (void)getTypeInfoFromServers:(NSString *)typeId withTag:(int)tag;
@end

@implementation GQTTypeSelectViewController

@synthesize delegate;
@synthesize m_firstArr;
@synthesize m_pickerArr;
@synthesize m_secondArr;
@synthesize m_typeLabel;
@synthesize m_typeSecLabel;
@synthesize view_select;
@synthesize picker_select;

@synthesize m_currentTypeInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    selectTag = 0;
    m_pickerArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_firstArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_secondArr = [[NSMutableArray alloc] initWithCapacity:0];
    [self makePickerToHidden];
    self.m_typeSecLabel.text = @"请选择";
    [self getTypeInfoFromServers:@"1" withTag:selectTag];
    self.m_typeSecLabel.hidden = YES;
    self.m_typeSelectSecBtn.hidden = YES;
    
     [GQTCommons setViewCornerRadius:self.m_typeSelectOneBtn];
     [GQTCommons setViewCornerRadius:self.m_typeSelectSecBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [m_currentTypeInfo release];
    [m_pickerArr release];
    [m_firstArr release];
    [m_secondArr release];
    
    [view_select release];
    [picker_select release];
    [m_typeLabel release];
    [m_typeSecLabel release];
    
    [_m_typeSelectOneBtn release];
    [_m_typeSelectSecBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setView_select:nil];
    [self setPicker_select:nil];
    [self setM_typeLabel:nil];
    [self setM_typeSecLabel:nil];

    [self setM_typeSelectOneBtn:nil];
    [self setM_typeSelectSecBtn:nil];
    [super viewDidUnload];
}

- (void)initNavigationBar{
    self.navigationItem.title = @"身份选择";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

- (IBAction)click_confirmTypeSelect:(id)sender {
    
    if (!self.m_currentTypeInfo.isLeaf && selectTag == 0) {
        self.m_typeSecLabel.hidden = NO;
        self.m_typeSecLabel.text = @"请选择";
        self.m_typeSelectSecBtn.hidden = NO;
    }else if(self.m_currentTypeInfo.isLeaf && selectTag == 0){
        self.m_typeSecLabel.hidden = YES;
        self.m_typeSelectSecBtn.hidden = YES;
    }
    
    [self dismissKeyBoard];
}

- (IBAction)clickTypeSelectConfirmBtn:(id)sender {
    if (self.m_currentTypeInfo == nil) {
        [UITools showAlert:@"身份未选择" delegate:nil];
        return ;
    }
    
    if (delegate && [delegate respondsToSelector:@selector(typeSelect:)]) {
        [delegate typeSelect:self.m_currentTypeInfo];
    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (IBAction)clickSelectTypeBtn:(id)sender {
    selectTag = 0;
    
    self.m_pickerArr = self.m_firstArr;
    if ([self.m_pickerArr count] <=0) {
        return;
    }
    
    self.m_currentTypeInfo = [self.m_pickerArr objectAtIndex:0];
    self.m_typeSecLabel.text = self.m_currentTypeInfo.typeName;
    [self makePickerToShow];
}

- (IBAction)clickNextSelectBtn:(id)sender {
    selectTag = 1;
    
    self.m_pickerArr = self.m_secondArr;
    if ([self.m_pickerArr count] <=0) {
        return;
    }
    
    self.m_currentTypeInfo = [self.m_pickerArr objectAtIndex:0];
    [self makePickerToShow];
}

- (void)dismissKeyBoard{
    if (self.view_select.hidden) {
        return;
    }
    
    [self makePickerToHidden];
    
    switch (selectTag) {
        case 0:
        {
            [self getTypeInfoFromServers:[NSString stringWithFormat:@"%d",m_currentTypeInfo.typeId] withTag:1];
            
        }
            break;
        case 1:
        {
            [self getTypeInfoFromServers:[NSString stringWithFormat:@"%d",m_currentTypeInfo.typeId] withTag:2];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - picker hidden or show
- (void)makePickerToShow{
    [self.view_select setHidden:NO];
    [self.picker_select setHidden:NO];
    [self.view_select setUserInteractionEnabled:YES];
    [self.picker_select reloadAllComponents];
    [self.view bringSubviewToFront:self.view_select];
    [self.view bringSubviewToFront:self.picker_select];
}

- (void)makePickerToHidden{
    [self.picker_select setHidden:YES];
    [self.view_select setHidden:YES];
    [self.view_select setUserInteractionEnabled:NO];
    [self.view sendSubviewToBack:self.view_select];
}

#pragma mark - picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [m_pickerArr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    id object = [m_pickerArr objectAtIndex:row];
    
    NSString *title = @"";
    
    if ([object isKindOfClass:[GQTypeInfo class]]) {
        GQTypeInfo *type = (GQTypeInfo *)object;
        title = type.typeName;
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    id object = [m_pickerArr objectAtIndex:row];
    
    if ([object isKindOfClass:[GQTypeInfo class]]) {
        GQTypeInfo *type = (GQTypeInfo *)object;
        switch (selectTag) {
            case 0:
            {
                self.m_typeLabel.text = type.typeName;
                self.m_currentTypeInfo = type;
                self.m_typeSecLabel.text = type.isLeaf ? @"请选择：" : @"";
            }
                break;
            case 1:
            {
                self.m_typeSecLabel.text = type.typeName;
                self.m_currentTypeInfo = type;
            }
                break;
                
                break;
            default:
                break;
        }
    }
    
}

- (void)getTypeInfoFromServers:(NSString *)typeId withTag:(int)tag{
    NSString *urlStr = [NSString stringWithFormat:CR_URL_TYPESELECT,typeId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.delegate = self;
    request.tag = tag;
    request.timeOutSeconds = 30;
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *valueDic = [responseStr JSONValue];
    
//    {"message":" 获取数据成功！","state":200,"types":[{"typeName":"非团 员","isLeaf":true,"typeId":3},{"typeName":"团 员","isLeaf":false,"typeId":2}]}
    
    NSInteger status = [[valueDic objectForKey:@"state"] integerValue];
    if (status == 200 ) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSArray *valueList = [valueDic objectForKey:@"types"];
        
        for (NSDictionary *temp in valueList) {
            GQTypeInfo *type = [[GQTypeInfo alloc] init];
            type.typeId = [[temp objectForKey:@"typeId"] integerValue];
            type.typeName = [temp objectForKey:@"typeName"];
            type.isLeaf = [[temp objectForKey:@"isLeaf"] boolValue];
            [tempArr addObject:type];
            [type release];
        }
        
        switch (request.tag) {
            case 0:
            {
                [self.m_firstArr removeAllObjects];
                [self.m_firstArr addObjectsFromArray:tempArr];
            }
                break;
            case 1:
            {
                [self.m_secondArr removeAllObjects];
                [self.m_secondArr addObjectsFromArray:tempArr];
            }
                break;
                
            default:
                break;
        }
        
        [tempArr release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络" delegate:nil];
}


@end
