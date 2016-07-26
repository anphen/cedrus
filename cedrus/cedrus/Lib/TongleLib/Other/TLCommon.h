//
//  TLCommon.h
//  TL11
//
//  Created by liu on 15-4-20.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//


// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


// 2.获得RGB颜色
#define TLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define  ScreenBounds [UIScreen mainScreen].bounds

// 3.自定义Log
#ifdef DEBUG
#define TLLog(...) NSLog(__VA_ARGS__)
#else
#define TLLog(...)
#endif


// 4.数据存储
#define TLUserDefaults [NSUserDefaults standardUserDefaults]

// 5.全局背景色
#define TLGlobalBg TLColor(232, 232, 232)

// 昵称
#define TLNameFont [UIFont systemFontOfSize:15]

// 昵称
#define TLShopFont [UIFont systemFontOfSize:10]

#define TLSignaFont [UIFont systemFontOfSize:14]
// 时间
#define TLTimeFont [UIFont systemFontOfSize:12]
// 来源
#define TLSourceFont TLTimeFont
// 内容
#define TLContentFont TLSignaFont
// 转发的昵称
#define TLRetweetNameFont [UIFont systemFontOfSize:15]
// 转发的内容
#define TLRetweetContentFont TLRetweetNameFont

/*
 6.一条帖子上的颜色
 */
// 昵称
#define TLNameColor TLColor(88, 88, 88)
// 会员昵称颜色
#define TLMBNameColor TLColor(244, 103, 8)
// 时间
#define TLTimeColor TLColor(246, 157, 46)
// 内容
#define TLContentColor TLColor(52, 52, 52)
// 来源
#define TLSourceColor TLColor(153, 153, 153)
// 被转发昵称
#define TLRetweetNameColor TLColor(81, 126, 175)
// 被转发内容
#define TLRetweetContentColor TLColor(109, 109, 109)
// 原帖昵称颜色
#define TL_FIRST_POST_NAME_COLOR  TLColor(67, 107, 163)

#define TL_FIRST_POST_TITLE_COLOR TLColor(90, 90, 90)

#define TL_USER_NAME_COLOR @"576b95"
//原帖时间颜色
#define TL_FIRST_POST_TIME_COLOR @"737373"
//按键边框颜色
#define  TL_BORDER_COLOR @"cccccc"
//魔店字体颜色
#define  TL_TEXT_COLOR  @"3d4245"

//我的魔店字体颜色
#define  TL_MY_SHOP_TEXT_COLOR  @"e1303a"

//商品支付页面tableview背景颜色
#define  TL_PROD_PURCH_BACK_GROUND_COLOR @"f9f9f9"
//购物车图标按键背景颜色
#define  TL_SHOPPINGCAR_BACK_GROUND_COLOR @"e7e7e7"
//加入购物车按键背景颜色
#define  TL_ADD_SHOPPINGCAR_BACK_GROUND_COLOR @"93d4f9"
//加入立即购买按键背景颜色
#define  TL_BUY_BACK_GROUND_COLOR     @"7fcbf7"

//编辑边框颜色
#define  TL_BORDER_COLOR_FIELD @"72c6f7"

// 宽度320魔店昵称字体
#define TL_Shop_Font_320 [UIFont systemFontOfSize:8]
// 首页更多按键字体大小
#define TL_MORE_TEXT_FONT [UIFont systemFontOfSize:12]

/**
 *  导航栏中间title字体大小
 */
#define TL_NAVI_TITLE_FONT  [UIFont systemFontOfSize:17]

/**
 7.一些距离常量
 */
/** cell的边框宽度 */
extern const int TLCellBorderWidth;
/** tableView的边框宽度 */
extern const int TLTableBorderWidth;
/** cell之间的间距 */
extern const int TLCellMargin;
/** Dock的高度 */
extern const int TLStatusDockH;


//8.图片尺寸
/** 中等头像宽高 */
extern const int TLIconWH;
/** 小头像宽高 */
extern const int TLIconSmallWH;
/** 大头像宽高 */
extern const int TLIconBigWH;
/** 认证图标宽高 */
extern const int TLVerifiedWH;
/** 会员图标宽高 */
extern const int TLMBWH;
/** 1张图片的尺寸 */
extern const int TLOnePhotoWH;
/** 多张图片的尺寸 */
extern const int TLMultiPhotoWH;

//广告栏高度
extern const int TLAdHeight;

//广告翻页时间(s)
extern const int TLAd_Page_Time;

