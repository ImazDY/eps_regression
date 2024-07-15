*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Resources/Errors.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/DataReader.robot
Resource          ../Keywords/PDP.robot
Resource    Login.robot


*** Keywords ***
Order Confirmation page is displayed
    Wait Until Page Contains Element    ${OrderConfirmation_Page}    50s    User is not redirected on Confirmation page after validated Checkout
    #Order Number
    Wait Until Page Contains Element    ${confirm_order_number}    10s    Order Number seems not displayed in OrderConfirmation page
    Scroll To Element    ${confirm_order_number}
    ${order}=    Check and Get text    ${confirm_order_number}
    Set Test Variable    ${order}   ${order}
    Set Test Message    || Order number: ${order}||    append=yes


Order Confirmation page is displayed for registered user
    ${order}=    Check and Get text    ${confirm_order_number}
    Set Test Variable    ${order}   ${order}
    Set Test Message    || Order number: ${order}||    append=yes
    Run Keyword And Warn On Failure   Run Keyword And Warn On Failure    Element Text Should Be    xpath://h1[contains(@class,'confirmation-title-register')]    Thank you for your order, ${FIRST_NAME}.
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'confirmation-section')])[2]    Order Confirmation
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[contains(@class,'order-confirmation-text')])[5]   Order Number:
    Element Text Should Not Be    xpath:(//span[contains(@class,'order-confirmation-text')])[6]   ${EMPTY}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[contains(@class,'order-confirmation-text')])[7]    Order Date:
    ${current_date}=    Get Current Date    result_format=%m/%d/%y
    Run Keyword And Warn On Failure   Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[contains(@class,'order-confirmation-text')])[8]    ${current_date}
    Run Keyword And Warn On Failure   Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-confirmation-text')])[2]    An order confirmation email has been sent to you at ${guest_valid}


Verify shipping address in order confirmation page
    [Arguments]  ${firstName}  ${lastName}  ${streetAddress}  ${flat}  ${city}  ${state}  ${zipcode}  ${phone}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Shipping Address
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[1]/p/span[1]    ${firstName}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[1]/p/span[2]    ${lastName}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[1]/p[contains(@class,'address1')]    ${streetAddress}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[1]/p[contains(@class,'address2')]    ${flat}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[1]//p[4]/span[1]    ${city},
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[1]//p[4]/span[2]    ${state}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[1]//p[4]/span[3]    ${zipcode}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[1]//p[4]/span[@class='countryCode']    ${Country}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'shipping-phone')])[1]    ${phone}

Verify billing address in order confirmation page
    [Arguments]  ${firstName}  ${lastName}  ${streetAddress}  ${flat}  ${city}  ${state}  ${zipcode}  ${phone}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'billing-addr-label')]   Billing Address
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]/p/span[1]    ${firstName}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]/p/span[2]    ${lastName}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]/p[contains(@class,'address1')]    ${streetAddress}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]/p[contains(@class,'address2')]    ${flat}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]//p[4]/span[1]    ${city},
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]//p[4]/span[2]    ${state}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]//p[4]/span[3]    ${zipcode}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]//p[4]/span[@class='countryCode']    ${Country}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'order-summary-phone')]    ${phone}

Verify billing address in order confirmation page for paypal
    [Arguments]  ${firstName}  ${lastName}  ${streetAddress}  ${flat}  ${city}  ${state}  ${zipcode}   ${country}   ${phone}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'billing-addr-label')]   Billing Address
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]/p/span[1]    ${firstName}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]/p/span[2]    ${lastName}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]/p[contains(@class,'address1')]    ${streetAddress}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]/p[contains(@class,'address2')]    ${flat}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]//p[4]/span[1]    ${city},
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]//p[4]/span[2]    ${state}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]//p[4]/span[3]    ${zipcode}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'address-summary')])[2]//p[4]/span[@class='countryCode']    ${country}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'order-summary-phone')]    ${phone}


Verify payment method CC in order confirmation page
    [Arguments]  ${customerName}  ${customerCardType}  ${customerCardNumber}  ${customerCardExpYear}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'payment-info-label')]                 Payment Method
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'credit-card-owner')]                  ${customerName}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'credit-card-number')]/span            ${customerCardType}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'credit-card-number')]                 ${customerCardNumber}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'credit-card-expiration-date')]/span   Ending ${customerCardExpYear}

Verify payment method paypal in order confirmation page
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'payment-info-label')]                 Payment Method
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='shipping-info-text']//span                   PayPal


