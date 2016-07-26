//
//  Url.h
//  tongle
//
//  Created by liu on 15-4-28.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#ifndef tongle_Url_h
#define tongle_Url_h


//正式版：http://117.78.37.252/api/1.1/   (从1.0升级）
//测试版：http://117.78.37.252/api/2.0/  （没变）
//#define Url @"http://117.78.37.252/api/1.1/"
#define Url @"http://117.78.37.252/api/2.0/"
//#define Url @"http://117.78.37.252:4000/"
//#define Url @"http://210.51.24.80:5000/"
//#define Url @"http://210.22.156.23:2000/"
//5000
/**
 *  1008
 *
 *  @return url
 */
#define  ads_Url  @"/system/homepage_ads"
/**
 *  2010
 *
 *  @return url
 */
#define  user_mstores_Url  @"/favorites/user_mstores"
/**
 *  1011
 */
#define  friends_posts_Url  @"/my/friends_posts"

/**
 *  1012
 */
#define friends_Url @"/my/friends"
/**
 *  2021
 */
#define add_Url @"/favorites/add"

/**
 *  1088
 */
#define remove_Url @"/favorites/remove"

/**
 *  1086
 */
#define user_show_Url @"/qrcode/user_show"
/**
 *  2020
 */
#define user_posts_Url @"/favorites/user_posts"
/**
 *  1018
 */
#define posts_user_posts_Url @"/posts/user_posts"
/**
 *  2013
 */
#define promote_products_Url @"/my/promote_products"
/**
 *  2019
 */
#define user_products_Url @"/favorites/user_products"
/**
 *  2011
 */
#define mstores_show_Url  @"/mstores/show"
/**
 *  1084
 */
#define mstore_show_Url  @"/qrcode/mstore_show"
/**
 *  1089
 */
#define post_show_Url @"/posts/post_show"
/**
 *  1022
 */
#define products_show_Url @"/products/show"
/**
 *  1085
 */
#define product_show_Url @"/qrcode/product_show"
/**
 *  1024
 */
#define image_text_show_Url @"/products/image_text_show"
/**
 *  1023
 */
#define specification_show_Url @"/products/specification_show"
/**
 *  1046
 */
#define evaluation_show_Url @"/products/evaluation_show"
/**
 *  1045
 */
#define evaluation_create_Url @"/products/evaluation_create"
/**
 *  1090
 */
#define search_Url @"/tools/search"
/**
 *  2029
 */
#define hot_search_Url @"/tools/hot_search"
/**
 *  1026
 */
#define shopping_carts_show_Url @"/shopping_carts/show"
/**
 *  1030
 */
#define my_addresses_Url @"/my/addresses"
/**
 *  1033
 */
#define address_remove_Url @"/my/address_remove"
/**
 *  2023
 */
#define address_default_Url @"/my/address_default"
/**
 *  1031
 */
#define address_create_Url @"/my/address_create"
/**
 *  1032
 */
#define address_modify_Url @"/my/address_modify"
/**
 *  1080
 */
#define product_types_Url @"/system/product_types"
/**
 *  1081
 */
#define product_types_create_Url @"/my/product_types_create"
/**
 *  1002
 */
#define verification_code_send_Url @"system/verification_code_send"
/**
 *  1079
 */
#define password_retrieve_Url @"system/password_retrieve"
/**
 *  2018
 */
#define base_data_Url @"system/base_data"
/**
 *  1004
 */
#define login_Url @"system/login"

/**
 *  2044
 */
#define templogin_Url @"system/Templogin"

/**
 *  2015
 */
#define app_promote_Url @"/system/app_promote"
/**
 *  2012
 */
#define personal_info_show_Url @"/my/personal_info_show"
/**
 *  2016
 */
#define fans_Url @"/my/fans"
/**
 *  1016
 */
#define friendships_create_Url @"/friendships/create"
/**
 *  1040
 */
#define user_orders_Url @"/orders/user_orders"
/**
 *  2014
 */
#define incomes_Url @"/my/incomes"
/**
 *  1003
 */
#define register_Url @"system/register"
/**
 *  1010
 */
#define password_reset_Url @"system/password_reset"
/**
 *  1041
 */
#define orders_show_Url @"/orders/show"
/**
 *  1042
 */
#define orders_remove_Url @"/orders/remove"
/**
 *  2025
 */
#define user_agreement_Url @"system/user_agreement"
/**
 *  2026
 */
#define function_introduction_Url @"system/function_introduction"
/**
 *  2027
 */
#define qa_service_Url @"system/qa_service"
/**
 *  2028
 */
#define contact_Url @"system/contact"
/**
 *  1001
 */
#define version_check_Url  @"system/version_check"
/**
 *  1029
 */
#define orders_create_Url @"/orders/create"
/**
 *  1079
 */
#define password_modify_Url @"/system/password_modify"

/**
 *  1020
 */
#define repost_Url @"/posts/repost"

/**
 *  2022
 */
#define prod_repost_Url @"/products/repost"

/**
 *  1064
 */
#define scan_decode_Url @"/tools/scan_decode"

/**
 *  1025
 */
#define shopping_carts_create_Url @"/shopping_carts/create"

/**
 *  2024
 */
#define confirm_Url @"/orders/confirm"

/**
 *  1027
 */
#define item_remove_Url @"/shopping_carts/item_remove"
/**
 *  2033
 */
//获取服务器端支付数据地址
#define weixin_pay_parameter_Url   @"/orders/weixin_pay_parameter"

/**
 *  2034
 */
#define alipay_parameter_Url   @"/orders/alipay_parameter"

/**
 *  2032
 */
#define pay_result_search_Url  @"/orders/pay_result_search"

/**
 *  2017
 */
#define base_data_md5_Url  @"system/base_data_md5"
/**
 *  1049
 */
#define personal_info_modify @"/my/personal_info_modify"


/**
 *  1077
 */
#define listen_decode_Url @"/tools/voice_decode"

/**
 *  2041
 */
#define re_customers_Url @"/tools/re_customers"

/**
 *  2035
 */
#define expert_user_info_Url @"/user/expert_user_info"

/**
 *  2040
 */
#define scan_user_decode_Url @"/tools/scan_user_decode"

/**
 *  2042
 */
#define balance_Url @"/shopping_carts/balance"

//1048
#define points_Url @"/my/points"

//1028
#define item_modify_Url @"/shopping_carts/item_modify"

//6007
#define  gp_product_show_Url    @"/gp_product/show"

//6008
#define  shop_list_show_Url    @"/system/shop_list_show"

//
#define  gp_coupons_Url    @"/my/gp_coupons"

//6009
#define  gp_product_order_create_Url    @"/gp_product/order_create"

//6010
#define  useful_vouchers_info_Url    @"/orders/useful_vouchers_info"
//6010
#define  gp_coupon_show_Url    @"/gp_coupon/show"

//6012
#define   orders_gp_orders_Url   @"/orders/gp_orders"
//6013
#define   orders_gp_order_detail_Url   @"/order/gp_orders_detail"

//6014
#define   orders_my_vouchers_info_Url   @"/orders/my_vouchers_info"

#endif