//导航栏title中心距离状态栏的Y值
extern const int TL_NAVI_TITLE_CENTER_Y;
//导航栏高度
extern const int TL_NAVI_BIG_HEIGHT;
//二维码图片宽高
extern const int TL_QRCODE_WH;
//页码中心点相对于广告图片X值
extern const float TL_PAGECONTROL_X;
//页码中心点相对于广告图片Y值
extern const float TL_PAGECONTROL_Y;

//9.基本数据归档
#define TLBaseDataFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"basedata.data"]
//10 地址数据归档
#define TLAddressDataFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0] stringByAppendingPathComponent:@"address.data"]

//11 每天消费数据归档
#define TLMyDayFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0] stringByAppendingPathComponent:@"myday.data"]

//12 每周消费数据归档
#define TLMyWeekFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0] stringByAppendingPathComponent:@"myWeek.data"]


//13 每月消费数据归档
#define TLMyMonFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0] stringByAppendingPathComponent:@"myMon.data"]


//14 每年消费数据归档
#define TLMyYearFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0] stringByAppendingPathComponent:@"myYear.data"]


//9.基本数据MD5归档
#define TLBaseDataFilePathMd5 [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"basedatamd5.data"]

//15支付方式
#define CashOD          @"0"
#define Alipay_Client   @"1"
#define Alipay_Net      @"2"
#define Online_Bank     @"3"
#define Cash            @"4"
#define Hui_Le_Coin     @"9"

//16 广告活动件数
#define limit_size @"8"

//17 下拉刷新件数
#define DownAmount @"20"
//18 上拉刷新件数
#define UpAmount @"10"


//19商品明细入口
#define prod_activity       @"1"
#define prod_post           @"2"
#define prod_order          @"3"
#define prod_code           @"4"
#define prod_shopCarProd    @"5"
#define prod_mstore         @"6"
#define prod_collect        @"7"
#define prod_meBoby         @"8"
#define prod_otherBody      @"9"
#define prod_hot            @"10"
#define prod_org            @"11"


//20会员帖子入口
#define homePageMaster  @"1"
#define linkMaster      @"2"
#define codeMaster      @"3"

//21活动模式类型
#define activityProd    @"0"
#define activityPost    @"1"
#define activityShop    @"2"
#define activityMaster  @"3"


//22 状态栏尺寸
#define STATUS_FRAME [[UIApplication sharedApplication] statusBarFrame]

//23 首页更多魔店跳转标志位
#define   MAIN_TO_SHOP  @"maintoshop"

//24 翻页方向(下拉，上拉)
#define PAGEDOWN @"1"
#define PAGEUP @"2"
//加载数据
#define LOADDATA @"1"

#define PROD_EVA_COUNT @"5"

//25 storyboard文件名
#define STORYBOARD  @"Tongle_Base"

//26 控制器表识符
//#define  TL_PROD_PURCHASE  @"prodpurchase" //商品详情
#define  TL_POST_DETAIL    @"postdetail"   //帖子详情
#define  TL_MOSHOP         @"moshop"       //魔店详情
#define  TL_MASTER_SUPER   @"mastersuper"  //达人详情
#define  TL_CHECKOUT       @"checkout"     //立即支付

//27 入口标志
#define  TL_ACTION  @"action"