Verify order details section in confirmation page
    [Arguments]   ${shippingType}  ${size}
    Page Should Contain Element    xpath://div[@class='item-image']
    Scroll Element Into View    xpath://div[@class='line-product-name-wrapper']
    ${product_name1}  Get Text    xpath://div[@class='line-product-name-wrapper']
    Should Contain    ${product_name1}    ${PDP_product_1_primary_name}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[@class='line-product-description']    ${PDP_product_1_secondary_name}
    ${product_price1}  Get Text  xpath://div[contains(@class,'line-item-total-price-amount')]
    ${product_price1}  Remove currency and comma from price    ${product_price1}
    Should Contain    ${product_price1}    ${PDP_product_1_price}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]    Size ${size}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-pricing-info')])[1]    Qty 1
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[1]    Subtotal
    ${price}   Get Text   xpath:(//p[contains(@class,'order-receipt-label')])[1]//parent::div//following-sibling::div//span
    ${price}   Remove currency and comma from price    ${price}
    Run Keyword And Warn On Failure    Should Be Equal As Strings  ${price}    ${PDP_product_1_price}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[2]    Shipping
   IF  '${shippingType}' in ['2-day', 'pick up', 'standard']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[2]//parent::div//following-sibling::div//span    Complimentary
   ELSE IF  '${shippingType}' in ['Overnight']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[2]//parent::div//following-sibling::div//span    $17
   END
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[3]    Sales Tax
    Run Keyword And Warn On Failure    Element Text Should Not Be    xpath:(//p[contains(@class,'order-receipt-label')])[3]//parent::div//following-sibling::div//span    ${EMPTY}
    Check total in order confirmation  ${shippingType}

Check total in order confirmation
   [Arguments]  ${shippingType}
   ${confirmation_order_summary_total}  Get Text    xpath://span[@class='grand-total-sum']
   ${confirmation_order_summary_total}  Remove currency and comma from price    ${confirmation_order_summary_total}
  IF  '${shopLocale}' in ['US','UK','IT','GR','FR']
    ${sales_tax}  Return sales tax from Order Conf Page - US
  ELSE
    ${sales_tax}  Return sales tax from Order Conf Page - CN
  END
  IF  '${shippingType}' in ['3 to 5 days', '2-day','standard', 'pick up']
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${sales_tax}
  ELSE
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${sales_tax} + 17
  END
   ${total_sum}  Convert To String    ${total_sum}
   Run Keyword And Warn On Failure    Should Be Equal As Strings    ${confirmation_order_summary_total}    ${total_sum}

Check total in order confirmation for 2 products
   [Arguments]  ${shippingType}
   ${confirmation_order_summary_total}  Get Text    xpath://span[@class='grand-total-sum']
   ${confirmation_order_summary_total}  Remove currency and comma from price    ${confirmation_order_summary_total}

  IF  '${shoplocale}' in ['US','UK','IT','FR','GR']
    ${sales_tax}  Return sales tax from Order Conf page - US
  ELSE IF  '${shoplocale}' in ['CN']
    ${sales_tax}  Return sales tax from Order Conf page - CN
  END

  IF  '${shippingType}' in ['3 to 5 days', '2-day', 'pick up']
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price} + ${sales_tax}
  ELSE
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price} + ${sales_tax} + 17
  END
   ${total_sum}   Evaluate    round(${total_sum}, 2)
   ${total_sum}  Convert To String    ${total_sum}
   Run Keyword And Warn On Failure    Should Be Equal As Strings    ${confirmation_order_summary_total}    ${total_sum}

Return sales tax from Order Conf Page - CN
    ${order_summary_gst/hst}  Get Text   //span[contains(@class,'gst-tax-total')]
    ${order_summary_gst/hst}  Remove currency and comma from price  ${order_summary_gst/hst}

    ${order_summary_pst/qst}  Get Text  //span[contains(@class,'pst-tax-total')]
    ${order_summary_pst/qst}  Remove currency and comma from price  ${order_summary_pst/qst}

    ${order_summary_salesTax}  Evaluate  ${order_summary_gst/hst} + ${order_summary_pst/qst}
    RETURN  ${order_summary_salesTax}

Return sales tax from Order Conf Page - US
    ${order_summary_salesTax}   Get Text    //span[contains(@class,'total tax-total')]
    ${order_summary_salesTax}   Remove currency and comma from price    ${order_summary_salesTax}
    RETURN  ${order_summary_salesTax}

Verify that Create an Account section is displayed for Guest Order Confirmation page
    Run Keyword And Continue On Failure    Element Should Be Visible    ${oc_create_acc_title_l}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${oc_create_acc_pwd_l}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${oc_create_acc_submit_l}

Verify that Create an Account section is NOT displayed for Registered Order Confirmation page
    Run Keyword And Continue On Failure    Element Should Not Be Visible    ${oc_create_acc_title_l}
    Run Keyword And Continue On Failure    Element Should Not Be Visible  Visible    ${oc_create_acc_pwd_l}
    Run Keyword And Continue On Failure    Element Should Not Be Visible    ${oc_create_acc_submit_l}

Check the empty validation messages for Create Account form within Order Confirmation page
    Click Create Account button from Order Confirmation page
    ${create_acc_err}    Check and Get text    ${create_acc_err_l}
    Run Keyword And Continue On Failure    Run Keyword And Warn On Failure    Element Text Should Be    ${create_acc_err_l}    ${oc_create_acc_expected_err}

