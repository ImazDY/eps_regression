*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/DataReader.robot
Resource          ../Keywords/Cart.robot
*** Keywords ***
Click on Sign In button from Checkout
    Wait Until Element Is Visible    ${checkout_signin_l}    10s    Sign In button is not displayed
    Click Element    ${checkout_signin_l}
    Wait Until Element Is Visible    ${checkout_email_l}    10s    Email field is not displayed
    Wait Until Element Is Visible    ${checkout_pwd_l}    10s    Password field is not displayed

Click on forgot password button from Checkout
    Wait Until Element Is Visible    xpath://a[@id='password-reset']
    Click Element    xpath://a[@id='password-reset']

Verify forgot password slideout from checkout page
    Run Keyword And Warn On Failure   Wait Until Element Is Visible    xpath://h4[@class='modal-title']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h4[@class='modal-title']    Forgot Your Password?
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='forgotpassword-title']    To reset your password, please enter your email address and click submit.
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://label[@for='reset-password-email']    Email
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://button[@id='submitEmailButton']    SUBMIT
    Click Element    xpath://button[@id='submitEmailButton']
    Run Keyword And Warn On Failure   Wait Until Element Is Visible    xpath://label[@for='reset-password-email']//following-sibling::div[@class='invalid-feedback']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://label[@for='reset-password-email']//following-sibling::div[@class='invalid-feedback']    Please enter a valid email address
    Check and Input text    xpath://input[@id='reset-password-email']    ${guest_valid}
    Click Element    xpath://button[@id='submitEmailButton']
    Run Keyword And Warn On Failure   Wait Until Element Is Visible    xpath://div[@class='request-password-body']/p
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='request-password-body']/p    If you are registered with the email address provided, we’ll send you a link to reset your password shortly.
    Close forgot password slide out