//28 sugue标识
#define  TL_MAIN_MO_SHOP        @"mainmoshop"   //主页跳转魔店详情
#define  TL_MAIN_POST           @"mainpost"     //主页跳转到帖子详情
#define  TL_COLLLECT_MOSHOP     @"moshop"       //收藏跳转到魔店详情
#define  TL_SUPER_MASTER        @"super_master" //收藏跳转到达人详情页面
#define  TL_PEOPLE_TO_MASTER    @"peopletomaster"//我的人脉到达人详情
#define  TL_MASTER_POST         @"masterpost"    //达人帖子列表跳转到帖子详情
#define  TL_MASTER_PRODUCT      @"masterproduct" //达人商品跳转商品详情
#define  TL_POST_DETAIL_S       @"postDetail"    //帖子列表跳转帖子详情
#define  TL_PROD_PURCHASE       @"prodpurchase"  //收藏商品到商品详情
#define  TL_NOSHOP_PRODUCT      @"moshopproduct" //魔店详情里面的商品跳转到商品详情
#define  TL_PROD_MESSAGE        @"prodMessage"   //产品详情跳转到产品信息
#define  TL_SEARCH_SUGUE        @"search"        //发现页面跳转到搜索结果的页面
#define  TL_FIND_MASTER         @"findmaster"    //发现达人列表跳转到达人详情
#define  TL_FIND_POST           @"findpost"      //发现帖子列表跳转到帖子详情
#define  TL_FIND_SHOP           @"findshop"      //发现魔店列表跳转到魔店详情
#define  TL_FIND_PROD           @"findprod"      //发现产品列表跳转到产品详情
#define  TL_SHOP_CAR_PROD       @"shopcarprod"   //购物车商品列表跳转到商品详情
#define  TL_ORDER_ADDRSS        @"address"       //提交订单跳转到地址选择控制器
#define  TL_ORDER_DELIVERIES    @"deliveries"    //提交订单跳转到送货方式
#define  TL_ORDER_DELIVERIES_DATE     @"deliveriesData"    //提交订单跳转到送货日期
#define  TL_CHOICE_TO_MANAGE_ADDRESS  @"choicetomanageaddress" //选择地址控制器跳转到地址管理控制器
#define  TL_REVISE_ADDRESS      @"reviseaddress" //地址管理跳转到修改地址控制器
#define  TL_MYBABY_TO_PROD      @"mybobytodetail"//我的宝贝控制器到产品详情
#define  TL_MY_PEOPLE_TO_MASTER @"peopletomaster"//我的关注人跳转到达人详情
#define  TL_MYORDER_DETAIL      @"myorderdetail" //我的订单跳转到订单详情
#define  TL_MYORDER_EVALUTION   @"myorderevalution" //我的订单跳转到评价订单
#define  TL_ORDER_FETAIL_TO_PROD_DETAIL  @"orderdetailtoproddetail" //订单详情跳转到产品详情
#define  TL_ORDER_DETAIL_EVA    @"orderdetaileva"  //订单详情跳转到订单评价

//29 达人id存储标识
#define TL_MASTER @"master"
//商品详情中商品ID存储标识
#define TL_PROD_DETAILS_PROD_ID @"prodDetailsProd_id"

//30 收藏类别
#define TL_COLLECT_TYPE_PROD   @"0"
#define TL_COLLECT_TYPE_SHOP   @"1"
#define TL_COLLECT_TYPE_MASTER @"2"
#define TL_COLLECT_TYPE_POST   @"3"
#define TL_COLLECT_TYPE_BABY   @"4"

//user_id
#define TL_USER_ID             @"user_id"

//31 user_token
#define TL_USER_TOKEN             @"user_token"
#define TL_USER_TOKEN_REQUEST     user_token
#define TL_USER_TOKEN_REQUEST_1   _user_token

//32 转发类型
#define TL_TONGLE @"1"
#define TL_WEIBO  @"2"
#define TL_WEIXIN @"3"

//33查找类型
#define TL_SEARCH_PROD   @"0"
#define TL_SEARCH_SHOP   @"1"
#define TL_SEARCH_MASTER @"2"
#define TL_SEARCH_POST   @"3"
#define TL_SEARCH_ORG    @"4"


//34收益类型
#define TL_CONSUMPTION_INTEGRAL @"1"
#define TL_INTEGRAL_REBATE      @"2"
#define TL_ACCOUNT_BALANCE      @"3"

//年月日
#define TL_DAY  @"1"
#define TL_WEEK @"2"
#define TL_MOON @"3"
#define TL_YEAR @"4"

#define TLPhone_number @"phone_number"
#define TLPassword @"password"
#define TLAutoLogin @"auto_login"
#define TLRememPsw @"rememPsw"

//移动平台编号
#define TL_DEVICE_IOS           @"1"
#define TL_DEVICE_IPAD          @"2"
#define TL_DEVICE_ANDROID_PHONE @"3"
#define TL_DEVICE_ANDROID_PAD   @"4"

//订单过滤
#define TL_ALL_ORDER    @"0"
#define TL_WAIT_REVIEW  @"1"
#define TL_WAIT_PAY     @"2"
#define TL_WAIT_RECEIVE @"3"
#define TL_EVALUATED_1    @"4"


//订单状态
#define TL_NEW_ORDER    @"0"
#define TL_AUDIT        @"1"
#define TL_PAID         @"2"
#define TL_DELIVERY     @"3"
#define TL_NO_EVALUATED @"4"
#define TL_EVALUATED    @"5"
#define TL_REJECTION    @"6"
#define TL_OBLIGATION   @"7"

