//
//  GQTAreaSelectViewController.m
//  learning_OC
//
//  Created by test on 4/8/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//


#import "GQTAreaSelectViewController.h"

#import "UITools.h"
#import "NSObject+SBJson.h"
#import "GQTCommons.h"


@interface GQTAreaSelectViewController (){
    int selectTag;
    
    GQTLowerArea *currentArea;
    NSDictionary *currentGroup;
}

@property (retain, nonatomic) GQTLowerArea *currentArea;
@property (retain, nonatomic) NSDictionary *currentGroup;

- (void)getAreaInfoFromServers:(NSString *)code withTag:(int)tag;
- (void)getAreaGroupInfoFromServer:(int)areaId withTag:(int)tag;

- (void)makePickerToHidden;
- (void)makePickerToShow;
@end

@implementation GQTAreaSelectViewController

@synthesize arrVillage;
@synthesize arrProv;
@synthesize arrOrgan;
@synthesize arrCity;
@synthesize pickerArr;
@synthesize currentArea;
@synthesize currentGroup;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectTag = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrCity = [[NSMutableArray alloc] initWithCapacity:0];
    arrOrgan = [[NSMutableArray alloc] initWithCapacity:0];
    arrProv = [[NSMutableArray alloc] initWithCapacity:0];
    arrVillage = [[NSMutableArray alloc] initWithCapacity:0];
    pickerArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    [GQTCommons setViewBackImage:self.view];
    [GQTCommons setViewCornerRadius:self.btn_prov];
    [GQTCommons setViewCornerRadius:self.btn_city];
    [GQTCommons setViewCornerRadius:self.btn_village];
    [GQTCommons setViewCornerRadius:self.btn_organ];
    
    [self initNavigationBar];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.label_prov setText:@"请选择"];
    
    [self getAreaInfoFromServers:@"001" withTag:selectTag];
    
    //添加聊天页面的手势处理
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
//    gestureRecognizer.cancelsTouchesInView = NO;
//    [self.view_select addGestureRecognizer:gestureRecognizer];
//    [gestureRecognizer release];
    
    [self makePickerToHidden];
}

- (void)dismissKeyBoard{
    if (self.view_select.hidden) {
        return;
    }
    
    [self makePickerToHidden];
    switch (selectTag) {
        case 0:
            {
                [self getAreaInfoFromServers:currentArea.lowerCode withTag:1];
                
            }
            break;
        case 1:
            {
                [self getAreaInfoFromServers:currentArea.lowerCode withTag:2];
            }
            break;
        case 2:
            {
                [self getAreaGroupInfoFromServer:currentArea.lowerId withTag:3];
            }
            break;
        default:
            break;
    }
    
}

- (IBAction)btnProvClick:(id)sender {
    selectTag = 0;
    
    self.pickerArr = self.arrProv;
    if ([self.pickerArr count] <= 0) {
        return;
    }
    self.currentArea = [self.pickerArr objectAtIndex:0];
    self.label_prov.text = self.currentArea.lowerName;
    [self makePickerToShow];
}

- (IBAction)btnCityClick:(id)sender {
    selectTag = 1;
    
    self.pickerArr = self.arrCity;
    if ([self.pickerArr count] <= 0) {
        return;
    }
    self.currentArea = [self.pickerArr objectAtIndex:0];
    self.label_city.text = self.currentArea.lowerName;
    [self makePickerToShow];
}

- (IBAction)btnVillageClick:(id)sender {
    selectTag = 2;
    self.pickerArr = self.arrVillage;
    
    if ([self.pickerArr count] <= 0) {
        return;
    }
    self.currentArea = [self.pickerArr objectAtIndex:0];
    self.label_village.text = self.currentArea.lowerName;
    [self makePickerToShow];
}

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

- (void)getAreaInfoFromServers:(NSString *)code withTag:(int)tag{
    NSString *urlStr = [NSString stringWithFormat:CR_URL_AREASELECT,code];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.delegate = self;
    request.tag = tag;
    request.timeOutSeconds = 30;
    [request startAsynchronous];
}

- (IBAction)btnOrganClick:(id)sender {
    selectTag = 3;
    self.pickerArr = self.arrOrgan;
    
    if ([self.pickerArr count] <= 1) {
        return;
    }
    
    self.currentGroup = [self.pickerArr objectAtIndex:0];
    [self makePickerToShow];
}

