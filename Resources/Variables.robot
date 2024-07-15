*** Variables ***
# Access
${DEV_URL}                              https://storefront:TwistedCable23@dev.davidyurman.com/
${UAT_URL}                              https://dytest:TwistedCable23@uat.davidyurman.com/
${PROD_URL}                             https://davidyurman.com/
${EPS_URL}                              https://dytest:TwistedCable23@uat-employeepurchase.davidyurman.com/
${cookies_closed}                       ${False}
${GTFL_already_closed}                  false
${LT_USERNAME}                          shariq.mohammed
${LT_ACCESS_KEY}                        PDKXggfbp3fFLe18WAr0H4eQ3Hm8qBl4hDniEHNEnawMNy2NWa

#${dev_preorder_product}                 B25992M88BFG
#${uat_preorder_product}                 192740696091

# Desktop
&{win11}                                os=Windows    osVersion=11
# Mobile
&{iPhone14}
...                                     osVersion=16
...                                     deviceName=iPhone 14 Pro Max
...                                     local=false
...                                     disableCorsRestrictions=true
...                                     preventCrossSiteTracking=false
&{iPhone13}
...                                     osVersion=15
...                                     deviceName=iPhone 13 Mini
...                                     local=false
...                                     disableCorsRestrictions=true
...                                     preventCrossSiteTracking=false
&{SamsungS22}                           osVersion=12.0    deviceName=Samsung Galaxy S22 Ultra    local=false    interactiveDebugging=true
&{SamsungS21}                           osVersion=11.0    deviceName=Samsung Galaxy S21    local=false
# Tablet
&{iPad}                                 osVersion=15    deviceName=iPad 9th    local=false
# Browsers
${chrome}                               chrome
${safari}                               safari
${edge}                                 edge
${samsung}                              samsung

# MyAccount

# Login

## SHIPPING DATA
#${REGISTERED_email}                     ana.nanu+1@gmail.com
#${REGISTERED_pwd}                       Test*1234
#${REGISTERED_email_2}                   ana.nanu10@ro.osf-global.com
#${REGISTERED_pwd_2}                     Test*1234Test*1234
#${REG_affirm_account}                   ana.nanu20@ro.osf-global.com
#${REG_affirm_pwd}                       Test*1234Test*1234
#${reg_29_name}                          Auto Test
#${reg_29_password}                      Test*1234
#${reg_29_address}                       123 Main St
#${reg_29_address_1}                     999 Main St
#${reg_29_city}                          Los Angeles
#${reg_29_city_1}                        New York
#${reg_29_state}                         California
#${reg_29_state_1}                       New York
#${reg_29_zip}                           91335
#${reg_29_zip_1}                         91338
#${reg_29_tel}                           214-323-6591
#${reg_29_tel_1}                         214-323-4578
#${GUEST_email}                          ana.nanu@osf.digital
#${GUEST_second_email}                   ana.nanu100@ro.osf-global.com
#${FIRST_NAME}                           Ana
#${Reg_FIRST_NAME}                       automation-fn
#${LAST_NAME}                            Nanu
#${Reg_LAST_NAME}                        automation-ln
#${PHONE}                                214-323-6559
#${PHONE_two}                            214-323-6543
#${ADDRESS}                              123 William Street
#${Reg_ADDRESS}                          6201 baird ave
#${ADDRESS_two}                          123 Main St
${ADDRESS2}                         Second Fake Address
#${CITY}                                 New York
#${STATE}                                NY
#${ZIP}                                  91335
#${ZIP_two}                              90022
#${ZIP_two}                              10038-3804
#${invalid_email}                        mail@mail.
#${invalid_phone}                        92345678
#${invalid_city}                         a
#${invalid_zip}                          1%a