//评价
#define TL_ALL     @"0"
#define TL_BEST    @"1"
#define TL_BETTER  @"2"
#define TL_BAD     @"3"

//应用注册scheme,在tongle-Info.plist定义URL types
#define TL_APPSCHEME   @"ChouKe"

//微信
#define TL_WXAPPID  @"wxa44de924715e51b9"
#define TL_WXAPPSECRET @"04f00d143acc9c7f52ee9eeab74275b8"
#define TL_WXAPPKey @"L8LrMqqeGRxST5reouB0K66CaYAWpqhAVsq7ggKkxHCOastWksvuX1uvmvQclxaHoYd3ElNBrNO2DHnnzgfVG9Qs473M3DTOZug5er46FhuGofumV8H2FVR9qkjSlC5K"
//微博
#define TL_WBAPPID  @"863300294"
#define TL_WBAPPSECRET @"46e905e64f14da0301dc7950d12529d7"

//引导页面标识
#define TLLEADKRY @"leadkey"
//首次自动登录
#define TLAUTOLAND @"firstautoland"
//性别
#define BOY     @"1"
#define GIRL    @"2"

//taba页
#define TLBASETABA   @"tabbar"

#define APPTYPE @"apptype"

//
#define TLYES     @"0"
#define TLNO        @"1"


#define TLBUY_USER_ID @"buy_user_id"

#define  TLRECENTLY_VERSION_LINK  @"recently_version_link"

//app内部编号
#define APP_INNER_NO @"03"

//登录用户类型标识
#define TL_USER_TYPE @"user_type"
//游客登录标识
#define TL_USER_TOURIST   @"3"
//会员登录标识
#define TL_USER_MEMBER    @"2"
//消费者登录标识
#define TL_USER_CONSUMER  @"1"

//收藏提示
#define TL_COLLECT_SUCCESS         @"添加收藏成功"
#define TL_COLLECT_CANCEL_SUCCESS  @"取消收藏成功"

#define TL_COLLECT_MY_SUCCESS         @"从我的收藏取消收藏成功"
#define TL_COLLECT_MY_CANCEL_SUCCESS  @"从我的宝贝取消收藏成功"

//加入购物车
#define TL_ADD_SHOPCAR_SUCCESS  @"加入购物车成功"

//转发
#define TL_SHARE_SUCCESS  @"转发成功"
#define TL_SHARE_FAIL     @"转发失败"
#define TL_WEIXING_SHARE_FAIL     @"转发失败,请安装微信客户端"

//扫码
#define TL_CODE_SUCCESS     @"扫码成功"
//
#define TL_CODE_AUTO     @"将二维码放入框内,即可自动扫描"
//
#define TL_CODE_MINE     @"我的二维码"

//语音
#define TL_LISTEN_SUCCESS   @"语音识别成功"

//购物车商品编辑提示
#define TL_SHOPCAR_EDIT_TIPS   @"没有可编辑的商品"

//购物车商品删除
#define TL_SHOPCAR_DELETE_SUCCESS   @"商品删除成功"

//默认收货地址提示
#define TL_ADDRESS_ADD_TIPS   @"请完善收货联系信息"

//填写发票抬头提示
#define TL_INVOICE_TIPS     @"请填写发票抬头"


//订单提交成功
#define TL_ORDER_SUCCESS     @"订单提交成功"

//加载地址提示
#define TL_ADDRESS_LOADING     @"正在加载地址..."

//删除地址提示
#define TL_ADDRESS_DELETE     @"删除地址成功"

//地址设置默认提示
#define TL_ADDRESS_DEFAULT     @"默认设置成功"

//地址新建提示
#define TL_ADDRESS_CREATE_SUCCESS     @"地址新建成功"

//地址修改提示
#define TL_ADDRESS_CHANGE_SUCCESS     @"地址修改成功"

//地址邮编无效提示
#define TL_ADDRESS_CODE_FAIL    @"邮编号码无效"
//手机号码无效提示
#define TL_IPHONE_NO_FAIL    @"手机号码无效"

//信息添加提示
#define TL_MESSAGE_FAIL    @"必要信息不能为空"

//移动设备版本(iphone)
#define MOBILE_OS_NO_IPHONE  @"1"

//用户不升级的版本号
#define TL_CANCEL_UP_NO    @"cancel_up_no"


//维度
#define  TL_LATITUDE   @"latitude"

//经度

#define  TL_LONGITUDE   @"longitude"