Close forgot password slide out
    Run Keyword And Warn On Failure   Wait Until Element Is Visible    xpath:(//button[@data-dismiss='modal'])[1]
    Click Element    xpath:(//button[@data-dismiss='modal'])[1]


Click on Paypal button from Page
    [Arguments]    ${page}
    IF    "${page}" == "identification"
        Wait Until Page Contains Element    ${paypal_idntf_btn_l}    30s    Paypal button is not yet visible
        Wait Until Page Contains Element    ${paypal_btn_container_l}    30s    Paypal button is not yet visible
        Mouse Click    ${paypal_btn_container_l}
    ELSE IF  '${page}' in ['checkout']
        Select Frame    xpath:(//iframe[@title='PayPal'])[1]
        Wait Until Page Contains Element    ${paypal_btn_container_l}    30s    Paypal button is not yet visible
        Mouse Click     ${paypal_btn_container_l}
    ELSE IF  '${page}' in ['minicart','cart']
#        Select Frame    xpath://iframe[contains(@id,'jsx')]
        Wait Until Page Contains Element    ${paypal_btn_container_l}    30s    Paypal button is not yet visible
        Mouse Click     ${paypal_btn_container_l}
    END
    Sleep    10s    #to be improved

Enter login credentials during checkout
    [Arguments]    ${user}    ${pwd}
    Clear Element Text   ${checkout_email_l}
    Clear Element Text   ${checkout_pwd_l}
    CommonWeb.Check and Input text    ${checkout_email_l}    ${user}
    CommonWeb.Check and Input text    ${checkout_pwd_l}    ${pwd}

Click on Sign In button during checkout
    Click Element    ${checkout_signin_submit_l}
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${checkout_signin_email_l}    10s    Email is not visible

Sign in during checkout
    Enter login credentials during checkout    ${guest_valid}    ${NewUser_Pwd}
    Click on Sign In button during checkout

Check Info Texts During Checkout
    Scroll To Bottom
    Sleep  3s
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@data-content='two-day-shipping'])[2]   ${checkout_info_2day_shipping_message}
    CommonWeb.Check and Click    xpath:(//a[@data-content='two-day-shipping'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_2day_shipping_title}
    ${2DayText}  Get Text    xpath://div[@class='order-summary-content']
    Run Keyword And Warn On Failure    Should Contain Text    ${2DayText}   ${checkout_info_2day_shipping_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible
    
    Scroll To Element    xpath:(//a[@data-content='30-day-returns'])[2]
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@data-content='30-day-returns'])[2]   ${checkout_info_30day_returns_title}
    CommonWeb.Check and Click    xpath:(//a[@data-content='30-day-returns'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_30day_returns_title}
    ${30DayText}  Get Text    xpath://div[@class='order-summary-content']
    Run Keyword And Warn On Failure    Should Contain Text    ${30DayText}   ${checkout_info_30day_returns_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible

   IF  '${shopLocale}' in ['US', 'CN']
    Scroll To Element    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]   ${checkout_info_boutique_pick_up_title}
    CommonWeb.Check and Click    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_boutique_pick_up_title}
    ${boutiqueText}  Get Text    xpath://div[@class='order-summary-content']
    Run Keyword And Warn On Failure    Should Contain Text    ${boutiqueText}   ${checkout_info_boutique_pickup_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible
   END

Hover over Minicart
    Mouse Over    ${minicart_icon_l}

Click on Checkout button from Minicart
    Mouse Over    ${minicart_icon_l}
    Wait Until Element Is Visible    css:.popover.show a[href*='checkout']    10s    Minicart modal is not visible
    Click Element    css:.popover.show a[href*='checkout']


Enter valid Store PickUp Guest details
    [Arguments]    ${GUEST_EMAIL}   ${FIRST_NAME}   ${LAST_NAME}  ${PHONE}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_email}    timeout=3s
    Run Keyword If    ${shippingMail}     Scroll To Element   ${guest_bopis_email}
    Run Keyword If    ${shippingMail}     CommonWeb.Check and Input text          ${guest_bopis_email}    ${GUEST_email}
    ${shippingName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_fn}    timeout=3s
    Run Keyword If    ${shippingName}     Scroll To Element   ${guest_bopis_fn}
    Run Keyword If    ${shippingName}     CommonWeb.Check and Input text          ${guest_bopis_fn}    ${FIRST_NAME}
    ${shippingLastName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_ln}    timeout=3s
    Run Keyword If    ${shippingLastName}     Scroll To Element   ${guest_bopis_ln}
    Run Keyword If    ${shippingLastName}     CommonWeb.Check and Input text          ${guest_bopis_ln}    ${LAST_NAME}
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_phone}    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   ${guest_bopis_phone}
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          ${guest_bopis_phone}    ${PHONE}

Click checkout as guest button
    Click Element    xpath://a[contains(text(),'Checkout as Guest')]

Click Back to bag button from checkout page
   Click Element    xpath:(//a[@title='Continue Shopping'])[1]

Sign in during checkout for EU
    CommonWeb.Check and Input text    xpath://input[@id='login-form-email']     ${guest_valid}
    CommonWeb.Check and Input text    xpath://input[@id='login-form-password']  ${NewUser_Pwd}
    CommonWeb.Check and Click    xpath://button[@id='btnLoginSubmit']
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Run Keyword And Warn On Failure   Element Should Contain    xpath://input[@id='CheckoutData_Email']   ${guest_valid}
    Unselect Frame
    
Verify checkout page shipping information for logged in user
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//h2[contains(@class,'card-header-checkout')])[3]      Shipping Information
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'shipping-email')]     ${guest_valid}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'selectric-userAddress')]//span    Select a Saved Address
    Click Element    xpath://div[contains(@class,'selectric-userAddress')]
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://ul//div[@class='customer-name']       ${FIRST_NAME} ${LAST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://ul//div[@class='customer-address']    ${NewUser_StreetAddress}, ${NewUser_Flat}, ${NewUser_City}, ${NewUser_State}, ${NewUser_Zipcode}, ${Country}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://ul//div[@class='customer-phone']      ${NewUser_Phone}
    Click Element    xpath://div[contains(@class,'selectric-userAddress')]
    Run Keyword And Warn On Failure    Element Should Not Be Visible    xpath://ul//div[@class='customer-name']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'selected-address-block')]/div[@class='customer-name']      ${FIRST_NAME} ${LAST_NAME}
    ${address}  Get Text    xpath://div[contains(@class,'selected-address-block')]/div[@class='customer-address']
    ${normalized_address}=    Replace String    ${address}    \s+    ${EMPTY}
    Run Keyword And Warn On Failure    Run Keyword And Warn On Failure   Should Be Equal As Strings    ${normalized_address}   ${NewUser_StreetAddress}${NewUser_Flat}${NewUser_City},${NewUser_State},${NewUser_Zipcode}${Country}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'selected-address-block')]/div[@class='customer-phone']     ${NewUser_Phone}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'option-shipping-address-edit')]     Edit
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://button[contains(@class,'btn-add-new')]    Add New Address