Click on Password field and check that password validation messages are in place
    Click Element    ${oc_create_acc_pwd_l}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_six_chars_l}    ${oc_six_char_err}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_capital_lowercase_l}    ${oc_capital_lowercase_err}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_one_number_l}    ${oc_capital_one_number_err}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_no_space_l}    ${oc_capital_no_spaces_err}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_special_char_l}    ${oc_capital_special_char_err}

Click Create Account button from Order Confirmation page
    Scroll Element Into View    ${oc_create_acc_submit_l}
    Click Element    ${oc_create_acc_submit_l}

Check the validation messages for invalid emails on Create an Account form within Order Confirmation step
    [Arguments]    ${expectedErr}    @{lista}
    FOR    ${value}    IN    @{lista}
        Press Keys    ${oc_create_acc_pwd_l}    CONTROL+A DELETE
        CommonWeb.Check and Input text    ${oc_create_acc_pwd_l}    ${value}
        Click Create Account button from Order Confirmation page
        ${err_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${create_acc_err_l}    5s     Create Account Error message is not visible
        IF    ${err_visible}
            ${errorMessage}    CommonWeb.Check and Get text    ${create_acc_err_l}
            Run Keyword And Warn On Failure    Should Be Equal As Strings    ${errorMessage}    ${expectedErr}
        END
    END

Create an account from Order Confirmation page
    Press Keys    ${oc_create_acc_pwd_l}    CONTROL+A DELETE
    CommonWeb.Check and Input text    ${oc_create_acc_pwd_l}    ${valid_password}
    Click Create Account button from Order Confirmation page
    Wait Until Location Contains    /account?registration=submitted    30s

Check that the account was created for correct guest email
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${my_acc_email_lbl_l}    5s     My Account Email label is not visible
    Run Keyword And Warn On Failure    Element Should Contain   ${my_acc_email_elm_l}    ${guest_valid}

Go to Order History from My Account
    Scroll Element Into View    ${my_acc_order_history_l}
    Click Element    ${my_acc_order_history_l}

Check that the last order id is present in Order History
#    ${True}  Run Keyword And Return Status    Wait Until Page Contains Element    css:#orderCard-${order} span:first-child span:first-child  timeout=30s    error=Order not seen
    IF  '${shopLocale}' in ['US','CN']
        Order id validation in Order History
    ELSE

        Order id validation in Order History - EU
    END

Check that the last order id is present in Order History - Affirm Login
    IF  '${shopLocale}' in ['US','CN']
     Monkey look around - Affirm
     Wait Until Element Is Visible    css:#orderCard-${order}  10s
     Scroll Element Into View    css:#orderCard-${order} span:first-child span:first-child
    ELSE
     Monkey look around - Affirm
     Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
     Wait Until Element Is Visible    ${myacc_orderHistory_orderNumColumn}  10s
     Scroll Element Into View    ${myacc_orderHistory_orderNumColumn}
     ${ordernum}    Get Text  ${myacc_orderHistory_orderNumColumn}
     ${ordernum}    Remove String  ${ordernum}  Order number
     ${ordernum}    Remove String  ${ordernum}  ${SPACE}
#    Wait Until Page Contains  ORDER NUMBER ${ordernum}
#    Wait Until Page Contains  ORDER STATUS Waiting Fulfillment
     log to console  ${ordernum}
    END

Navigate to a subcategory
    log to console  Logging out and log back in steps initiated because the order history isn't showing recent order's for automated runs unless some navigation action is done.
    Mouse Over  id=wedding
    sleep  3s
    Mouse Over  id=wedding-gifts-for-her
    Click element  id=wedding-gifts-for-her
    sleep  10s
    Page should not contain null or NA


     
Order id validation in Order History
    Monkey look around
    Wait Until Element Is Visible    css:#orderCard-${order}  10s
    Scroll Element Into View    css:#orderCard-${order} span:first-child span:first-child

Order id validation in Order History - EU
    Monkey look around
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
#    ${True}  Run Keyword And Return Status  Wait Until Element Is Visible    ${myacc_orderHistory_orderNumColumn}  10s
#    IF  ${True}
#     Center Element on Screen    ${myacc_orderHistory_orderNumColumn}
#    ELSE
#     Monkey look around
#    END
    Center Element on Screen    ${myacc_orderHistory_orderNumColumn}
    ${ordernum}    Get Text  ${myacc_orderHistory_orderNumColumn}
    ${ordernum}    Remove String  ${ordernum}  Order number
    ${ordernum}    Remove String  ${ordernum}  ${SPACE}
#    Wait Until Page Contains  ORDER NUMBER ${ordernum}
#    Wait Until Page Contains  ORDER STATUS Waiting Fulfillment
    log to console  ${ordernum}

Monkey look around
    Logout and log back in
    sleep  5s
    Navigate to a subcategory
    Go to Accounts    Orders & Returns
    Logout and log back in
    sleep  5s
    Navigate to a subcategory
    Go to Accounts    Orders & Returns

Monkey look around - Affirm
    Logout and log back in - Affirm
    sleep  5s
    Navigate to a subcategory
    Go to Accounts    Orders & Returns
    Logout and log back in - Affirm
    sleep  5s
    Navigate to a subcategory
    Go to Accounts    Orders & Returns

Order Confirmation Pickup Store page is displayed
    Run Keyword And Warn On Failure     Wait Until Page Contains Element    ${bopis_title}    10s    Missing "Pick Up In Store" title
    Run Keyword And Warn On Failure     Scroll To Element    ${bopis_shipping_title}
    
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_email}                   10s     Confirmation order Email is not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${bopis_store_name}                    10s     Confirmation order BOPIS: Store Name not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${bopis_store_address1}                10s     Confirmation order BOPIS: Store Address not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${bopis_store_phone}                   10s     Confirmation order BOPIS: Store Phone not displayed