# Payment
${visa_number}                          4111111111111111
${mastercard_number}                    5387200000000008
${discover_number}                      6011601160116611
${discover_2_number}                    6445644564456445
${amex_2_number}                        370000000000002
${amex_number}                          378282246310005
${diners_number}                        36006666333344
#${jcb_number}                           3569990010095841
${jcb_number}                           3566111111111113
${invalid_number}                       1
${invalid_csv}                          0
${invalid_card_holder}                  .
${card_exp}                             0330
${csv}                                  737
${csv_discover}                         123
${amex_csv}                             7373
${card_holder}                          test order
${visa_number_3ds}                      4917610000000000
@{credit_card_flags}                    Visa    Mastercard    Amex    Discover
@{credit_card_numbers}
...                                     ${visa_number}
...                                     ${mastercard_number}
...                                     ${discover_number}
...                                     ${amex_number}
...                                     ${visa_number_3ds}
${visa_number_expired}                  4444333322221111
${card_exp_expired}                     1020
${visa_csv_expired}                     737
${card_holder_expired}                  J. De Tester
${invalid_gcn}                          1234567890123456
${invalid_pin}                          1234
${visa_debitCardNum}                    4701322211111234
${visa_debitCard_cvv}                   837

###Affirm
#${affirm_phone_no}                      2025550199
${affirm_phone_no}                      2018732347
${affirm_pin_no}                        123456
${affirm_phone_no_CN}                   604-844-2855
${affirm_transitNo_CN}                  00257
${affirm_bankNo_CN}                     596
${affirm_bankAcNo_CN}                   021000021

###Paypal
${PAYPAL_user}                  Dypaypalsandbox_buyer3@davidyurman.com
${PAYPAL_pass}                  Yurman2017!

###Order Confirmation
@{invalid_pwds}
...                                     Le6c!
...                                     Numbpwd!
...                                     nocaps1@
...                                     NOLOWR2#
...                                     Nospecl1
${valid_password}                       Test#1234

# Country selector
@{REGIONS_ORACLE}                              Americas    Europe    Asia/Pacific    Other locations
@{COUNTRIES_ORACLE}
...    United States
...    United Kingdom
...    France

###Checkout
${checkout_info_2day_shipping_title}      Complimentary 2-day shipping
${checkout_info_30day_returns_title}      Complimentary 30-day returns
${checkout_info_boutique_pick_up_title}   Complimentary boutique pick up
${checkout_info_2day_shipping_message}    Your order should arrive in two business days if placed by 3PM ET on weekdays or if placed by 12PM ET on Saturday. Exclusions apply, including orders that ship via USPS.
...                                       Shipping estimates are based on the day and time your order is placed (excluding holidays). You can find a delivery estimate in the shipping step of checkout. Please note: all orders are subject to processing time.
${checkout_info_30day_returns_message}     We are pleased to offer a full refund for DavidYurman.com and David Yurman store purchases returned within 30 days of their purchase date.
...                                       All refunds will be made to the purchaser and issued to the original form of payment except cash purchases, which will be refunded by company check. Gift recipients may receive a merchandise credit.
...                                       Please note: Returns must be accompanied by a sales receipt or packing slip and received unaltered, unworn and in sellable condition. Some exclusions may apply.

${checkout_info_boutique_pickup_message}  Our in-store pickup service allows you to make a purchase online at DavidYurman.com and pick up the item at a participating David Yurman boutique.
...                                       Our online store locator indicates if a David Yurman boutique currently offers store pick up services. You may also select the Pick up at David Yurman boutique button on an eligible product page to find a participating store location near you to pick up the item.



#Store Data

#Authorized Data
#${SL_authorized_expected_address}               400 South Baldwin Avenue
#${SL_authorized_expected_city_state}            Arcadia, CA 91007
#${SL_authorized_expected_phone_number}          (626) 821-6363

@{expected_services}        Wedding & Engagement    Styling Services    Product Services & Repairs    Returns & Exchanges
@{expected-services_CN}     Gifting Services    Wedding & Engagement  Styling Services
@{expected_hours}           Sunday    11:00 am - 6:00 pm    Monday    10:00 am - 6:00 pm    Tuesday    10:00 am - 6:00 pm    Wednesday    10:00 am - 6:00 pm    Thursday    10:00 am - 6:00 pm    Friday    10:00 am - 7:00 pm    Saturday    10:00 am - 7:00 pm


#View Store
#${expected_store_name}                           DAVID YURMAN - GLENDALE
#${store_directions}                              34.144258,-118.256393
#https://maps.google.com/?daddr=34.144258,-118.256393