Click edit shipping information
   Wait Until Element Is Visible    xpath://p[contains(@class,'option-shipping-address-edit')]
   Click Element    xpath://p[contains(@class,'option-shipping-address-edit')]
   Wait Until Element Is Visible    xpath://span[@class='form-edit-title']

Click Add new address
   Wait Until Element Is Visible    xpath://button[text()='Add New Address']
   Click Element    xpath://button[text()='Add New Address']
   Wait Until Element Is Visible    xpath://h3[contains(@class,'shipping-form-title')]//span[contains(@class,'new-title')]



Verify checkout page your information for logged in user
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//h2[contains(@class,'card-header-checkout')])[3]   Your Information
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'shipping-email-text')]   ${guest_valid}


    
Verify delivery details in checkout page
     [Arguments]   ${deliveryType}
     Wait Until Page Contains Element    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     Scroll Element Into View    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${checkout_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${checkout_product_price}    Remove currency and comma from price    ${checkout_product_price}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${checkout_product_price}    ${PDP_product_1_price}
     Scroll Element Into View    xpath://div[@class='line-product-name']
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='line-product-name']  ${PDP_product_1_primary_name} ${PDP_product_1_secondary_name}
     Scroll Element Into View    xpath://span[@class='line-product-description']
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[@class='line-product-description']   ${PDP_product_1_secondary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'delivery-icon')]/span    (1 Item)
    IF  '${deliveryType}' in ['delivery']
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'delivery-icon')]     Delivery
   ELSE IF  '${deliveryType}' in ['pick up']
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'in-store-icon')]     Pick Up In Store
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[contains(@class,'store-name-accordion')]   ${bopis_storeName}
     Click Element   xpath://span[contains(@class,'store-name-accordion')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address    ${bopis_storeDetails}
     Click Element   xpath://span[contains(@class,'store-name-accordion')]
     Element Should Not Be Visible    xpath://span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'alternative-pickup-title')]    ${FIRST_NAME} ${LAST_NAME} will be required to present a valid government-issued ID to pick up this order.
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath://input[contains(@class,'store-pickup-alternate-checkbox')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://label[contains(@for,'storePickupAlternativePerson')]    Change pickup person
   ELSE IF  '${deliveryType}' in ['pre order']
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'delivery-icon')]     Pre-Order
   END

Check Change delivery person checkbox
     Click Element    xpath://input[contains(@class,'store-pickup-alternate-checkbox')]//parent::div/label
     Run Keyword And Warn On Failure    Wait Until Page Contains Element    xpath://p[contains(@class,'alternative-pickup-title')]     timeout=10s
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'alternative-pickup-title')]    Phone number will only be used for the fulfillment of orders. The pick up person will be required to present a valid government-issued ID to pick up this order.
     
     
Fill Change delivery person form
     Sleep  2s
     Run Keyword And Warn On Failure    Wait Until Element Is Visible    xpath://input[contains(@class,'inStoreFirstName')]
     Check and Input text    xpath://input[contains(@class,'inStoreFirstName')]    ${Delivery_Person_First_Name}
     Check and Input text    xpath://input[contains(@class,'inStoreLastName')]     ${Delivery_Person_Last_Name}
     Check and Input text    xpath://input[contains(@class,'inStorePhoneNumber')]  ${Delivery_Person_Phone}

Check total in checkout page order summary for 2 products
   [Arguments]  ${shippingType}
   ${checkout_order_summary_total}  Get Text    xpath:(//p[contains(@class,'grand-total-sum')])[2]//parent::div//following-sibling::div//span
   ${checkout_order_summary_total}  Remove currency and comma from price     ${checkout_order_summary_total}
   ${sales_tax}  Get Text  xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]//parent::div//following-sibling::div//span
   ${sales_tax}  Remove currency and comma from price    ${sales_tax}
   IF  '${sales_tax}' in ['Complimentary']
    ${sales_tax}  Remove Letters   ${sales_tax}
    ${sales_tax}  Set Variable  0
   END
  IF  '${shippingType}' in ['2-day','3 to 5 days', 'pick up']
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price} + ${sales_tax}
  ELSE
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price} + ${sales_tax} + 17
  END
   ${total_sum}   Evaluate    round(${total_sum}, 2)
   ${total_sum}  Convert To String    ${total_sum}
   Run Keyword And Warn On Failure   Should Be Equal As Strings    ${checkout_order_summary_total}    ${total_sum}