Order Confirmation Billing Information page is displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${billing_address_checkout}                    10s     Confirmation order BOPIS: Store Name not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${billing_payment_method_checkout}                10s     Confirmation order BOPIS: Store Address not displayed

Order confirmation page is displayed for EU
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://h2[@id='conf-header']    50s    User is not redirected on Confirmation page after validated Checkout
    Run Keyword And Warn On Failure   Run Keyword And Warn On Failure    Element Text Should Be    xpath://h2[@id='conf-header']    Order Confirmation
    Wait Until Page Contains Element    css:#orderRefNum    10s    Order Number seems not displayed in OrderConfirmation page
    Scroll To Element    css:#orderRefNum
    ${order}=    Check and Get text    css:#orderRefNum
    Set Test Variable    ${order}   ${order}
    Set Test Message    || Order number: ${order}||    append=yes

    Run Keyword And Warn On Failure   Page Should Contain Element    xpath://span[@class='conf-hello-message fs-mask']
    ${hello_message}  Get Text    xpath://span[@class='conf-hello-message fs-mask']
    Run Keyword And Warn On Failure   Should Contain    ${hello_message}    Hello ${FIRST_NAME}
    ${thanks_message}  Get Text    xpath://span[@class='conf-thanks-message']
    Run Keyword And Warn On Failure   Should Contain    ${thanks_message}    Thank you for shopping with us. Your order has been received and you will shortly receive a confirmation email to
    ${email}  Get Text    xpath://span[@class='conf-thanks-message']/span
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${email}  ${guest_valid}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='orderDetailsRow']         ORDER NUMBER: ${order}
    ${current_date}  Get Current Date    result_format=%d/%m/%Y
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='orderDateRow']            ORDER DATE: ${current_date}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='orderDeliveryMethodRow']  DELIVERY METHOD: EXPRESS COURIER (AIR)
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://button[@id='ConfirmationContinueToShopButton']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://button[@id='ConfirmationContinueToShopButton']    CONTINUE SHOPPING
    Unselect Frame


Verify billing address in order confirmation page EU
    [Arguments]  ${FIRST_NAME}   ${LAST_NAME}  ${ADDRESS}  ${ADDRESS2}  ${CITY}  ${ZIP}  ${PHONE}
    IF  '${shopLocale}' in ['UK']
            ${Country}  Set Variable  United Kingdom
        ELSE IF  '${shopLocale}' in ['IT']
            ${Country}  Set Variable  Italy
        ELSE IF  '${shopLocale}' in ['GR']
            ${Country}  Set Variable  Germany
        ELSE
            ${Country}  Set Variable  France
        END
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://div[@class='pi-header' and text()='Billing Address']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='pi-header' and text()='Billing Address']    Billing Address
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'billingContentContainer ')]/div[2]    ${FIRST_NAME} ${LAST_NAME}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'billingContentContainer ')]/div[3]    ${ADDRESS}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'billingContentContainer ')]/div[4]    ${ADDRESS2}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'billingContentContainer ')]/div[5]    ${CITY} ${ZIP}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'billingContentContainer ')]/div[7]    ${Country}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'billingContentContainer ')]/div[8]    Mobile Phone: ${PHONE}
    Unselect Frame

Verify shipping address in order confirmation page EU
    [Arguments]  ${FIRST_NAME}   ${LAST_NAME}  ${ADDRESS}  ${ADDRESS2}  ${CITY}  ${ZIP}  ${PHONE}
    IF  '${shopLocale}' in ['UK']
            ${Country}  Set Variable  United Kingdom
        ELSE IF  '${shopLocale}' in ['IT']
            ${Country}  Set Variable  Italy
        ELSE IF  '${shopLocale}' in ['GR']
            ${Country}  Set Variable  Germany
        ELSE
            ${Country}  Set Variable  France
        END
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://div[@class='pi-header' and text()='Delivery Address']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='pi-header' and text()='Delivery Address']    Delivery Address
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer ')]/div[2]    ${FIRST_NAME} ${LAST_NAME}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer ')]/div[3]    ${ADDRESS}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer ')]/div[4]    ${ADDRESS2}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer ')]/div[5]    ${CITY}  ${ZIP}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer ')]/div[7]    ${COUNTRY}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer ')]/div[8]    Mobile Phone: ${PHONE}
    Unselect Frame