#Social links
${expected_instagram_link}                      https://www.instagram.com/davidyurman
${expected_youtube_link}                        https://www.youtube.com/c/davidyurman
${expected_facebook_link}                       https://www.facebook.com/DavidYurman
${expected_pinterest_link}                      https://www.pinterest.com/davidyurman
${expected_twitter_link}                        https://www.twitter.com/davidyurman
${expected_wechat_link}                         https://www.wechat.com/
${expected_tiktok_link}                         https://www.tiktok.com/@davidyurman

#Footer Links
@{support_links}
...                                             https://dev.davidyurman.com/customer-service/customer-care.html
...                                             https://dev.davidyurman.com/assistance/customer-care/product-care-repairs.html
...                                             https://dev.davidyurman.com/assistance/customer-care/shipping-order-tracking.html
...                                             https://dev.davidyurman.com/assistance/customer-care/returns-exchanges.html
...                                             https://dev.davidyurman.com/assistance/customer-care/ordering-payments.html
...                                             https://davidyurman.jrni.com/book#/services
...                                             https://dev.davidyurman.com/gifts/gift-cards.html

@{legal_links}
...                                             https://dev.davidyurman.com/assistance/online-privacy-notice.html
...                                             https://dev.davidyurman.com/assistance/web-accessibility-statement.html
...                                             https://dev.davidyurman.com/assistance/report-fraud.html
...                                             https://dev.davidyurman.com/assistance/california-transparency-in-supply-chains-act-of-2010.html
...                                             https://dev.davidyurman.com/assistance/online-privacy-notice.html#SpecificJurisdictions
...                                             https://dev.davidyurman.com/assistance/do-not-sell-opt-out.html

@{aboutus_links}
...                                             https://dev.davidyurman.com/world-of-yurman.html
...                                             https://davidyurman.wd1.myworkdayjobs.com/DavidYurmanCareers
...                                             https://dev.davidyurman.com/assistance/terms-and-conditions.html
...                                             https://dev.davidyurman.com/sitemap


#Gift Cards
&{gift_cards_dict}    6003920024403851=8194    6003920008015512=7584    6003920031754220=2622
...    6003920071752785=5060    6003920044177885=0751    6003920063842560=1156
...    6003920070218909=7722    6003920042780835=4579    6003920030721553=7344
...    6003920072860323=8341    6003920076220232=5706    6003920074045383=1015
...    6003920021862345=1897    6003920004844794=3375    6003920012688568=4386
...    6003920041426894=9516    6003920036788884=6031    6003920077121048=7272
...    6003920010293951=1407    6003920058904130=2420

${gift_card_number_100}         6003920015168469
${gift_card_pin_100}            8359      

#PDP
${pdp_notify_me_msg_exp}                    YOU'RE ON THE LIST
${pdp_notify_me_title_exp}                  Our team will notify you once the product is available.
${pdp_notify_me_btn_exp}                    NOTIFY ME WHEN AVAILABLE
${pdp_add_to_cart_exp}                      ADD TO BAG
${pdp_customer_care_exp}                    CONTACT CUSTOMER CARE
${pdp_designer_note_exp}                    Designer Notes
${pdp_care_exp}                             Details & Care
${pdp_gifting_exp}                          Gifting
${pdp_ymal_title_us_exp}                    You May Also Like
${pdp_emftc_title_us_exp}                   Explore More from this Collection
${pdp_trend_now_us_exp}                     Trending Now
${pdp_badge_exp}                            New Arrival


#LOGIN
${short_password}                           aaa
${invalid_password}                         Numbpwd!
${uppercase_invalid_password}               ABCDEF
${lowercase_invalid_password}               abcdef
${with_space_invalid_password}              a bcde

#Cart
${home_empty_minicart_exp}                  Your Shopping Bag is Empty.