- (void)getAreaGroupInfoFromServer:(int)areaId withTag:(int)tag{
    NSString *urlStr = [NSString stringWithFormat:CR_URL_GROUPINFO,areaId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.delegate = self;
    request.tag = tag;
    [request setDidFinishSelector:@selector(RequestForGetGroupFinish:)];
    request.timeOutSeconds = 30;
    [request startAsynchronous];
}

- (IBAction)btnConfirmClick:(id)sender {
    
    if (self.currentGroup == nil) {
        [UITools showAlert:@"组织未选择" delegate:nil];
        return ;
    }
    
    if (delegate && [delegate respondsToSelector:@selector(areaSelected:)]) {
        [delegate areaSelected:self.currentGroup];
    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (IBAction)btnAreaSelectClick:(id)sender {
    [self dismissKeyBoard];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

////为了支持iOS6
-(BOOL)shouldAutorotate
{
    return YES;
}

//为了支持iOS6
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc {
    delegate = nil;
    
    [pickerArr release];
    [arrCity release];
    [arrOrgan release];
    [arrProv release];
    [arrVillage release];
    
    [_label_prov release];
    [_label_city release];
    [_label_village release];
    [_label_organ release];
    [_picker_select release];
    [_view_select release];
    [_btn_prov release];
    [_btn_city release];
    [_btn_village release];
    [_btn_organ release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setLabel_prov:nil];
    [self setLabel_city:nil];
    [self setLabel_village:nil];
    [self setLabel_organ:nil];
    [self setPicker_select:nil];
    [self setView_select:nil];
    [self setBtn_prov:nil];
    [self setBtn_city:nil];
    [self setBtn_village:nil];
    [self setBtn_organ:nil];
    [super viewDidUnload];
}

- (void)initNavigationBar{
    self.navigationItem.title = @"组织选择";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    id object = [pickerArr objectAtIndex:row];
    
    NSString *title = @"";
    
    if ([object isKindOfClass:[GQTLowerArea class]]) {
        GQTLowerArea *lower = (GQTLowerArea *)object;
        title = lower.lowerName;
    }else{
        NSDictionary *tempDic = (NSDictionary *)object;
        title = [tempDic objectForKey:@"name"];
        
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    id object = [pickerArr objectAtIndex:row];
    
    if ([object isKindOfClass:[GQTLowerArea class]]) {
        GQTLowerArea *lower = (GQTLowerArea *)object;
        switch (selectTag) {
            case 0:
                {
                    self.label_prov.text = lower.lowerName;
                    self.currentArea = lower;
                    self.label_city.text = @"请选择：";
                }
                break;
            case 1:
                {
                    self.label_city.text = lower.lowerName;
                    self.currentArea = lower;
                    self.label_village.text = @"请选择";
                }
                break;
            case 2:
                {
                    self.label_village.text = lower.lowerName;
                    self.currentArea = lower;
                }
                break;
            default:
                break;
        }
    }else{
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *group = (NSDictionary *)object;
            self.currentGroup = group;
            self.label_organ.text = [group objectForKey:@"name"];
        }
    }
    
}

#pragma mark - ASIHTTPRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *valueDic = [responseStr JSONValue];
    
    NSInteger status = [[valueDic objectForKey:@"state"] integerValue];
    if (status == 200 ) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
        
//        NSString *name = [valueDic objectForKey:@"name"];   //区域名
//        NSString *shortName = [valueDic objectForKey:@"shortname"];
        NSArray *valueList = [valueDic objectForKey:@"lowerArea"];
        
        for (NSDictionary *temp in valueList) {
            GQTLowerArea *area = [[GQTLowerArea alloc] init];
            area.lowerId = [[temp objectForKey:@"lowerId"] integerValue];
            area.lowerName = [temp objectForKey:@"lowername"];
            area.lowerShortName = [temp objectForKey:@"lowershortname"];
            area.lowerCode = [temp objectForKey:@"lowercode"];
            [tempArr addObject:area];
            [area release];
        }
        
        switch (request.tag) {
            case 0:
                {
                    [self.arrProv removeAllObjects];
                    [self.arrProv addObjectsFromArray:tempArr];
                }
                break;
            case 1:
                {
                    [self.arrCity removeAllObjects];
                    [self.arrCity addObjectsFromArray:tempArr];
                }
                break;
            case 2:
                {
                    [self.arrVillage removeAllObjects];
                    [self.arrVillage addObjectsFromArray:tempArr];
                }
                break;
                
            default:
                break;
        }
        
        [tempArr release];
    }
}

- (void)RequestForGetGroupFinish:(ASIHTTPRequest *)request{
    NSString *responseStr = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *valueDic = [responseStr JSONValue];
    
    NSInteger status = [[valueDic objectForKey:@"state"] intValue];
    if (status == 200 ) {
        NSArray *tempArr = [valueDic objectForKey:@"grouplist"];
        
        [self.arrOrgan removeAllObjects];
        [self.arrOrgan addObjectsFromArray:tempArr];
        
        if ([self.arrOrgan count] == 1) {
            NSDictionary *tempDic = [self.arrOrgan objectAtIndex:0];
            self.label_organ.text = [tempDic objectForKey:@"name"];
            
            self.currentGroup = [self.arrOrgan objectAtIndex:0];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络" delegate:nil];
}
@end