Verify payment details in order confirmation page EU
  [Arguments]  ${payment_method}
   Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath:(//div[@class='col-xs-12 generalhead'])[2]
   Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='col-xs-12 generalhead'])[2]    Payment Method
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'paymentMethodInformationContainer')]/div    ${payment_method}
   Unselect Frame

Verify order summary in order confirmation page EU
   Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath:(//div[@class='col-xs-12 generalhead'])[3]
   Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='col-xs-12 generalhead'])[3]    Billing Summary
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@data-total-row-type='TotalSummary']/div[1]    Items total
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@data-total-row-type='TotalSummary']/div[2]    ${PDP_product_1_price}
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@data-total-row-type='Shipping']/div[1]    Shipping
   ${order_sum_ship_1}   Get Text     xpath://div[@data-total-row-type='Shipping']/div[2]
   ${order_sum_ship_2}   Remove currency and comma from price    ${order_sum_ship_1}
   Run Keyword And Warn On Failure    Should Be Equal As Strings    ${order_sum_ship_2}    0.00
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@data-total-row-type='TotalSummary']/div[1][@id='BillingSummaryTotalPriceLabel']    Total For Your Order
   ${total}  Get Text  xpath://div[@data-total-row-type='TotalSummary']//div[@id='BillingSummaryTotalPrice']
   ${total_1}  Remove currency and comma from price    ${total}
   Run Keyword And Warn On Failure    Should Be Equal As Strings    ${total_1}     ${PDP_product_1_price}
   Unselect Frame

Verify store address in order confirmation page
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Store Address
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://address[contains(@class,'address-summary store')]/p    ${bopis_storeName}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[2]    Pick Up In Store
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[contains(@class,'store-info-text')]      Available in 4-8 hours. We will notify you when your order is ready for pickup.

Verify order details section in confirmation page for 2 products
    [Arguments]   ${shippingType}  ${size}  ${size2}
###First product details
        Page Should Contain Element    xpath:(//div[@class='item-image'])[1]
        Wait Until Page Contains     ${PDP_product_2_primary_name}  5s
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[@class='line-product-description'])[1]    ${PDP_product_2_secondary_name}
        ${price_1}  Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
        ${price_1}  Remove currency and comma from price   ${price_1}
        Run Keyword And Warn On Failure    Should Be Equal As Strings    ${price_1}    ${PDP_product_2_price}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]    Size ${size2}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-pricing-info')])[1]    Qty 1
##Second product details
        Page Should Contain Element    xpath:(//div[@class='item-image'])[2]
        Wait Until Page Contains     ${PDP_product_1_primary_name}  5s
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[@class='line-product-description']) [2]   ${PDP_product_1_secondary_name}
        ${price_2}  Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
        ${price_2}  Remove currency and comma from price    ${price_2}
        Run Keyword And Warn On Failure    Should Be Equal As Strings    ${price_2}    ${PDP_product_1_price}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]    Size ${size}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-pricing-info')])[1]    Qty 1
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[1]    Subtotal
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[2]    Shipping
   IF  '${shippingType}' in ['2-day', 'pick up']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[2]//parent::div//following-sibling::div//span    Complimentary
   ELSE IF  '${shippingType}' in ['Overnight']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[2]//parent::div//following-sibling::div//span    $17
   END
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[3]    Sales Tax
        Element Text Should Not Be    xpath:(//p[contains(@class,'order-receipt-label')])[3]//parent::div//following-sibling::div//span    ${EMPTY}
        Check total in order confirmation for 2 products  ${shippingType}

Verify order details section in confirmation page for mixed cart bopis and delivery
    [Arguments]   ${size}  ${size2}
###First product details
        Page Should Contain Element    xpath:(//div[@class='item-image'])[1]
#        Should Contain    xpath:(//div[@class='line-product-name-wrapper'])[1]    ${PDP_product_1_primary_name}
#        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[@class='line-product-description'])[1]    ${PDP_product_1_secondary_name}
        @{firstProductDetails}  Create List  ${PDP_product_1_primary_name}
#        ...  ${PDP_product_1_secondary_name}
        Page Should Contain Multiple Texts  @{firstProductDetails}
        ${price_1}  Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
        ${price_1}  Remove currency and comma from price   ${price_1}
        Run Keyword And Warn On Failure    Should Be Equal As Strings    ${price_1}    ${PDP_product_1_price}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]    Size ${size2}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-pricing-info')])[1]    Qty 1
##Second product details
        Page Should Contain Element    xpath:(//div[@class='item-image'])[2]
#        Should Contain    xpath:(//div[@class='line-product-name-wrapper'])[2]    ${PDP_product_2_primary_name}
#        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[@class='line-product-description']) [2]   ${PDP_product_2_secondary_name}
        @{secondProductDetails}  Create List  ${PDP_product_2_primary_name}
#        ...  ${PDP_product_2_secondary_name}
        Page Should Contain Multiple Texts  @{secondProductDetails}
        ${price_2}  Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
        ${price_2}  Remove currency and comma from price    ${price_2}
        Run Keyword And Warn On Failure    Should Be Equal As Strings    ${price_2}    ${PDP_product_2_price}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]    Size ${size}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-pricing-info')])[1]    Qty 1
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[1]    Subtotal
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[2]    Shipping


Order Confirmation page is displayed for registered user in EU
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://h2[@id='conf-header']    50s    User is not redirected on Confirmation page after validated Checkout
    Run Keyword And Warn On Failure   Run Keyword And Warn On Failure    Element Text Should Be    xpath://h2[@id='conf-header']    Order Confirmation
    Wait Until Page Contains Element    css:#orderRefNum    10s    Order Number seems not displayed in OrderConfirmation page
    Scroll To Element    css:#orderRefNum
    ${order}=    Check and Get text    css:#orderRefNum
    Set Test Variable    ${order}   ${order}
    Set Test Message    || Order number: ${order}||    append=yes

    Run Keyword And Warn On Failure   Page Should Contain Element    xpath://span[@class='conf-hello-message fs-mask']
    ${hello_message}  Get Text    xpath://span[@class='conf-hello-message fs-mask']
    Run Keyword And Warn On Failure   Should Contain    ${hello_message}    Hello ${FIRST_NAME}
    ${thanks_message}  Get Text    xpath://span[@class='conf-thanks-message']
    Run Keyword And Warn On Failure   Should Contain    ${thanks_message}    Thank you for shopping with us. Your order has been received and you will shortly receive a confirmation email to
    ${email}  Get Text    xpath://span[@class='conf-thanks-message']/span
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${email}  ${guest_valid}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='orderDetailsRow']         ORDER NUMBER: ${order}
    ${current_date}  Get Current Date    result_format=%d/%m/%Y
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='orderDateRow']            ORDER DATE: ${current_date}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='orderDeliveryMethodRow']  DELIVERY METHOD: EXPRESS COURIER (AIR)
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://button[@id='ConfirmationContinueToShopButton']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://button[@id='ConfirmationContinueToShopButton']    CONTINUE SHOPPING
    Unselect Frame