#STATIC PAGES
${about_us_title}                           About David Yurman
@{expected_about_us_titles}                 An Artist’s Story  Our Values  Close to Our Hearts  The Journey  David Yurman Cable Book  Yurman Family Foundation  Paradise Found
@{expected_return_exchanges_titles}         What is your return policy?     How can I make a return or exchange?    How do I return or exchange an item financed with Affirm?   If I return an item financed with Affirm, will I be charged?    Can gift cards purchased on DavidYurman.com be returned?    
@{expected_customer_service_titles}         Where can I purchase David Yurman jewelry?      Where can I get more information about sizing for David Yurman jewelry?     Can David Yurman rings be resized?      Can David Yurman rings be resized?      Why is my order not going through?      How can I check or track an order I placed on DavidYurman.com?      How can I make a return or exchange?        How can I get an item repaired?     Do you offer appraisal or authentication services?      Do you offer appraisal or authentication services?      Where can I report a possible counterfeit design or website selling suspected David Yurman knock-offs?          Where can I report a possible counterfeit design or website selling suspected David Yurman knock-offs?      How do I unsubscribe from David Yurman emails, catalogs or phone calls?         How do I learn more about careers and benefits at David Yurman?
${contact_customer_care_info_title}         Contact Customer Care
@{contact_customer_care_info_text}          Phone   	1-888-398-7626		Email		Book an Appointment	    HOURS OF OPERATION      Monday-Friday: 8:30AM-7:30PM ET     Saturday & Sunday: 9:00AM-5:00PM ET

${invalid_login_error_message}              Invalid login or password. Remember that password is case-sensitive. Please try again.
##registration page text/messages
${first_name_placeHolderValue}           First Name
${last_name_placeHolderValue}            Last Name
${email_placeHolderValue}                Email
${retype_email_placeHolderValue}         Retype Email Address
${password_placeHolderValue}             Password
${retype_password_placeHolderValue}      Retype Password
${registration_form_indicatorValue}      * Indicates required fields
${password_requirement_1_value}          Is at least six characters in length
${password_requirement_2_value}          Contains at least one capital letter and one lowercase letter
${password_requirement_3_value}          Contains at least one number
${password_requirement_4_value}          Does not contain spaces
${password_requirement_5_value}          Does not contain your email address
${password_requirement_6_value}          Contains at least one special character (f.ex. !#$£€%)
${add_to_emailValue}                     Sign up to receive email updates from David Yurman about the latest collections and news. You can unsubscribe at any time at no cost. See our Privacy Policy for details.
${first_name_validationValue}            Please enter a First Name.
${last_name_validationValue}             Please enter a Last Name.
${email_validationValue}                 Please enter a valid email address
${retype_email_validationValue}          Please enter a valid email address
${password_validationValue}              Please enter a Password
${retype_password_validationValue}       Please enter a Password
${already_existing_user_validation}      User with that email address already exists.
${email_mismatch_validation}             Please enter the same value again.
${password_requirement_doesnt_match}     Sorry, the provided password does not match the required constraints.
${password_requirement_minimum_length}   This field needs 6 to 255 characters

##Order Confirmation
${shipping_delivery_date_message}                  Order today for delivery

###Shipping
${shipping_email_empty_err}                         Please enter a valid email address
${shipping_fn_empty_err}                            Please enter your first name.
${shipping_ln_empty_err}                            Please enter your last name.
${shipping_phone_empty_err}                         Please enter your telephone number.
${shipping_phone_invalid_err}                       Please enter a valid 10-digit telephone number.
${shipping_addr1_empty_err}                         Please enter your address.
${shipping_city_empty_err}                          Please enter your city.
${shipping_city_invalid_err}                        Please use at least 2 characters (you are currently using 1 character).
${shipping_state_empty_err}                         Please select a state.
${shipping_zip_empty_err}                           Please enter your ZIP code.
${shipping_zip_invalid_err}                         Please enter a valid 5 or 9-digit ZIP code.

${REG_affirm_account}                   ana.nanu20@ro.osf-global.com
${REG_affirm_pwd}                       Test*1234Test*1234

####
${Delivery_Person_First_Name}       delivery
${Delivery_Person_Last_Name}        testman
${Delivery_Person_Phone}            0808080808

###paypal billing address
${paypal_firstname}     dypaypalsandbox
${paypal_lastname}      buyerthree
${paypal_address1}      1 Main St
${paypal_address2}
${paypal_city}           San Jose
${paypal_state}          California
${paypal_postalcode}     95131
${paypal_country}        United States
${paypal_phone}          090-909-0909

##Choose Country
${choose_country_button}     xpath://a[@class='choosecountry']
${choose_country_dropdown}   xpath:(//div[@class='selectric'])[2]