Check total in checkout page order summary
   [Arguments]  ${shippingType}
   ${checkout_order_summary_total}  Get Text    xpath:(//p[contains(@class,'grand-total-sum')])[2]//parent::div//following-sibling::div//span
   ${checkout_order_summary_total}  Remove currency and comma from price     ${checkout_order_summary_total}

  IF  '${shoplocale}' in ['US','UK','IT','FR','GR']
    ${sales_tax}  Return sales tax - US
  ELSE IF  '${shoplocale}' in ['CN']
    ${sales_tax}  Return sales tax - CN
  END
  IF  '${shippingType}' in ['2-day','3 to 5 days', 'pre order', 'pick up']
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${sales_tax}
  ELSE
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${sales_tax} + 17
  END
    ${total_sum}  Convert To String    ${total_sum}
    Run Keyword And Warn On Failure   Should Be Equal As Strings    ${checkout_order_summary_total}    ${total_sum}


Check if complimentary links are displayed in checkout page
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath:(//a[contains(@data-content,'two-day-shipping')])[2]
   Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[contains(@data-content,'two-day-shipping')])[2]   Complimentary 2-day shipping
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath:(//a[contains(@data-content,'30-day-returns')])[2]
   Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[contains(@data-content,'30-day-returns')])[2]  Complimentary 30-day returns
  IF  '${shopLocale}' in ['US', 'CN']
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath:(//a[contains(@data-content,'complimentary-boutique-pick-up')])[2]
   Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[contains(@data-content,'complimentary-boutique-pick-up')])[2]  Complimentary boutique pick up
  END

Verify delivery details in checkout page for 2 products
     [Arguments]   ${deliveryType}  ${size}  ${size2}
   IF  '${deliveryType}' in ['delivery']
     Wait Until Element Is Visible    xpath://h2[contains(@class,'delivery-icon')]
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'delivery-icon')]     Delivery
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'delivery-icon')]/span    (2 Items)
   ELSE IF  '${deliveryType}' in ['pick up','pick up same store']
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'in-store-icon')]    Pick Up In Store
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'in-store-icon')]/span    (2 Items)
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[contains(@class,'store-name-accordion')]   ${bopis_storeName}
     Click Element   xpath://span[contains(@class,'store-name-accordion')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address    ${bopis_storeDetails}
     Click Element   xpath://span[contains(@class,'store-name-accordion')]
     Element Should Not Be Visible    xpath://span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'alternative-pickup-title')]    ${FIRST_NAME} ${LAST_NAME} will be required to present a valid government-issued ID to pick up this order.
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath://input[contains(@class,'store-pickup-alternate-checkbox')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://label[contains(@for,'storePickupAlternativePerson')]    Change pickup person

   ELSE IF  '${deliveryType}' in ['pick up different store']
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'in-store-icon')]    Pick Up In Store
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'in-store-icon')]/span    (2 Items)
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//span[contains(@class,'store-name-accordion')])[1]   ${bopis_storeName}
     Click Element   xpath:(//span[contains(@class,'store-name-accordion')])[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address)[1]    ${bopis_storeDetails}
     Click Element   xpath:(//span[contains(@class,'store-name-accordion')])[1]
     Element Should Not Be Visible    xpath:(//span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address)[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'alternative-pickup-title')])[1]    ${FIRST_NAME} ${LAST_NAME} will be required to present a valid government-issued ID to pick up this order.
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//input[contains(@class,'store-pickup-alternate-checkbox')])[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//label[contains(@for,'storePickupAlternativePerson')])[1]    Change pickup person
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//span[contains(@class,'store-name-accordion')])[2]   ${bopis_storeName}
     Click Element   xpath:(//span[contains(@class,'store-name-accordion')])[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address)[2]    ${bopis_storeDetails}
     Click Element   xpath:(//span[contains(@class,'store-name-accordion')])[2]
     Element Should Not Be Visible    xpath:(//span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address)[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'alternative-pickup-title')])[2]    ${FIRST_NAME} ${LAST_NAME} will be required to present a valid government-issued ID to pick up this order.
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//input[contains(@class,'store-pickup-alternate-checkbox')])[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//label[contains(@for,'storePickupAlternativePerson')])[2]    Change pickup person
   ELSE IF  '${deliveryType}' in ['pre order']
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'delivery-icon')]     Pre-Order
   END
##First product details
     Wait Until Page Contains Element    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     Scroll Element Into View    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${checkout_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${checkout_product_price}    Remove currency and comma from price    ${checkout_product_price}
     Should Be Equal    ${checkout_product_price}    ${PDP_product_2_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-product-name'])[1]
     ${checkout_product_primary_name}    Get Text    xpath:(//div[@class='line-product-name'])[1]
     Should Contain   ${checkout_product_primary_name}   ${PDP_product_2_primary_name}
     Wait Until Element Is Visible    xpath:(//span[@class='line-product-description'])[1]
     ${checkout_product_secondary_name}    Get Text    xpath:(//span[@class='line-product-description'])[1]
     Run Keyword And Warn On Failure  Should Be Equal    ${checkout_product_secondary_name}    ${PDP_product_2_secondary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]    Size ${size2}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-pricing-info')])[1]   Qty 1
##second product details
     Wait Until Page Contains Element    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${checkout_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${checkout_product_price}    Remove currency and comma from price    ${checkout_product_price}
     Should Be Equal    ${checkout_product_price}    ${PDP_product_1_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-product-name'])[2]
     ${checkout_product_primary_name}    Get Text    xpath:(//div[@class='line-product-name'])[2]
     Should Contain   ${checkout_product_primary_name}   ${PDP_product_1_primary_name}
     Wait Until Element Is Visible    xpath:(//span[@class='line-product-description'])[2]
     ${checkout_product_secondary_name}    Get Text    xpath:(//span[@class='line-product-description'])[2]
     Run Keyword And Warn On Failure  Should Contain    ${checkout_product_secondary_name}    ${PDP_product_1_secondary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[2]    Size ${size}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-pricing-info')])[1]   Qty 1

Verify delivery details in checkout page for 2 products different store
     [Arguments]   ${size}  ${size2}
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'in-store-icon')]    Pick Up In Store
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'in-store-icon')]/span    (2 Items)
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//span[contains(@class,'store-name-accordion')])[1]   ${bopis_storeName}
     Click Element   xpath:(//span[contains(@class,'store-name-accordion')])[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address)[1]    ${bopis_storeDetails}
     Click Element   xpath:(//span[contains(@class,'store-name-accordion')])[1]
     Element Should Not Be Visible    xpath:(//span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address)[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'alternative-pickup-title')])[1]    ${FIRST_NAME} ${LAST_NAME} will be required to present a valid government-issued ID to pick up this order.
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//input[contains(@class,'store-pickup-alternate-checkbox')])[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//label[contains(@for,'storePickupAlternativePerson')])[1]    Change pickup person
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//span[contains(@class,'store-name-accordion')])[2]   ${bopis_storeName}
     Click Element   xpath:(//span[contains(@class,'store-name-accordion')])[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address)[2]    ${bopis_storeDetails}
     Click Element   xpath:(//span[contains(@class,'store-name-accordion')])[2]
     Element Should Not Be Visible    xpath:(//span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address)[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'alternative-pickup-title')])[2]    ${FIRST_NAME} ${LAST_NAME} will be required to present a valid government-issued ID to pick up this order.
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//input[contains(@class,'store-pickup-alternate-checkbox')])[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//label[contains(@for,'storePickupAlternativePerson')])[2]    Change pickup person
##First product details
     Wait Until Page Contains Element    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     Scroll Element Into View    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${checkout_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${checkout_product_price}    Remove currency and comma from price    ${checkout_product_price}
     Should Be Equal    ${checkout_product_price}    ${PDP_product_1_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-product-name'])[1]
     ${checkout_product_primary_name}    Get Text    xpath:(//div[@class='line-product-name'])[1]
     Should Contain   ${checkout_product_primary_name}   ${PDP_product_1_primary_name}
     Wait Until Element Is Visible    xpath:(//span[@class='line-product-description'])[1]
     ${checkout_product_secondary_name}    Get Text    xpath:(//span[@class='line-product-description'])[1]
     Run Keyword And Warn On Failure  Should Be Equal    ${checkout_product_secondary_name}    ${PDP_product_1_secondary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]    Size ${size2}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-pricing-info')])[1]   Qty 1
##second product details
     Wait Until Page Contains Element    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${checkout_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${checkout_product_price}    Remove currency and comma from price    ${checkout_product_price}
     Should Be Equal    ${checkout_product_price}    ${PDP_product_2_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-product-name'])[2]
     ${checkout_product_primary_name}    Get Text    xpath:(//div[@class='line-product-name'])[2]
     Should Contain   ${checkout_product_primary_name}   ${PDP_product_2_primary_name}
     Wait Until Element Is Visible    xpath:(//span[@class='line-product-description'])[2]
     ${checkout_product_secondary_name}    Get Text    xpath:(//span[@class='line-product-description'])[2]
     Run Keyword And Warn On Failure  Should Contain    ${checkout_product_secondary_name}    ${PDP_product_2_secondary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[2]    Size ${size}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-pricing-info')])[1]   Qty 1

Verify order summary in checkout page
    [Arguments]  ${shippingType}  ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'summary-header-title')]    Order Summary
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[2]
    Run Keyword And Warn On Failure   Element Should Contain     xpath:(//div[@class='line-product-name-wrapper'])[2]    ${PDP_product_1_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[2]/span    ${PDP_product_1_secondary_name}
    ${product_price}   Get Text  xpath:(//div[contains(@class,'line-item-total-price-amount')])[3]
    ${product_price}   Remove currency and comma from price    ${product_price}
    Run Keyword And Warn On Failure   Should Be Equal As Strings   ${product_price}  ${PDP_product_1_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[3]    Size ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[2]    Qty 1
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@aria-controls='promoCodeBlockInner'])[2]    Add Promo Code
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]    Subtotal
    ${price}   Get Text   xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]//parent::div//following-sibling::div//span
    ${price}   Remove currency and comma from price    ${price}
    Run Keyword And Warn On Failure   Should Be Equal As Strings   ${price}   ${PDP_product_1_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]    Shipping
   IF  '${shippingType}' in ['2-day', 'pick up', 'pre order']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]//parent::div//following-sibling::div//span    Complimentary
   ELSE IF  '${shippingType}' in ['Overnight']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]//parent::div//following-sibling::div//span    $17
   END
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]    Sales Tax
    Element Text Should Not Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]//parent::div//following-sibling::div//span    ${EMPTY}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'grand-total-sum')])[2]    Total
    Check total in checkout page order summary  ${shippingType}

Verify order summary in checkout page for 2 products
    [Arguments]  ${shippingType}  ${size}  ${size2}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'summary-header-title')]    Order Summary
##First Product details
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[3]
    Run Keyword And Warn On Failure   Element Should Contain     xpath:(//div[@class='line-product-name-wrapper'])[3]    ${PDP_product_2_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[3]/span    ${PDP_product_2_secondary_name}
    ${checkout_product_1_price}   Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[5]
    ${checkout_product_1_price}   Remove currency and comma from price    ${checkout_product_1_price}
    Run Keyword And Warn On Failure   Should Be Equal As Strings    ${checkout_product_1_price}    ${PDP_product_2_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[7]    Size ${size2}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[3]   Qty 1
###Second Product details
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[4]
    Run Keyword And Warn On Failure   Element Should Contain     xpath:(//div[@class='line-product-name-wrapper'])[4]   ${PDP_product_1_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[4]/span    ${PDP_product_1_secondary_name}
    ${checkout_product_2_price}   Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[6]
    ${checkout_product_2_price}   Remove currency and comma from price    ${checkout_product_2_price}
    Run Keyword And Warn On Failure   Should Be Equal As Strings   ${checkout_product_2_price}  ${PDP_product_1_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[10]    Size ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[4]   Qty 1

    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@aria-controls='promoCodeBlockInner'])[2]    Add Promo Code
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]    Subtotal
    ${subTotal}   Evaluate    ${PDP_product_2_price} + ${PDP_product_1_price}
    ${order_subTotal}   Get Text   xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]//parent::div//following-sibling::div//span
    ${order_subTotal}   Remove currency and comma from price    ${order_subTotal}
    Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_subTotal}    ${subTotal}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]    Shipping
   IF  '${shippingType}' in ['2-day', 'pick up']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]//parent::div//following-sibling::div//span    Complimentary
   ELSE IF  '${shippingType}' in ['Overnight']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]//parent::div//following-sibling::div//span    $17
   END
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]    Sales Tax
    Run Keyword And Warn On Failure    Element Text Should Not Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]//parent::div//following-sibling::div//span    ${EMPTY}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'grand-total-sum')])[2]    Total
    Check total in checkout page order summary for 2 products  ${shippingType}

Check virtual gift card details in checkout
     IF  '${shopLocale}' in ['US']
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-product-name-wrapper')])[2]    US Virtual Gift Card
     ELSE IF  '${shopLocale}' in ['CN']
        Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]    CA Virtual Gift Card
     END
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[5]    Recipient
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[6]    ${GiftCard_Recipient_FirstName} (${GiftCard_Recipient_Email})
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[7]    Sender
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[8]    ${GiftCard_Sender_Name}

Verify order summary is correct in checkout page for VGC
     ${order_summary_subtotal}   Get Text    xpath:(//span[contains(@class,'sub-total')])[2]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[@class='order-receipt-label']/span)[3]    Shipping
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[@class='order-receipt-label']/span)[4]    Sales Tax
     ${order_summary_shipping}   Get Text    xpath:(//span[contains(@class,'shipping-total')])[2]
     ${order_summary_salesTax}   Get Text    xpath:(//span[contains(@class,'tax-total')])[4]
     ${order_summary_salesTax}   Remove currency and comma from price    ${order_summary_salesTax}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_subtotal}    100
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_salesTax}    0

Check gift card details in checkout
     IF  '${shopLocale}' in ['US']
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-product-name-wrapper')])[2]    $2000 Gift Card
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[8]    Country US
     ELSE IF  '${shopLocale}' in ['CN']
        Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]    C$2000 Gift Card
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[8]    Country CA
     END
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[7]      Gift Card Type Physical
        
Verify order summary is correct in checkout page for GC
     ${order_summary_subtotal}   Get Text    xpath:(//span[contains(@class,'sub-total')])[2]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[@class='order-receipt-label']/span)[3]    Shipping
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[@class='order-receipt-label']/span)[4]    Sales Tax
     ${order_summary_shipping}   Get Text    xpath:(//span[contains(@class,'shipping-total')])[2]
     ${order_summary_salesTax}   Get Text    xpath:(//span[contains(@class,'tax-total')])[4]
     ${order_summary_salesTax}   Remove currency and comma from price    ${order_summary_salesTax}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_subtotal}    2000
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_salesTax}    0

#Verify Order Summary in checkout page - US
#
#
#Verify Order Summary in checkout page - CN


Return sales tax - CN
    ${order_summary_gst/hst}  Get Text   (//span[contains(text(),'GST/HST')]/parent::*/parent::*)[2]/following-sibling::*//*//*
    ${order_summary_gst/hst}  Remove currency and comma from price  ${order_summary_gst/hst}

    ${order_summary_pst/qst}  Get Text  (//span[contains(text(),'PST')]/parent::*/parent::*)[2]/following-sibling::*//*//*
    ${order_summary_pst/qst}  Remove currency and comma from price  ${order_summary_pst/qst}

    ${order_summary_salesTax}  Evaluate  ${order_summary_gst/hst} + ${order_summary_pst/qst}
    RETURN  ${order_summary_salesTax}

Return sales tax - US
    ${order_summary_salesTax}   Get Text    xpath:(//span[contains(@class,'tax-total')])[4]
    ${order_summary_salesTax}   Remove currency and comma from price    ${order_summary_salesTax}
    RETURN  ${order_summary_salesTax}


Verify delivery details in checkout page for mixed cart bopis and delivery
     [Arguments]   ${size}  ${size2}
     sleep  3s
     Center Element on Screen    //h2[contains(@class,'delivery-icon')]
     Wait Until Element Is Visible    xpath://h2[contains(@class,'delivery-icon')]
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'delivery-icon')]     Delivery
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'delivery-icon')]/span    (1 Items)
     Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[contains(@class,'in-store-icon')]    Pick Up In Store
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'in-store-icon')]/span    (1 Items)
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[contains(@class,'store-name-accordion')]   ${bopis_storeName}
     Center Element on Screen    //span[contains(@class,'store-name-accordion')]
     Set Focus To Element    //span[contains(@class,'store-name-accordion')]
     Click By JS   xpath://span[contains(@class,'store-name-accordion')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address    ${bopis_storeDetails}
     Center Element on Screen    //span[contains(@class,'store-name-accordion')]
     Set Focus To Element    //span[contains(@class,'store-name-accordion')]
     Click By JS   xpath://span[contains(@class,'store-name-accordion')]
     Element Should Not Be Visible    xpath://span[contains(@class,'store-name-accordion')]//parent::p//following-sibling::div/address
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'alternative-pickup-title')]    ${FIRST_NAME}${LAST_NAME} will be required to present a valid government-issued ID to pick up this order.
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath://input[contains(@class,'store-pickup-alternate-checkbox')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://label[contains(@for,'storePickupAlternativePerson')]    Change pickup person
##First product details
     Wait Until Page Contains Element    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     Scroll Element Into View    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${checkout_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${checkout_product_price}    Remove currency and comma from price    ${checkout_product_price}
     Should Be Equal    ${checkout_product_price}    ${PDP_product_1_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-product-name'])[1]
     ${checkout_product_primary_name}    Get Text    xpath:(//div[@class='line-product-name'])[1]
     Should Contain   ${checkout_product_primary_name}   ${PDP_product_1_primary_name}
     Wait Until Element Is Visible    xpath:(//span[@class='line-product-description'])[1]
     ${checkout_product_secondary_name}    Get Text    xpath:(//span[@class='line-product-description'])[1]
     Run Keyword And Warn On Failure  Should Be Equal    ${checkout_product_secondary_name}    ${PDP_product_1_secondary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]    Size ${size2}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-pricing-info')])[1]   Qty 1
##second product details
     Wait Until Page Contains Element    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${checkout_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${checkout_product_price}    Remove currency and comma from price    ${checkout_product_price}
     Should Be Equal    ${checkout_product_price}    ${PDP_product_2_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-product-name'])[2]
     ${checkout_product_primary_name}    Get Text    xpath:(//div[@class='line-product-name'])[2]
     Should Contain   ${checkout_product_primary_name}   ${PDP_product_2_primary_name}
     Wait Until Element Is Visible    xpath:(//span[@class='line-product-description'])[2]
     ${checkout_product_secondary_name}    Get Text    xpath:(//span[@class='line-product-description'])[2]
     Run Keyword And Warn On Failure  Should Contain    ${checkout_product_secondary_name}    ${PDP_product_2_secondary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[2]    Size ${size}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-pricing-info')])[1]   Qty 1

Verify order summary in checkout page for mixed cart bopis and delivery
    [Arguments]  ${size}  ${size2}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'summary-header-title')]    Order Summary
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[@class='mb-0 line-item-store-info line-item-store-pickup'])[0]    Pick Up (${bopis_storeName})
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[@class='mb-0 mt-2 line-item-store-info line-item-store-delivery'])[3]    Delivery
##First Product details
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[3]
    Run Keyword And Warn On Failure   Element Should Contain     xpath:(//div[@class='line-product-name-wrapper'])[3]    ${PDP_product_2_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[3]/span    ${PDP_product_2_secondary_name}
    ${checkout_product_1_price}   Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[5]
    ${checkout_product_1_price}   Remove currency and comma from price    ${checkout_product_1_price}
    Run Keyword And Warn On Failure   Should Be Equal As Strings    ${checkout_product_1_price}    ${PDP_product_2_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[7]    Size ${size2}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[3]   Qty 1
###Second Product details
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[4]
    Run Keyword And Warn On Failure   Element Should Contain     xpath:(//div[@class='line-product-name-wrapper'])[4]   ${PDP_product_1_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[4]/span    ${PDP_product_1_secondary_name}
    ${checkout_product_2_price}   Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[6]
    ${checkout_product_2_price}   Remove currency and comma from price    ${checkout_product_2_price}
    Run Keyword And Warn On Failure   Should Be Equal As Strings   ${checkout_product_2_price}  ${PDP_product_1_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[10]    Size ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[4]   Qty 1
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@aria-controls='promoCodeBlockInner'])[2]    Add Promo Code
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]    Subtotal
    ${subTotal}   Evaluate    ${PDP_product_2_price} + ${PDP_product_1_price}
    ${order_subTotal}   Get Text   xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]//parent::div//following-sibling::div//span
    ${order_subTotal}   Remove currency and comma from price    ${order_subTotal}
    Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_subTotal}    ${subTotal}

Check whether added address is shown in checkout page
   Run Keyword And Warn On Failure   Element Should Contain    xpath://div[@class='selected-address-block']/div[@class='customer-name']       ${FIRST_NAME}
   Run Keyword And Warn On Failure   Element Should Contain    xpath://div[@class='selected-address-block']/div[@class='customer-address']    ${NewUser_StreetAddress}