Verify billing address in order confirmation page for EU
    [Arguments]  ${name}  ${streetAddress}  ${flat}  ${city}  ${zipcode}  ${phone}
      IF  '${shopLocale}' in ['UK']
            ${Country}  Set Variable  United Kingdom
        ELSE IF  '${shopLocale}' in ['IT']
            ${Country}  Set Variable  Italy
        ELSE IF  '${shopLocale}' in ['GR']
            ${Country}  Set Variable  Germany
        ELSE
            ${Country}  Set Variable  France
        END
       Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
       Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'billingContentContainer')]/div[@class='pi-header']    Billing Address
       Run Keyword And Warn On Failure    Element Should Contain    xpath://div[contains(@class,'billingContentContainer')]/div[2]    ${name}
       Run Keyword And Warn On Failure    Element Should Contain    xpath://div[contains(@class,'billingContentContainer')]/div[3]    ${streetAddress}
       Run Keyword And Warn On Failure    Element Should Contain    xpath://div[contains(@class,'billingContentContainer')]/div[4]    ${flat}
       Run Keyword And Warn On Failure    Element Should Contain    xpath://div[contains(@class,'billingContentContainer')]/div[5]    ${city} ${zipcode}
       Run Keyword And Warn On Failure    Element Should Contain    xpath://div[contains(@class,'billingContentContainer')]/div[6]/following-sibling::div    Mobile Phone: ${phone}
       Run Keyword And Warn On Failure    Element Should Contain    xpath://div[contains(@class,'billingContentContainer')]/div[7]    ${Country}
       Unselect Frame

Verify shipping address in order confirmation page for EU
    [Arguments]  ${name}  ${streetAddress}  ${flat}  ${city}  ${zipcode}  ${phone}
        IF  '${shopLocale}' in ['UK']
            ${Country}  Set Variable  United Kingdom
        ELSE IF  '${shopLocale}' in ['IT']
            ${Country}  Set Variable  Italy
        ELSE IF  '${shopLocale}' in ['GR']
            ${Country}  Set Variable  Germany
        ELSE
            ${Country}  Set Variable  France
        END
        Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
        Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer')]/div[@class='pi-header']    Delivery Address
        Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer')]/div[2]    ${name}
        Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer')]/div[3]    ${streetAddress}
        Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer')]/div[4]    ${flat}
        Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer')]/div[5]    ${city} ${zipcode}
        Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer')]/div[6]/following-sibling::div    Mobile Phone: ${phone}
        Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'deliveryContentContainer')]/div[7]    ${Country}
        Unselect Frame

Verify payment method in order confirmation page for EU
    [Arguments]  ${type}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='paymentMethodInformationHeader']/div                    Payment Method
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'paymentMethodInformationContainer')]/div    ${type}
    Unselect Frame

Verify billing summary in order confirmation page for EU
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='billingSummaryHeader']/div                   Billing Summary
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@data-total-row-type='TotalSummary']/div[1])[1]       Items total
    ${item_total}   Get Text    xpath:(//div[@data-total-row-type='TotalSummary']/div[2])[1]
    ${item_total}  Remove currency and comma from price    ${item_total}
    ${item_total_int}  Evaluate    int(float("${item_total}"))
    ${pdp_price_int}  Convert To Integer    ${PDP_product_1_price}
    Run Keyword And Warn On Failure    Should Be Equal As Integers    ${item_total_int}    ${pdp_price_int}00
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@data-total-row-type='Shipping']/div[1]    Shipping
    ${shipping_price}  Get Text    xpath://div[@data-total-row-type='Shipping']/div[2]
    ${shipping_price}  Remove currency and comma from price    ${shipping_price}
    ${shipping_price_int}  Evaluate    int(float("${shipping_price}"))
    Run Keyword And Warn On Failure    Should Be Equal As Integers    ${shipping_price_int}    0
    ${total}  Get Text    xpath://div[@id='BillingSummaryTotalPrice']
    ${total}  Remove currency and comma from price    ${total}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${total}    ${item_total}
    Unselect Frame


Verify order summary data in order confirmation page for EU
    [Arguments]  ${size}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='productsHeader']/div[1]    Order Summary
    Page Should Contain Element    xpath://div[@id='productContainer']//img
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='attr-name productName'])[1]    ${PDP_product_1_primary_name} In ${PDP_product_1_secondary_name}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='attr-value'])[1]    ${size}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='quantityHeader']    QUANTITY
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'product-qty')]    1
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='priceHeader']    PRICE
    ${product_price}   Get Text  xpath:(//div[contains(@class,'product-price')])[1]
    ${product_price}   Remove currency and comma from price    ${product_price}
    ${product_price_int}   Evaluate    int(float("${product_price}"))
    ${pdp_price_int}  Convert To Integer    ${PDP_product_1_price}
    IF  '${shoplocale}' in ['FR']
    Should Be Equal As Integers    ${product_price_int}    ${pdp_price_int}00
   ELSE
    Should Be Equal As Integers    ${product_price_int}    ${pdp_price_int}
   END
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='totalHeader']    TOTAL
    ${product_price_total}   Get Text  xpath:(//div[contains(@class,'product-price')])[2]
    ${product_price_total}   Remove currency and comma from price    ${product_price_total}
    ${product_price_total_int}  Evaluate    int(float("${product_price_total}"))
    Run Keyword And Warn On Failure    Should Be Equal As Integers    ${product_price_int}    ${product_price_total_int}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@data-total-row-type='TotalSummary']/div[1]    Items total
    ${item_total}  Get Text  xpath://div[@data-total-row-type='TotalSummary']/div[2]
    ${item_total}  Remove currency and comma from price    ${item_total}
    ${item_total_int}   Evaluate    int(float("${item_total}"))
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${item_total_int}    ${product_price_total_int}
    Unselect Frame

Verify order details section in confirmation page for ring sizer
    Page Should Contain Element    xpath://div[@class='item-image']
    Element Should Contain    xpath://div[@class='line-product-name-wrapper']    ${ringSizer_product_primary_name}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[@class='line-product-description']    ${ringSizer_product_secondary_name}
    ${price1}   Get Text   xpath://div[contains(@class,'line-item-total-price-amount')]
    ${price1}  Remove currency and comma from price   ${price1}
    Run Keyword And Warn On Failure    Should Be Equal As Strings  ${price1}   Complimentary
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'order-receipt-label')])[1]    Subtotal
    ${price}   Get Text   xpath:(//p[contains(@class,'order-receipt-label')])[1]//parent::div//following-sibling::div//span
    ${price}   Remove currency and comma from price    ${price}
    Run Keyword And Warn On Failure    Should Be Equal As Strings  ${price}    0

Verify order summary data in order confirmation page for EU for 2 products
    [Arguments]  ${size}  ${size2}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='productsHeader']/div[1]    Order Summary
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='quantityHeader']    QUANTITY
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='priceHeader']    PRICE
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='totalHeader']    TOTAL
##First product
    Page Should Contain Element    xpath:(//div[@id='productContainer']//img)[1]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='attr-name productName'])[1]    ${PDP_product_1_primary_name} In ${PDP_product_1_secondary_name}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='attr-value'])[1]    ${size}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'product-qty')])[1]    1
    ${product_price}   Get Text  xpath:(//div[contains(@class,'product-price')])[1]
    ${product_price}   Remove currency and comma from price    ${product_price}
    ${product_price}   Evaluate    int(float("${product_price}"))
    ${pdp_price_int}   Convert To Integer    ${PDP_product_1_price}
    Run Keyword And Warn On Failure    Should Be Equal As Integers    ${product_price}    ${pdp_price_int}00
    ${product_price_total}   Get Text  xpath:(//div[contains(@class,'product-price')])[2]
    ${product_price_total}   Remove currency and comma from price    ${product_price_total}
    ${product_price_total_int}=    Evaluate    int(float("${product_price_total}"))
    ${product_price_int}  Convert To Integer    ${product_price}
    Run Keyword And Warn On Failure    Should Be Equal As Integers    ${product_price_int}    ${product_price_total_int}
##Second product
    Page Should Contain Element    xpath:(//div[@id='productContainer']//img)[2]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='attr-name productName'])[3]    ${PDP_product_2_primary_name} In ${PDP_product_2_secondary_name}
    Run Keyword And Warn On Failure    Element Text Should Be    (//div[@class='attr-value'])[6]    ${size2}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'product-qty')])[2]    1
    ${product_price}   Get Text  xpath:(//div[contains(@class,'product-price')])[3]
    ${product_price}   Remove currency and comma from price    ${product_price}
    ${product_price}   Evaluate    int(float("${product_price}"))
    ${pdp_price_int}   Convert To Integer    ${PDP_product_2_price}
    Run Keyword And Warn On Failure    Should Be Equal As Integers    ${product_price}    ${pdp_price_int}00
    ${product_price_total}   Get Text  xpath:(//div[contains(@class,'product-price')])[4]
    ${product_price_total}   Remove currency and comma from price    ${product_price_total}
    ${product_price_total_int}=    Evaluate    int(float("${product_price_total}"))
    ${product_price_int}  Convert To Integer    ${product_price}
    Run Keyword And Warn On Failure    Should Be Equal As Integers    ${product_price_int}    ${product_price_total_int}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@id='itemsTotal']/div[2]    ITEMS TOTAL
    ${item_total}  Get Text  (//div[contains(@class,'conf-total-value')])[1]
    ${item_total}  Remove currency and comma from price    ${item_total}
    ${total_pdp}   Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${item_total}    ${total_pdp}
    Unselect Frame

Verify order summary is correct in order confirmation page for VGC
     ${product_price_checkout}             Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${product_price_checkout}             Remove currency and comma from price   ${product_price_checkout}
     ${checkout_order_summary_shipping}    Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[1]
     ${checkout_order_summary_salesTax}    Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[2]
     Run Keyword And Warn On Failure   Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_price_checkout}    100
     Run Keyword And Warn On Failure   Run Keyword And Warn On Failure    Should Be Equal As Strings    ${checkout_order_summary_shipping}    Complimentary
     Run Keyword And Warn On Failure   Run Keyword And Warn On Failure    Should Be Equal As Strings    ${checkout_order_summary_salesTax}    Calculated at checkout

Check virtual gift card details in confirmation page
     IF  '${shopLocale}' in ['US']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-product-name-wrapper')])    US Virtual Gift Card
     ELSE IF  '${shopLocale}' in ['CN']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-product-name-wrapper')])]    CA Virtual Gift Card
     END
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[1]    Recipient
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    ${GiftCard_Recipient_FirstName} (${GiftCard_Recipient_Email})
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[3]    Sender
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[4]    ${GiftCard_Sender_Name}


Verify order summary is correct in confirmation page for VGC
     ${order_summary_subtotal}   Get Text    xpath://span[contains(@class,'sub-total')]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal}
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[@class='order-receipt-label']/span)[1]    Shipping
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[@class='order-receipt-label']/span)[2]    Sales Tax
     ${order_summary_shipping}   Get Text    xpath://span[contains(@class,'shipping-total')]
#     ${order_summary_salesTax}   Get Text    //span[contains(@class,'total tax-total')]
#     ${order_summary_salesTax}   Remove currency and comma from price    ${order_summary_salesTax}
   IF  '${shopLocale}' in ['US','UK','IT','GR','FR']
    ${sales_tax}  Return sales tax from Order Conf Page - US
   ELSE
    ${sales_tax}  Return sales tax from Order Conf Page - CN
   END
     Run Keyword And Warn On Failure    Should Be Equal As Strings    ${order_summary_subtotal}    100
     Run Keyword And Warn On Failure    Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
     Run Keyword And Warn On Failure    Should Be Equal As Strings    ${sales_tax}    0

Check gift card details in confirmation page
     IF  '${shopLocale}' in ['US']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-product-name-wrapper')])    $2000 Gift Card
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[2]    Country US
     ELSE IF  '${shopLocale}' in ['CN']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-product-name-wrapper')])   C$2000 Gift Card
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[2]    Country CA
     END
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[contains(@class,'line-item-attributes')])[1]      Gift Card Type Physical

Verify order summary is correct in confirmation page for GC
     ${order_summary_subtotal}   Get Text    xpath://span[contains(@class,'sub-total')]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal}
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[@class='order-receipt-label']/span)[1]    Shipping
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//p[@class='order-receipt-label']/span)[2]    Sales Tax
     ${order_summary_shipping}   Get Text    xpath://span[contains(@class,'shipping-total')]
     ${order_summary_salesTax}   Get Text    //span[contains(@class,'total tax-total')]
     ${order_summary_salesTax}   Remove currency and comma from price    ${order_summary_salesTax}
     Run Keyword And Warn On Failure    Should Be Equal As Strings    ${order_summary_subtotal}    2000
     Run Keyword And Warn On Failure    Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
     Run Keyword And Warn On Failure    Should Be Equal As Strings    ${order_summary_salesTax}    0

