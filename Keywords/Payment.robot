*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Library           Collections
Library           OperatingSystem
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/PDP.robot
Resource          ../Keywords/DataReader.robot

*** Keywords ***
Enter payment details
    [Arguments]    @{varargs}
    Wait Until Page Contains Element    ${payment_section_l}    20s    Payment method are not displayed
    ${expandedcc}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${card_number}    timeout=3s
    IF    '${expandedcc}' == 'True'
        Scroll Element Into View    ${card_number}
        Input text    ${card_number}    ${varargs}[0]
        Scroll Element Into View    ${name_field}
        Input text    ${name_field}    ${varargs}[3]
        Scroll Element Into View    ${expiration_month_label}
        Click Element    ${expiration_month_label}
        Wait Until Element Is Visible    ${expiration_month}    10s
        Click Element    ${expiration_month}
        Scroll Element Into View    ${expiration_year_label}
        Click Element    ${expiration_year_label}
        Scroll Element Into View    ${expiration_year}
        Click Element    ${expiration_year}
        Scroll Element Into View    ${security_code}
        CommonWeb.Check and Input text    ${security_code}    ${varargs}[2]
    END

Click on Place Order CTA for payment
    [Arguments]    ${po_type}
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    IF    "${po_type}" == "paypal"
        ${paypal_po_available}=    Run Keyword And Return Status    Wait Until Page Contains Element      ${payment_submit_paypal_l}    20s
        Run Keyword If    ${paypal_po_available}     Scroll And Click by JS    ${payment_submit_paypal_l}
    ELSE IF    "${po_type}" == "zero_order"
        Run Keyword And Warn On Failure    Wait Until Page Contains Element      ${payment_submit_zero_order_l}    20s    Submit Payment button is not fully loaded
        Scroll Element Into View    ${payment_submit_zero_order_l}
        Sleep  3s
        Click by JS     ${payment_submit_zero_order_l}
    ELSE
        Run Keyword And Warn On Failure    Wait Until Page Contains Element      ${payment_submit_cc_l}    20s    Submit Payment button is not fully loaded
        Scroll Element Into View    ${payment_submit_cc_l}
        CommonWeb.Click by JS    ${payment_submit_cc_l}
    END
    Wait Until Location Contains    /Order-Confirm    120s    Order Confirmation page is not fully loaded

Click on Place Order CTA
    CommonWeb.Scroll And Click by JS    ${payment_submit_cc_l}

Select the PayPal payment method
    CommonWeb.Check and Click    ${paypal_link_l}
    Wait Until Page Contains Element    ${paypal_option_l}    10s     Paypal option is not visible
    Click Element    ${paypal_content_l}
    Sleep    10s    #to be improved

Select credit card payment
    CommonWeb.Check and Click    xpath://label[@for='paymentOptionsRadio']

Log into PayPal
    @{winHandles}=    Get Window Handles
    @{winTitles}=    Get Window Titles
    Switch Window    ${winHandles}[1]
    Wait Until Page Contains Element    ${paypal_email_l}     100s    Email field is not loaded
    CommonWeb.Check and Input text     ${paypal_email_l}       ${PAYPAL_user}
    Click Button    ${affirm_next_l}
    CommonWeb.Check and Input text     ${paypal_pwd_l}       ${PAYPAL_pass}
    Click Button    ${affirm_login_l}
#    Wait Until Page Contains Element    ${paypal_consent_l}     100s    Consent text is not loaded
    Set Test Variable    @{winHandles}

Log into paypal - EU
    Wait Until Page Contains Element    ${paypal_email_l}     100s    Email field is not loaded
    CommonWeb.Check and Input text     ${paypal_email_l}       ${PAYPAL_user}
    Click Button    ${affirm_next_l}
    CommonWeb.Check and Input text     ${paypal_pwd_l}       ${PAYPAL_pass}
    Click Button    ${affirm_login_l}

Close paypal modal
    @{winHandles}=    Get Window Handles
    @{winTitles}=    Get Window Titles
    Switch Window    ${winHandles}[1]
    Close Window

On Paypal Account click on Save and Continue
    Click Element    ${paypal_consent_l}
    sleep    10s    #to be improved
    Switch Window    ${winHandles}[0]

Select the Affirm payment method
    Center Element on Screen   ${affirm_radio}
#    Wait Until Page Contains Element  ${affirm_radio}  10s
    Click By JS   ${affirm_radio}
    Wait Until Page Contains Element    ${affirm_options_l}    30s    Affirm options were not loaded in 30s
    Wait Until Element Is Visible    ${affirm_show_submit_l}  10s
    Set Focus To Element    ${affirm_show_submit_l}
    Click by JS    ${affirm_show_submit_l}


Check that the Affirm Checkout modal is displayed
    Wait Until Page Contains Element    ${affirm_frame_one_l}    30s    Affirm frame was not loaded in 30s
    Select Frame    ${affirm_frame_one_l}
    Wait Until Element Is Visible    ${affirm_mobile_l}    30s    Affirm mobile field is not loaded

Enter and submit the phone number on Affirm Checkout modal
    sleep  3s
   IF  '${shoplocale}' in ['US']
    CommonWeb.Check and Input text    ${affirm_mobile_l}    ${affirm_phone_no}
   ELSE
    CommonWeb.Check and Input text    ${affirm_mobile_l}    ${affirm_phone_no}
   END
    Click Element    ${affirm_sign_in_submit_l}
    Wait Until Page Contains Element    ${affirm_phone_pin_l}    30s    Phone Pin is not loaded
    Wait Until Element Is Visible    ${affirm_phone_pin_l}    30s    Phone Pin is not visible

Enter Affirm PIN within the "We just texted you" modal
    CommonWeb.Check and Input text    ${affirm_phone_pin_l}    ${affirm_pin_no}
#    Wait Until Page Contains Element    ${affirm_choose_pay_plan_l}    100s    'Choose a payment plan' is not loaded
#    Wait Until Element Is Visible    ${affirm_choose_pay_plan_l}    100s    'Choose a payment plan' is not visible

Choose and Affirm payment plan for number of months
    [Arguments]    ${nr_months}
    Click Element    xpath://span[contains(.,'for ${nr_months} months')]

Click on Choose This Affirm Plan button
    Click Element    ${affirm_choose_this_plan_l}

Verify identity on Affirm Payment Plan modal
    Wait Until Page Contains Element    ${affirm_last4_ssn_l}    15s    'Last 4 of Social Security Number' was not loaded in 15s
    Wait Until Element Is Visible    ${affirm_last4_ssn_l}        10s     'Last 4 of Social Security Number' was not visivle in 10s
    CommonWeb.Check and Input text    ${affirm_last4_ssn_l}    9511
    Click Element    ${affirm_verify_l}

Add a debit card on Affirm Review And Pay modal
    Click by JS    ${affirm_paymentMethodSelector}
    Click by JS    ${affirm_paymentMethodSelector_addDebitCard}
    Check and Input text   ${affirm_ConfirmationPage_nameField}    ${FIRST_NAME} ${LAST_NAME}
    Check and Input text    ${affirm_confirmationPage_cardNumField}  ${visa_debitCardNum}
    Check and Input text    ${affirm_confirmationPage_cardExpiryField}  12/26
    Check and Input text    ${affirm_confirmationPage_cvcField}  ${visa_debitCard_cvv}
    Check and Input text    ${affirm_confirmationPage_postalCodeField}  ${NewUser_Zipcode}

Add bank account on Affirm Review And Pay modal
    Click by JS    ${affirm_paymentMethodSelector}
#    Click by JS    ${affirm_paymentMethodSelector_addBankDetails}
    Click by JS    ${affirm_paymentSelector_preAddedBankAcc}
#    Check and Input text   ${affirm_ConfirmationPage_nameField}    ${FIRST_NAME} ${LAST_NAME}
#    Check and Input text    ${affirm_confirmationPage_transitNumField}    ${affirm_transitNo_CN}
#    Check and Input text    ${affirm_confirmationPage_bankNumField}    ${affirm_bankNo_CN}
#    Check and Input text    ${affirm_confirmationPage_accountNumField}   ${affirm_bankAcNo_CN}

    

Agree to DY policy on Affirm Review And Pay modal
    Wait Until Page Contains Element    ${affirm_review_pay_l}    30s    'I have reviewed and agree to the' was not loaded in 30s
    Wait Until Element Is Visible    ${affirm_review_pay_l}    10s    'I have reviewed and agree to the' was not loaded in 30s
    CommonWeb.Scroll And Click    ${affirm_review_pay_l}

Agree to PAD agreement on Affir Review And Pay modal
    Wait Until Page Contains Element    ${affirm_review_PADagreementCheck}    30s    'By continuing, you agree to the' was not loaded in 30s
    Wait Until Element Is Visible    ${affirm_review_PADagreementCheck}    10s    'By continuing, you agree to the' was not loaded in 30s
    CommonWeb.Scroll And Click    ${affirm_review_PADagreementCheck}


Confirm the Affirm payment
    Wait Until Page Contains Element    ${affirm_pof_submit_l}    30s    Confirm CTA is not loaded
    Click Element    ${affirm_pof_submit_l}
    Unselect Frame
    Wait Until Location Contains    /Order-Confirm    100s    Order Confirmation page was not fully loaded in 60s

Check that PayPal and affirm payment options are not listed when buying preorder items
    Page Should Not Contain Element    ${payment_hide_paypal_l}
    Page Should Not Contain Element    ${payment_hide_affirm_l}

Check that Credit Card payment option is preselected and expanded
    Page Should Contain Element    ${payment_preselected_cc_l}

Check that Billing Same As Shipping checkbox is selected by default
    Run Keyword And Warn On Failure    Checkbox Should Be Selected    ${billing_same_as_shipping}

Click on Add New Card
    ${addc}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${payment_add_new_card_l}    timeout=3s
    Run Keyword If    ${addc}     Scroll And Click    ${payment_add_new_card_l}

Verify that the shipping information is correct on Payment page
    [Arguments]    ${EMAIL}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Wait Until Element Is Visible    ${payment_ShipInfo_email_l}      10s   error=Shipping contact email not displayed
    Wait Until Element Is Visible    ${payment_ShipInfo_fn_l}          10s   error=Shipping contact first name not displayed
    Wait Until Element Is Visible    ${payment_ShipInfo_ln_l}          10s   error=Shipping contact last name not displayed
    Wait Until Element Is Visible    ${payment_ShipInfo_addr1_l}    10s   error=Shipping contact Address1 not displayed
    Wait Until Element Is Visible    ${payment_ShipInfo_zip_l}        10s   error=Shipping contact Postal Code not displayed
    Wait Until Element Is Visible    ${payment_ShipInfo_phone_l}      10s   error=Shipping contact Phone Number not displayed

    Element Should Contain    ${payment_ShipInfo_email_l}       ${EMAIL}
    Element Should Contain    ${payment_ShipInfo_fn_l}          ${FIRST_NAME}
    Element Should Contain    ${payment_ShipInfo_ln_l}          ${LAST_NAME}
    Element Should Contain    ${payment_ShipInfo_addr1_l}       ${ADDRESS}
    Element Should Contain    ${payment_ShipInfo_zip_l}         ${ZIP}
    Element Should Contain    ${payment_ShipInfo_phone_l}       ${PHONE}

    ${populatedAddress2}=   Run Keyword And Return Status    Element Should Contain    ${payment_ShipInfo_addr2_l}     ${ADDRESS2}    timeout=3s
    Run Keyword If    ${populatedAddress2}    Element Should Contain    ${payment_ShipInfo_addr2_l}     ${ADDRESS2}

Verify that the shipping method is correct on Payment page
    [Arguments]    ${SHIP_M}
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${payment_ShipInfo_method_l}     10s   error=Shipping contact Method not displayed
    Run Keyword And Warn On Failure    Element Should Contain    ${payment_ShipInfo_method_l}       ${SHIP_M}

Click on Edit Shipping link from Payment step
    Scroll To Top
    Sleep  3s
    Click by JS    ${payment_ShipInfo_edit_l}
    Wait Until Location Contains    /checkout?stage=shipping#shipping

Expand the Redeem Gift Card section
    Scroll Element Into View    ${pay_gift_card_area_l}
    Sleep  3s
    Click by JS    ${pay_gift_card_area_l}
    Wait Until Page Contains Element    ${pay_gift_card_expanded_l}     5s     error=Gift Card Section is not expanded

Expand the Promo Code section
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    CommonWeb.Scroll And Click by JS    ${pay_promo_code_title_l}
    Wait Until Page Contains Element    ${pay_promo_code_input_l}     5s     error=Promo Code Section is not expanded

Click on Add Promo Code button
    CommonWeb.Scroll And Click by JS    ${pay_add_promo_code_l}

Verify the Empty field validation message for Promo Code
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_promo_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${pay_promo_empty_err_l}    ${pay_promo_empty_err}

Click on Apply button
    CommonWeb.Click by JS    ${pay_gift_card_apply_l}

Enter a valid promo code
    [Arguments]    ${promo}
    Input Text    ${pay_promo_code_input_l}    ${promo}
    Set Test Variable    ${promo}

Verify the successful promo code message
#    Wait Until Element Is Visible    ${checkout_coupon_applied_l}     30s     error=Promo Code Success message is not visible
##    ${expected_msg}=    set variable    ${promo} applied
##    Run Keyword And Warn On Failure     Element Should Contain    ${checkout_coupon_applied_l}    ${expected_msg}
#     Element Should Contain  (//*[@id='promoCode']/following-sibling::*[2])[2]    Please enter a valid promo code.
      Wait Until Page Contains    Please enter a valid promo code.  5s

Extract Coupon Amount
    ${success_promo_msg}=    Get Text    ${checkout_coupon_applied_l}
    ${start_index}=    Evaluate    "${success_promo_msg}".find('$')
    ${amount}=    Get Substring    ${success_promo_msg}    ${start_index}
    ${amount_without_currency}=    Set Variable    ${amount.replace('$', '')}
    Set Test Variable    ${amount_without_currency}

Check if Subtotal was updated with promo code discount
    ${subtotal}=    Get Text    ${checkout_summary_subtotal_l}
    ${product_price}=    Get Text    ${checkout_summary_product_p_l}
    ${subtotal_without_currency}=    Set Variable    ${subtotal.replace('$', '')}
    ${product_price_without_currency}=    Set Variable    ${product_price.replace('$', '')}
    ${expected_subtotal}=    Evaluate    ${product_price_without_currency} - ${amount_without_currency}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_subtotal}    ${subtotal_without_currency}
    Set Test Variable    ${subtotal_without_currency}
    Set Test Variable    ${expected_subtotal}

Verify the Empty fields validation messages for Gift Card
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${payment_nr_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${payment_nr_empty_err_l}    ${payment_number_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${payment_pin_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${payment_pin_empty_err_l}    ${payment_pin_empty_err}

Verify the invalid fields validation message for Gift Card
    Fill in the Redeem Gift Card form    ${invalid_gcn}    ${invalid_pin}
    Click on Apply button
    Wait Until Page Contains Element    ${pay_gift_card_err_l}     5s     error=Error message is not visible
    Wait Until Element Is Visible    ${pay_gift_card_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${pay_gift_card_err_l}    ${pay_gift_card_err}

Fill in the Redeem Gift Card form
    [Arguments]    ${gcn}    ${pin}
    ${gcn_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${payment_gcn_l}     5s     error=Gift Card Number is not visible
    Run Keyword If    ${gcn_visible}     Scroll To Element   ${payment_gcn_l}
    Run Keyword If    ${gcn_visible}     CommonWeb.Check and Input text          ${payment_gcn_l}    ${gcn}
    ${pin_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${payment_pin_l}     5s     error=Gift Card Pin is not visible
    Run Keyword If    ${pin_visible}     Scroll To Element   ${payment_pin_l}
    Run Keyword If    ${pin_visible}     CommonWeb.Check and Input text          ${payment_pin_l}    ${pin}

Select/Unselect Billing Same As Shipping checkbox
    Scroll To Element    ${billing_same_as_ship_l}
    Sleep  2s
    Click by JS    ${billing_same_as_ship_l}
    Wait Until Page Contains Element    ${billing_fn_l}     5s     error=First Name field is not loaded

Verify the Empty fields validation messages for Credit Card section
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_nr_empty_err_l}     5s     error=Error message is not visible
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    CommonWeb.Scroll To Element    ${payment_cc_nr_empty_err_l}
    Run Keyword And Warn On Failure   Element Text Should Be    ${payment_cc_nr_empty_err_l}    ${payment_cc_nr_empty_err}
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_owner_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${payment_cc_owner_empty_err_l}    ${payment_cc_name_empty_err}
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_exp_m_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${payment_cc_exp_m_empty_err_l}    ${payment_cc_exp_m_empty_err}
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_exp_y_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${payment_cc_exp_y_empty_err_l}    ${payment_cc_exp_y_empty_err}
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_cvv_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${payment_cc_cvv_empty_err_l}    ${payment_cc_cvv_empty_err}

Verify the Empty fields validation messages for Billing Address section
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_fn_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${pay_bill_fn_empty_err_l}    ${pay_bill_fn_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_ln_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${pay_bill_ln_empty_err_l}    ${pay_bill_ln_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_addr_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${pay_bill_addr_empty_err_l}    ${pay_bill_addr_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_city_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${pay_bill_city_empty_err_l}    ${pay_bill_city_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_state_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${pay_bill_state_empty_err_l}    ${pay_bill_state_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_zip_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${pay_bill_zip_empty_err_l}    ${pay_bill_zip_empty_err}

Verify the invalid fields validation on Billing Address step
    Enter invalid Billing details        ${invalid_city}    ${invalid_zip}
    Click on Place Order CTA
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${bill_city_invalid_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${bill_city_invalid_err_l}    ${bill_city_invalid_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${bill_zip_invalid_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${bill_zip_invalid_err_l}    ${shipping_zip_invalid_err}

Enter invalid Billing details
    [Arguments]    ${invalid_CITY}    ${invalid_ZIP}
    ${billingCityName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_city}     5s     error=Error message is not visible
    Run Keyword If    ${billingCityName}     Scroll To Element   ${billing_city}
    Run Keyword If    ${billingCityName}     CommonWeb.Check and Input text          ${billing_city}    ${invalid_CITY}
    CommonWeb.Scroll To Element    ${shipping_address_one}
    ${billingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_zip}     5s     error=Error message is not visible
    Run Keyword If    ${billingZipCode}     Scroll To Element   ${billing_zip}
    Run Keyword If    ${billingZipCode}     CommonWeb.Check and Input text          ${billing_zip}   ${invalid_ZIP}

Verify the invalid fields validation for Credit Card section
    Enter payment details    ${invalid_number}    ${card_exp}    ${invalid_csv}    ${invalid_card_holder}
    Click on Place Order CTA
    Wait Until Page Contains Element    ${billing_error_message_text}     5s     error=Error message is not loaded
    Wait Until Element Is Visible    ${billing_error_message_text}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure   Element Text Should Be    ${billing_error_message_text}    ${billing_error_message_text_err}

Gift Card ID list
    &{giftCardID}=    Create Dictionary    6003920343559550=7715    6003920344000310=2574
    Set Test Variable    &{giftCardID}    &{giftCardID}

Check the Gift Card Balances
    Gift Card ID list
    FOR    ${key}    IN    @{giftCardID.keys()}
        Fill in the Redeem Gift Card form    ${key}    ${giftCardID["${key}"]}
        Click on Apply button
        ${result}=    Run Keyword And Return Status    Page Should Contain Element    ${pay_gift_card_success_l}     15s
        Exit For Loop If    '${result}' == 'True'
    END

Remove the applied gift card
    ${result}=    Run Keyword And Return Status    Element Should Be Visible    ${pay_gift_card_success_l}     15s
    Run Keyword If    ${result}    CommonWeb.Scroll And Click by JS    ${pay_gift_card_remove_l}
    Wait Until Element Is Not Visible    ${pay_gift_card_success_l}     20s     error=Success message is not visible

Check that the correct tax was applied for state
    [Arguments]    ${STATE}
    ${state_taxes}    Create Dictionary    California=0.08876    Hawaii=0.045    Alaska=0
    Wait Until Element Is Visible    ${checkout_summary_tax_total_l}     15s     error=Order Summary Tax Total is not visible
    ${sales_tax}=    Get Text    ${checkout_summary_tax_total_l}
    ${sales_tax_without_currency}=    Set Variable    ${sales_tax.replace('$', '')}
    ${product_price}=    Get Text    ${checkout_summary_product_p_l}
    ${product_price_without_currency}=    Set Variable    ${product_price.replace('$', '')}
    ${expected_tax}=    Evaluate    ${product_price_without_currency} * ${state_taxes['${STATE}']}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_tax}    ${sales_tax_without_currency}

Verify if Order Summary data is correct
    [Arguments]    ${size}    ${qty}
    ${os_variant}=    Get Text    ${checkout_summary_descript_l}
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${product_name_subtitle}    ${os_variant}
    ${os_size}=    Get Text    ${checkout_summary_size_l}
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_summary_size_l}    Size ${size}
    ${os_qty}=    Get Text    ${checkout_summary_qty_l}
    ${os_qty_just_nr}=    Set Variable    ${os_qty.replace('Qty', '')}
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_summary_qty_l}    Qty ${qty}
    ${subtotal}=    Get Text    ${checkout_summary_subtotal_l}
    ${product_price}=    Get Text    ${checkout_summary_product_p_l}
    ${subtotal_without_currency}=    Remove currency and comma from price    ${subtotal}
    ${product_price_without_currency}=    Remove currency and comma from price    ${product_price}
    ${expected_subtotal}=    Evaluate    ${product_price_without_currency} * ${${os_qty_just_nr}}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_subtotal}    ${subtotal_without_currency}


Enter payment details for EU
    [Arguments]    @{varargs}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Select Frame    xpath://iframe[@id='secureWindow']
    Wait Until Page Contains Element    xpath://input[@id='cardNum']    20s    Payment method are not displayed
    ${expandedcc}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='cardNum']    timeout=3s
    IF    '${expandedcc}' == 'True'
        Scroll Page    0    document.getElementById('cardNum').offsetTop
        CommonWeb.Check and Input text    xpath://input[@id='cardNum']    ${varargs}[0]
        Scroll Page    0    document.getElementById('cardExpiryMonth').offsetTop
        Select From List By Label    xpath://select[@id='cardExpiryMonth']   03
        Scroll Page    0    document.getElementById('cardExpiryYear').offsetTop
        Select From List By Label    xpath://select[@id='cardExpiryYear']   2030
        Scroll Page    0    document.getElementById('cvdNumber').offsetTop
        CommonWeb.Check and Input text    xpath://input[@id='cvdNumber']    ${varargs}[2]
        Unselect Frame
    END

Enter visa payment details for EU
     [Arguments]    @{varargs}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Select Frame    xpath://iframe[@id='secureWindow']
    Wait Until Page Contains Element    xpath://input[@id='cardNum']    20s    Payment method are not displayed
    ${expandedcc}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='cardNum']    timeout=3s
    IF    '${expandedcc}' == 'True'
        Scroll Page    0    document.getElementById('cardNum').offsetTop
        CommonWeb.Check and Input text    xpath://input[@id='cardNum']    ${varargs}[0]
        Scroll Page    0    document.getElementById('cardExpiryMonth').offsetTop
        Select From List By Label    xpath://select[@id='cardExpiryMonth']   03
        Scroll Page    0    document.getElementById('cardExpiryYear').offsetTop
        Select From List By Label    xpath://select[@id='cardExpiryYear']   2030
        Scroll Page    0    document.getElementById('cvdNumber').offsetTop
        CommonWeb.Check and Input text    xpath://input[@id='cvdNumber']    ${varargs}[1]
        Unselect Frame
    END

Verify if order summary data is correct for EU
    [Arguments]    ${size}    ${qty}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    ${os_variant}=    Get Text    xpath:(//div[@class='attr-name productName'])[1]
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${PDP_product_1_primary_name} In ${product_name_subtitle}    ${os_variant}
    ${os_size}=    Get Text    xpath:(//div[@class='attr-value'])[1]
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_summary_size_l}    Size ${size}
    ${os_qty}=    Get Text    (//div[@class='valign-cell product-qty'])[1]
    ${os_qty_just_nr}=    Set Variable    ${os_qty.replace('Qty', '')}
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_summary_qty_l}    Qty ${qty}
    ${subtotal}=    Get Text    (//div[@class='valign-cell product-price'])[2]
    ${product_price}=    Get Text    xpath:(//div[@class='valign-cell product-price'])[1]
    ${subtotal_without_currency}=    Remove currency and comma from price  ${subtotal}
    ${product_price_without_currency}=    Remove currency and comma from price    ${product_price}
    ${expected_subtotal}=    Evaluate    ${product_price_without_currency} * ${${os_qty_just_nr}}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_subtotal}    ${subtotal_without_currency}
    ${items_total_1}  Get Text    xpath:(//div[@class='col-xs-6 col-md-1 minitotals-col-price'])[1]
    ${items_total}  Remove currency and comma from price    ${items_total_1}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_subtotal}    ${items_total}
    Unselect Frame


Verify if Billing Summary data is correct for EU
    ${billing_summary_total_price}  Get Text    xpath://div[@id='BillingSummaryTotalPrice']
    ${billing_summary_total_price}=   Remove currency and comma from price  ${billing_summary_total_price}
    ${billing_summary_total_total}  Get Text    xpath://div[@id='BillingSummaryTotalPrice']
    ${billing_summary_total_price}=   Remove currency and comma from price  ${billing_summary_total_price}


Check that the correct tax was applied for state cn
   [Arguments]    ${STATE}
    ${state_taxes}    Create Dictionary    Ottawa=0.13    Ontario=0.13
    Wait Until Element Is Visible    ${checkout_summary_tax_total_l}     15s     error=Order Summary Tax Total is not visible
    ${sales_tax}=    Get Text    ${checkout_summary_tax_total_l}
    ${sales_tax_currency}   Remove currency and comma from price  ${sales_tax}
    ${sales_tax_without_currency}=    Set Variable    ${sales_tax_currency}
    ${product_price}=    Get Text    ${checkout_summary_product_p_l}
    ${product_price_currency}   Remove currency and comma from price  ${product_price}
    ${product_price_without_currency}=    Set Variable    ${product_price_currency}
    ${expected_tax}=    Evaluate    ${product_price_without_currency} * ${state_taxes['${STATE}']}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_tax}    ${sales_tax_without_currency}

Click on Place Order CTA for payment for EU
    [Arguments]    ${po_type}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    IF    "${po_type}" == "paypal"
        ${paypal_po_available}=    Run Keyword And Return Status    Wait Until Page Contains Element      //*[@id="pmContainer"]/div/span[@title='PayPal']    20s
#        Run Keyword If    ${paypal_po_available}     Scroll Element Into View    xpath://*[@id="pmContainer"]/div[5]/span
        Run Keyword If    ${paypal_po_available}     Scroll To Element    //*[@id="pmContainer"]/div/span[@title='PayPal']
        Set Focus To Element  //*[@id="pmContainer"]/div/span[@title='PayPal']
        sleep  2s
        Click By JS  //*[@id="pmContainer"]/div/span[@title='PayPal']
        sleep  5s
        Set Focus To Element  xpath://button[@id='btnPay']
        sleep  2s
        CommonWeb.Click by JS    xpath://button[@id='btnPay']
    ELSE IF  "${po_type}" == "klarna"
        Pay with klarna
    ELSE
        Run Keyword And Warn On Failure    Wait Until Page Contains Element      xpath://button[@id='btnPay']    20s    Submit Payment button is not fully loaded
        Scroll Page    0    document.getElementById('btnPay').offsetTop
        CommonWeb.Click by JS    xpath://button[@id='btnPay']
    END
    Unselect Frame
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    xpath:(//div[@class='attr-name productName'])[1]    50s   Order confirmation not loaded
    Run Keyword And Warn On Failure    Unselect Frame

On Paypal Account click on complete purchase
    Click Element    xpath://button[@id='payment-submit-btn']
    Sleep    10s
#    Switch Window    ${winHandles}[0]

Verify that the shipping information is correct on Payment page for EU
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure    Element Should Contain    xpath://input[@id='CheckoutData_BillingFirstName']       Ana
    Run Keyword And Warn On Failure    Element Should Contain    xpath://input[@id='CheckoutData_BillingLastName']        Nanu
    Run Keyword And Warn On Failure    Element Should Contain    xpath://input[@id='CheckoutData_Email']                  ${GUEST_email}
    Unselect Frame

Fill remaining shipping details for EU
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    ${shippingAddress1}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_BillingAddress1']    timeout=3s
    Run Keyword If    ${shippingAddress1}   Scroll To Element   xpath://input[@id='CheckoutData_BillingAddress1']
    Run Keyword If    ${shippingAddress1}   CommonWeb.Check and Input text          xpath://input[@id='CheckoutData_BillingAddress1']    ${NewUser_StreetAddress}
    ${shippingAddress2}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_BillingAddress1']    timeout=3s
    Run Keyword If    ${shippingAddress2}   Scroll To Element   xpath://input[@id='CheckoutData_BillingAddress2']
    Run Keyword If    ${shippingAddress2}   CommonWeb.Check and Input text          xpath://input[@id='CheckoutData_BillingAddress2']    ${NewUser_Flat}
    ${shippingCityName}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='BillingCity']    timeout=3s
    Run Keyword If    ${shippingCityName}     Scroll To Element   xpath://input[@id='BillingCity']
    Run Keyword If    ${shippingCityName}     CommonWeb.Check and Input text          xpath://input[@id='BillingCity']    ${NewUser_City}
    ${shippingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='BillingZIP']    timeout=3s
    Run Keyword If    ${shippingZipCode}     Scroll To Element   xpath://input[@id='BillingZIP']
    Sleep    2s
    Run Keyword If    ${shippingZipCode}     CommonWeb.Check and Input text          xpath://input[@id='BillingZIP']   ${NewUser_Zipcode}
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_BillingPhone']    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   xpath://input[@id='CheckoutData_BillingPhone']
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          xpath://input[@id='CheckoutData_BillingPhone']    ${NewUser_Phone}
    Unselect Frame


Verify if Order Summary data is correct in order confirmation page for EU
    [Arguments]    ${size}    ${qty}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    ${os_variant}=    Get Text    xpath:(//div[@class='attr-name productName'])[1]
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${PDP_product_1_primary_name} In ${product_name_subtitle}    ${os_variant}
    ${os_size}=    Get Text    xpath:(//div[@class='attr-value'])[1]
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_summary_size_l}    Size ${size}
    ${os_qty}=    Get Text    (//div[@class='valign-cell product-qty'])[1]
    ${os_qty_just_nr}=    Set Variable    ${os_qty.replace('Qty', '')}
    Run Keyword And Warn On Failure   Element Text Should Be    ${checkout_summary_qty_l}    Qty ${qty}
    ${subtotal}=    Get Text    (//div[@class='valign-cell product-price'])[2]
    ${product_price}=    Get Text    xpath:(//div[@class='valign-cell product-price'])[1]
    ${subtotal_without_currency}=    Remove currency and comma from price  ${subtotal}
    ${product_price_without_currency}=    Remove currency and comma from price    ${product_price}
    ${expected_subtotal}=    Evaluate    ${product_price_without_currency} * ${${os_qty_just_nr}}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_subtotal}    ${subtotal_without_currency}
    Unselect Frame


Verify order summary in payment page
    [Arguments]  ${shippingType}  ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'summary-header-title')]    Order Summary
    Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[2]
    Element Should Contain    xpath:(//div[@class='line-product-name-wrapper'])[2]    ${PDP_product_1_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[2]/span    ${PDP_product_1_secondary_name}
    ${price}  Get Text   xpath:(//div[contains(@class,'line-item-total-price-amount')])[3]
    ${price}  Remove currency and comma from price    ${price}
    Run Keyword And Warn On Failure     Should Be Equal As Strings  ${price}  ${PDP_product_1_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[4]    Size ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[2]    Qty 1
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@aria-controls='promoCodeBlockInner'])[2]    Add Promo Code
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]    Subtotal
    ${product_price}   Get Text   xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]//parent::div//following-sibling::div//span
    ${product_price}   Remove currency and comma from price    ${product_price}
    Run Keyword And Warn On Failure     Should Be Equal As Strings   ${product_price}   ${PDP_product_1_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]    Shipping
   IF  '${shippingType}' in ['2-day', 'pick up', 'standard']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]//parent::div//following-sibling::div//span    Complimentary
   ELSE IF  '${shippingType}' in ['Overnight']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]//parent::div//following-sibling::div//span    $17
   END
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]    Sales Tax
    Element Text Should Not Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]//parent::div//following-sibling::div//span    ${EMPTY}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'grand-total-sum')])[2]    Total
    Check total in payment page order summary   ${shippingType}

Verify payment page shipping information
    [Arguments]   ${shippingType}
    Sleep  5s
    Wait Until Page Contains Element    xpath://h3[contains(@class,'card-header-checkout')]   timeout=30s
    Scroll To Top
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h3[contains(@class,'card-header-checkout')]      Shipping Information
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'summary-text')]      Email
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'summary-email')]     ${guest_valid}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//button[@aria-label='Edit Shipping'])[2]   Edit
   IF  '${shippingType}' in ['delivery']
    Page Should Contain Element   xpath:(//p[contains(@class,'shipping-info-title')])[1]
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[contains(@class,'shipping-info-title')])[1]   Delivery
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title')])[1]/span   (1 Item)
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Shipping Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[1]  ${FIRST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[2]  ${LAST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address1')])[1]   ${Newuser_StreetAddress}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address2')])[1]   ${Newuser_Flat}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[1]   ${Newuser_City},
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[2]   ${Newuser_State}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[3]   ${Newuser_Zipcode}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[4]   ${Country}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'shipping-phone')]     ${Newuser_Phone}
   ELSE IF  '${shippingType}' in ['pick up']
    Page Should Contain Element   xpath:(//p[contains(@class,'shipping-info-title')])[1]
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[contains(@class,'shipping-info-title')])[1]   Pick Up In Store
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title')])[1]/span   (1 Item)
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Store Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='store-info-container']//p  ${bopis_storeName} \n${bopis_storeDetails}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[2]  Pick Up In Store
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'store-info-text')]   Available in 4-8 hours. We will notify you when your order is ready for pickup.
   ELSE IF  '${shippingType}' in ['pre order']
    Page Should Contain Element   xpath:(//p[contains(@class,'shipping-info-title')])[1]
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[contains(@class,'shipping-info-title')])[1]   Pre-Order
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title')])[1]/span   (1 Item)
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Shipping Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[1]  ${FIRST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[2]  ${LAST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address1')])[1]   ${Newuser_StreetAddress}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address2')])[1]   ${Newuser_Flat}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[1]   ${Newuser_City},
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[2]   ${Newuser_State}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[3]   ${Newuser_Zipcode}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[4]   ${Country}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'shipping-phone')]     ${Newuser_Phone}
   END


Verify payment page shipping information for 2 products
    [Arguments]   ${shippingType}
    Sleep  5s
    Wait Until Page Contains Element    xpath://h3[contains(@class,'card-header-checkout')]   timeout=30s
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h3[contains(@class,'card-header-checkout')]      Shipping Information
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'summary-text')]      Email
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'summary-email')]     ${guest_valid}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//button[@aria-label='Edit Shipping'])[2]   Edit
   IF  '${shippingType}' in ['delivery']
    Page Should Contain Element   xpath:(//p[contains(@class,'shipping-info-title')])[1]
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[contains(@class,'shipping-info-title')])[1]   Delivery
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title')])[1]/span   (2 Items)
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Shipping Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[1]  ${FIRST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[2]  ${LAST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address1')])[1]   ${Newuser_StreetAddress}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address2')])[1]   ${Newuser_Flat}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[1]   ${Newuser_City},
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[2]   ${Newuser_State}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[3]   ${Newuser_Zipcode}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[4]   ${Country}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'shipping-phone')]     ${Newuser_Phone}
   ELSE IF  '${shippingType}' in ['pick up']
    Page Should Contain Element   xpath:(//p[contains(@class,'shipping-info-title')])[1]
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[contains(@class,'shipping-info-title')])[1]   Pick Up In Store
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title')])[1]/span   (2 Items)
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Store Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='store-info-container']//p  ${bopis_storeName} \n${bopis_storeDetails}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[2]  Pick Up In Store
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'store-info-text')]   Available in 4-8 hours. We will notify you when your order is ready for pickup.
   ELSE IF  '${shippingType}' in ['pre order']
    Page Should Contain Element   xpath:(//p[contains(@class,'shipping-info-title')])[1]
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[contains(@class,'shipping-info-title')])[1]   Pre-Order
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title')])[1]/span   (2 Items)
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Shipping Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[1]  ${FIRST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[2]  ${LAST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address1')])[1]   ${Newuser_StreetAddress}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address2')])[1]   ${Newuser_Flat}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[1]   ${Newuser_City},
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[2]   ${Newuser_State}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[3]   ${Newuser_Zipcode}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[4]   ${Country}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'shipping-phone')]     ${Newuser_Phone}
   END


Verify payment section for logged in user
    Sleep  2s
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//h2[contains(@class,'card-header-checkout')])[7]   Payment
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://input[@id='paymentOptionsRadio']//parent::div/label/span    Credit Card
    Page Should Contain Element    xpath://input[@id='paymentOptionsRadio']//parent::div/label/span/img
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//fieldset[@class='payment-form-fields']//div[@class='selectric'])[1]    Select a Saved Card \n ▾
    Run Keyword And Warn On Failure   Wait Until Element Is Visible    xpath:(//fieldset[@class='payment-form-fields']//div[@class='selectric'])[1]
    Run Keyword And Warn On Failure  Click Element    xpath:(//fieldset[@class='payment-form-fields']//div[@class='selectric'])[1]
    Run Keyword And Warn On Failure  Element Text Should Be    xpath://p[contains(@class,'ccst-type')]    ${Newuser_CardType}
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//p[contains(@class,'ccst-number')])[1]    ${Newuser_CardNumberMasked}
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//p[contains(@class,'ccst-exp-resource')])[1]    Expiration
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//p[contains(@class,'ccst-exp-date')])[1]    ${Newuser_CardExpYear}
    Run Keyword And Warn On Failure  Click Element    xpath:(//fieldset[@class='payment-form-fields']//div[@class='selectric'])[1]/span
    Run Keyword And Warn On Failure    Element Should Not Be Visible    xpath://p[contains(@class,'ccst-type')]
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//div[contains(@class,'saved-credit-card-type')])[1]   ${Newuser_CardType}
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//div[contains(@class,'saved-credit-card-number')])[1]  ${Newuser_CardNumberMasked}
    Run Keyword And Warn On Failure  Element Text Should Be    xpath://div[contains(@class,'saved-credit-card-expiration-date')]/span    Expiration ${Newuser_CardExp}
    Run Keyword And Warn On Failure  Element Text Should Be    xpath://span[contains(@class,'billing-add-payment')]    Add New Card
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://input[@id='payPalOptionsRadio']
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://input[@id='affirmOptionsRadio']

Verify payment section for logged in user with preorder item
    Sleep  2s
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//h2[contains(@class,'card-header-checkout')])[7]   Payment
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://input[@id='paymentOptionsRadio']//parent::div/label/span    Credit Card
    Page Should Contain Element    xpath://input[@id='paymentOptionsRadio']//parent::div/label/span/img
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//fieldset[@class='payment-form-fields']//div[@class='selectric'])[1]    Select a Saved Card \n ▾
    Click Element    xpath:(//fieldset[@class='payment-form-fields']//div[@class='selectric'])[1]
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'ccst-type')]    ${Newuser_CardType}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'ccst-number')])[1]    ${Newuser_CardNumberMasked}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'ccst-exp-resource')])[1]    Expiration
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'ccst-exp-date')])[1]    ${Newuser_CardExpYear}
    Click Element    xpath:(//fieldset[@class='payment-form-fields']//div[@class='selectric'])[1]
    Element Should Not Be Visible    xpath://p[contains(@class,'ccst-type')]
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'saved-credit-card-type')])[1]   ${Newuser_CardType}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'saved-credit-card-number')])[1]  ${Newuser_CardNumberMasked}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'saved-credit-card-expiration-date')]/span    Expiration ${Newuser_CardExp}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[contains(@class,'billing-add-payment')]    Add New Card
    Run Keyword And Warn On Failure  Page Should Not Contain Element    xpath://input[@id='payPalOptionsRadio']
    Run Keyword And Warn On Failure  Page Should Not Contain Element    xpath://input[@id='affirmOptionsRadio']


Verify whether credit card is preselected
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://input[@id='paymentOptionsRadio' and 'checked'='checked']

Check total in payment page order summary
   [Arguments]  ${shippingType}
   ${checkout_order_summary_total}  Get Text    xpath:(//p[contains(@class,'grand-total-sum')])[2]//parent::div//following-sibling::div//span
   ${checkout_order_summary_total}  Remove currency and comma from price    ${checkout_order_summary_total}
  IF  '${shoplocale}' in ['US','UK','IT','FR','GR']
    ${sales_tax}  Return sales tax - US
  ELSE IF  '${shoplocale}' in ['CN']
    ${sales_tax}  Return sales tax - CN
  END
  IF  '${shippingType}' in ['2-day','3 to 5 days', 'standard','pick up']
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${sales_tax}
  ELSE
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${sales_tax} + 17
  END
   ${total_sum}  Convert To String    ${total_sum}
   Run Keyword And Warn On Failure     Should Be Equal As Strings    ${checkout_order_summary_total}    ${total_sum}

Check total in payment page order summary for 2 products
   [Arguments]  ${shippingType}
   ${checkout_order_summary_total}  Get Text    xpath:(//p[contains(@class,'grand-total-sum')])[2]//parent::div//following-sibling::div//span
   ${checkout_order_summary_total}  Remove currency and comma from price    ${checkout_order_summary_total}
   IF  '${shoplocale}' in ['US','UK','IT','FR','GR']
    ${sales_tax}  Return sales tax - US
   ELSE IF  '${shoplocale}' in ['CN']
    ${sales_tax}  Return sales tax - CN
   END
   IF  '${shippingType}' in ['2-day','3 to 5 days','pick up']
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price} + ${sales_tax}
  ELSE
   ${total_sum} =  Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price} + ${sales_tax} + 17
  END
   ${total_sum}   Evaluate    round(${total_sum}, 2)
   ${total_sum}  Convert To String    ${total_sum}
   Run Keyword And Warn On Failure     Should Be Equal As Strings    ${checkout_order_summary_total}    ${total_sum}



Enter cvv number
    [Arguments]  ${cvv}
    Check and Input text    xpath://input[@id='saved-payment-security-code']    ${cvv}

Verify order summary in payment page for 2 products
    [Arguments]  ${shippingType}   ${size}  ${size2}
    Run Keyword And Warn On Failure  Element Text Should Be    xpath://h2[contains(@class,'summary-header-title')]    Order Summary
##First Product details
    Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[3]
    Wait Until Page Contains     ${PDP_product_2_primary_name}  5s
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[3]/span    ${PDP_product_2_secondary_name}
    ${payment_product_1_price}   Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[5]
    ${payment_product_1_price}   Remove currency and comma from price    ${payment_product_1_price}
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${payment_product_1_price}   ${PDP_product_2_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[7]    Size ${size2}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[3]   Qty 1
###Second Product details
    Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[4]
    Wait Until Page Contains     ${PDP_product_1_primary_name}  5s
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[4]/span    ${PDP_product_1_secondary_name}
    ${checkout_product_2_price}   Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[6]
    ${checkout_product_2_price}   Remove currency and comma from price    ${checkout_product_2_price}
    Run Keyword And Warn On Failure     Should Be Equal As Strings  ${checkout_product_2_price}   ${PDP_product_1_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[10]    Size ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[4]   Qty 1

    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@aria-controls='promoCodeBlockInner'])[2]    Add Promo Code
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]    Subtotal
    ${subTotal}    Evaluate    ${PDP_product_2_price} + ${PDP_product_1_price}
    ${grandTotal}  Get Text    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]//parent::div//following-sibling::div//span
    ${grandTotal}  Remove currency and comma from price    ${grandTotal}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]    Shipping
   IF  '${shippingType}' in ['2-day', 'pick up']
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]//parent::div//following-sibling::div//span    Complimentary
   ELSE IF  '${shippingType}' in ['Overnight']
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]//parent::div//following-sibling::div//span    $17
   END
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]    Sales Tax
    Run Keyword And Warn On Failure    Element Text Should Not Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[6]//parent::div//following-sibling::div//span    ${EMPTY}
    Run Keyword And Warn On Failure  Element Text Should Be    xpath:(//p[contains(@class,'grand-total-sum')])[2]    Total
    Check total in payment page order summary for 2 products  ${shippingType}

Verify billing details in payment page for EU
    [Arguments]   ${customerName}  ${customerStreetAddress}  ${customerFlat}  ${customerCity}  ${customerZipcode}  ${customerPhone}
    IF  '${shopLocale}' in ['UK']
        ${Country}  Set Variable  United Kingdom
    ELSE IF  '${shopLocale}' in ['IT']
        ${Country}  Set Variable  Italy
    ELSE IF  '${shopLocale}' in ['GR']
        ${Country}  Set Variable  Germany
    ELSE
        ${Country}  Set Variable  France
    END
    Wait Until Element Is Visible    xpath://iframe[@id='Intrnl_CO_Container']
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@aria-label='Billing Address']    Billing Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='BillingMultipleAddressesContainer']//label    Saved Address
    Run Keyword And Warn On Failure  Wait Until Element Is Visible    xpath://select[@id='SavedBillingAddressSelector']
    Run Keyword And Warn On Failure  Element Should Be Visible    xpath://select[@id='SavedBillingAddressSelector']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='SavedBillingAddressPreviewContainer']/div[@class='preview-user']         ${customerName}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='SavedBillingAddressPreviewContainer']/div[@class='preview-address-1']    ${customerStreetAddress}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='SavedBillingAddressPreviewContainer']/div[@class='preview-address-2']    ${customerFlat}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='SavedBillingAddressPreviewContainer']/div/span[@class='preview-city']    ${customerCity}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='SavedBillingAddressPreviewContainer']/div/span[@class='preview-zip']     , ${customerZipcode}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='SavedBillingAddressPreviewContainer']/div[@class='preview-country']      ${Country}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='SavedBillingAddressPreviewContainer']/div[@class='preview-phone']        ${customerPhone}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://a[@id='AddNewBillingAddress']    Add a New Billing Address
    Unselect Frame

Verify order summary data in payment page for EU
    [Arguments]  ${size}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='productsHeader']/div[1]    Order Summary
    Page Should Contain Element    xpath://div[@id='productContainer']//img
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='attr-name productName'])[1]    ${PDP_product_1_primary_name} In ${PDP_product_1_secondary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='attr-value'])[1]    ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='quantityHeader']    QUANTITY
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'product-qty')]    1
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='priceHeader']    PRICE
    ${product_price}   Get Text  xpath:(//div[contains(@class,'product-price')])[1]
    ${product_price}   Remove currency and comma from price    ${product_price}
    ${product_price}   Evaluate    int(float("${product_price}"))
    ${pdp_price_int}   Convert To Integer    ${PDP_product_1_price}
   IF  '${shoplocale}' in ['FR']
    Should Be Equal As Integers    ${product_price}    ${pdp_price_int}00
   ELSE
    Should Be Equal As Integers    ${product_price}    ${pdp_price_int}
   END
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='totalHeader']    TOTAL
    ${product_price_total}   Get Text  xpath:(//div[contains(@class,'product-price')])[2]
    ${product_price_total}   Remove currency and comma from price    ${product_price_total}
    ${product_price_total_int}=    Evaluate    int(float("${product_price_total}"))
    ${product_price_int}  Convert To Integer    ${product_price}
    Should Be Equal As Integers    ${product_price_int}    ${product_price_total_int}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='itemsTotal']/div[2]    ITEMS TOTAL
    ${item_total}  Get Text  xpath://div[contains(@class,'minitotals-col-price')]
    ${item_total}  Remove currency and comma from price    ${item_total}
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${item_total}    ${product_price_total}
    Unselect Frame

Verify delivery details in payment page for EU
     Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@aria-label='Delivery Address']    Delivery Address
     Page Should Contain Element    xpath://fieldset[@aria-label='Delivery Address']//div[1][contains(@class,'radio-box-checked')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://label[@for='shippingDefault']    Default (same as billing address)
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://label[@for='newShipping']    Add an alternative delivery address
     Unselect Frame
    
Verify shipping details in payment page for EU
     Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@aria-label='Shipping Method']/div    Shipping Method
     Page Should Contain Element    xpath://fieldset[@aria-label='Shipping Method']//div[contains(@class,'radio-box-checked')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://fieldset[@aria-label='Shipping Method']//div[contains(@class,'radio-box-checked')]//label    Free
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='so-service-name ']/label    Express Courier (Air)
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//label[contains(@id,'shipopttime')])[2]   5 to 7 business days
     Unselect Frame
     
Verify billing summary in payment page for EU
     Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'billing-sectionheader')]/div    Billing Summary
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@data-total-row-type='TotalSummary'])[1]/div[1]    Items total
     ${billing_price}    Get Text  xpath:(//div[@data-total-row-type='TotalSummary'])[1]/div[2]
     ${billing_price}   Remove currency and comma from price    ${billing_price}
     ${billing_price_int}   Evaluate    int(float("${billing_price}"))
     ${pdp_price_int}   Convert To Integer    ${PDP_product_1_price}
    IF  '${shoplocale}' in ['FR']
    Should Be Equal As Integers    ${billing_price_int}    ${pdp_price_int}00
   ELSE
    Should Be Equal As Integers    ${billing_price_int}    ${pdp_price_int}
   END
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@data-total-row-type='Shipping'])[1]/div[1]    Shipping
     ${shipping_cost}   Get Text   xpath:(//div[@data-total-row-type='Shipping'])[1]/div[2]
     ${shipping_cost}   Remove currency and comma from price    ${shipping_cost}
     ${shipping_cost_int}   Evaluate    int(float("${shipping_cost}"))
     Should Be Equal As Integers    ${shipping_cost_int}    0
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='BillingSummaryTotalPriceLabel']    Total For Your Order
     ${billing_total}  Get Text   xpath://div[@id='BillingSummaryTotalPrice']
     ${billing_total}  Remove currency and comma from price    ${billing_total}
     Run Keyword And Warn On Failure     Should Be Equal As Strings    ${billing_total}    ${billing_price}
     Unselect Frame

Verify order summary in payment page for ring sizer
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[contains(@class,'summary-header-title')]    Order Summary
    Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[2]
    Element Should Contain    xpath:(//div[@class='line-product-name-wrapper'])[2]    ${ringSizer_product_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[2]/span    ${ringSizer_product_secondary_name}
    ${price}  Get Text   xpath:(//div[contains(@class,'line-item-total-price-amount')])[3]
    ${price}  Remove currency and comma from price    ${price}
    Run Keyword And Warn On Failure     Should Be Equal As Strings  ${price}  Complimentary
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@aria-controls='promoCodeBlockInner'])[2]    Add Promo Code
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]    Subtotal
    ${product_price}   Get Text   xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]//parent::div//following-sibling::div//span
    ${product_price}   Remove currency and comma from price    ${product_price}
    Run Keyword And Warn On Failure     Should Be Equal As Strings   ${product_price}   0
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]    Shipping

Verify order summary data in payment page for EU for 2 products
    [Arguments]  ${size}  ${size2}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='productsHeader']/div[1]    Order Summary
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='quantityHeader']    QUANTITY
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='priceHeader']    PRICE
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='totalHeader']    TOTAL
##First product
    Page Should Contain Element    xpath:(//div[@id='productContainer']//img)[1]
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='attr-name productName'])[1]    ${PDP_product_1_primary_name} In ${PDP_product_1_secondary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='attr-value'])[1]    ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'product-qty')])[1]    1
    ${product_price}   Get Text  xpath:(//div[contains(@class,'product-price')])[1]
    ${product_price}   Remove currency and comma from price    ${product_price}
    ${product_price}   Evaluate    int(float("${product_price}"))
    ${pdp_price_int}   Convert To Integer    ${PDP_product_1_price}
   IF  '${shoplocale}' in ['FR']
    Should Be Equal As Integers    ${product_price}    ${pdp_price_int}00
   ELSE
    Should Be Equal As Integers    ${product_price}    ${pdp_price_int}
   END
    ${product_price_total}   Get Text  xpath:(//div[contains(@class,'product-price')])[2]
    ${product_price_total}   Remove currency and comma from price    ${product_price_total}
    ${product_price_total_int}=    Evaluate    int(float("${product_price_total}"))
    ${product_price_int}  Convert To Integer    ${product_price}
    Should Be Equal As Integers    ${product_price_int}    ${product_price_total_int}
##Second product
    Page Should Contain Element    xpath:(//div[@id='productContainer']//img)[2]
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='attr-name productName'])[3]    ${PDP_product_2_primary_name} In ${PDP_product_2_secondary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    (//div[@class='attr-value'])[6]    ${size2}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'product-qty')])[2]    1
    ${product_price}   Get Text  xpath:(//div[contains(@class,'product-price')])[3]
    ${product_price}   Remove currency and comma from price    ${product_price}
    ${product_price}   Evaluate    int(float("${product_price}"))
    ${pdp_price_int}   Convert To Integer    ${PDP_product_2_price}
   IF  '${shoplocale}' in ['FR']
    Should Be Equal As Integers    ${product_price}    ${pdp_price_int}00
   ELSE
    Should Be Equal As Integers    ${product_price}    ${pdp_price_int}
   END
    ${product_price_total}   Get Text  xpath:(//div[contains(@class,'product-price')])[4]
    ${product_price_total}   Remove currency and comma from price    ${product_price_total}
    ${product_price_total_int}=    Evaluate    int(float("${product_price_total}"))
    ${product_price_int}  Convert To Integer    ${product_price}
    Should Be Equal As Integers    ${product_price_int}    ${product_price_total_int}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='itemsTotal']/div[2]    ITEMS TOTAL
    ${item_total}  Get Text  xpath://div[contains(@class,'minitotals-col-price')]
    ${item_total}  Remove currency and comma from price    ${item_total}
    ${item_total}=    Evaluate    int(float("${item_total}"))
    ${item_total_int}  Convert To Integer    ${item_total}
    ${total_pdp}   Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price}
    IF  '${shoplocale}' in ['FR']
    Should Be Equal As Integers    ${item_total_int}    ${total_pdp}00
   ELSE
    Should Be Equal As Integers    ${item_total_int}    ${total_pdp}
   END
    Unselect Frame


Launch and close klarna pay later
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Set Focus To Element  (//span[@title='Klarna'])[1]
    Click Element    xpath:(//span[@title='Klarna'])[1]
    Sleep  5s
    Click Element    xpath://button[@id='btnPay']
    Unselect Frame
    Sleep  10s
    @{winHandles}=    Get Window Handles
    Switch Window    ${winHandles}[1]
    Wait Until Page Contains Element    xpath://div[@id='collectPhonePurchaseFlow__nav-bar__klarna_logo']     100s
    Close Window
    Switch Window    ${winHandles}[0]

Launch and close klarna pay in 3
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Set Focus To Element  (//span[@title='Klarna'])[2]
    sleep  2s
    Click By JS    xpath:(//span[@title='Klarna'])[2]
    Sleep  10s
    Click Element    xpath://button[@id='btnPay']
    Unselect Frame
    Sleep  10s
    @{winHandles}=    Get Window Handles
    Switch Window    ${winHandles}[1]
    Wait Until Page Contains Element    xpath://div[@id='collectPhonePurchaseFlow__nav-bar__klarna_logo']     100s
    Close Window
    Switch Window    ${winHandles}[0]

Pay with klarna
    Set Focus To Element  (//span[@title='Klarna'])[1]
    sleep  2s
    Click By JS    xpath:(//span[@title='Klarna'])[1]
    Sleep  5s
    Click Element    xpath://button[@id='btnPay']
    Unselect Frame
    Sleep  10s
    @{winHandles}=    Get Window Handles
    Switch Window    ${winHandles}[1]
    Wait Until Page Contains Element    xpath://div[@id='collectPhonePurchaseFlow__nav-bar__klarna_logo']
    Mouse Click  ${klarna_phoneVerify_continue}
    Check and Input text  ${klarna_otpField}   123456
    Check And Click  ${klarna_choosePlan_continue}
    Check And Click  ${klarna_confirm_paywithklarnaBtn}
    Switch Window    ${winHandles}[0]

Launch and close gpay
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Set Focus To Element  //span[@title='Google Pay']
    sleep  2s
    Click By JS    xpath://span[@title='Google Pay']
    Sleep  5s
    Click Element    xpath://button[@id='btnPay']
    Unselect Frame
    Wait Until Page Contains Element    xpath://h2[1]     100s
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[1]    Complete payment using Google Pay
    Wait Until Page Contains Element  //button[@id='btnCancel']  10s
    Set Focus To Element  //button[@id='btnCancel']
    Mouse Click    xpath://button[@id='btnCancel']
    Sleep  2s
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Wait Until Element Is Visible    xpath://button[@id='btnPay']
    Unselect Frame


Select the PayPal payment method for EU
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Click Element    xpath://span[@title='PayPal']
    Sleep  5s
    Click Element    xpath://button[@id='btnPay']
    Unselect Frame

Log into PayPal for EU
    Wait Until Page Contains Element    xpath://input[@id='email']     100s    Email field is not loaded
    CommonWeb.Check and Input text      xpath://input[@id='email']       ${PAYPAL_user}
    Click Button    ${affirm_next_l}
    CommonWeb.Check and Input text     xpath://input[@id='password']       ${PAYPAL_pass}
    Click Button    xpath://button[@id='btnLogin']
    Wait Until Page Contains Element    xpath://button[@id='payment-submit-btn']     100s    Consent text is not loaded

On Paypal Account click on Save and Continue for EU
    Click Element    xpath://button[@id='payment-submit-btn']
    Sleep    10s    #to be improved

Verify billing summary in payment page for EU for 2 products
     Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'billing-sectionheader')]/div    Billing Summary
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@data-total-row-type='TotalSummary'])[1]/div[1]    Items total
     ${billing_price}    Get Text  xpath:(//div[@data-total-row-type='TotalSummary'])[1]/div[2]
     ${billing_price}   Remove currency and comma from price    ${billing_price}
     ${billing_price_int}   Evaluate    int(float("${billing_price}"))
     ${pdp_price_int_1}     Convert To Integer    ${PDP_product_1_price}
     ${pdp_price_int_2}     Convert To Integer    ${PDP_product_2_price}
     ${pdp_price_int}      Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price}
    IF  '${shoplocale}' in ['FR']
    Should Be Equal As Integers    ${billing_price_int}    ${pdp_price_int}00
   ELSE
    Should Be Equal As Integers    ${billing_price_int}    ${pdp_price_int}
   END
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@data-total-row-type='Shipping'])[1]/div[1]    Shipping
     ${shipping_cost}   Get Text   xpath:(//div[@data-total-row-type='Shipping'])[1]/div[2]
     ${shipping_cost}   Remove currency and comma from price    ${shipping_cost}
     ${shipping_cost_int}   Evaluate    int(float("${shipping_cost}"))
     Should Be Equal As Integers    ${shipping_cost_int}    0
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@id='BillingSummaryTotalPriceLabel']    Total For Your Order
     ${billing_total}  Get Text   xpath://div[@id='BillingSummaryTotalPrice']
     ${billing_total}  Remove currency and comma from price    ${billing_total}
     Run Keyword And Warn On Failure     Should Be Equal As Strings    ${billing_total}    ${billing_price}
     Unselect Frame


Verify payment page shipping information for mixed cart bopis and delivery
    Sleep  5s
    Wait Until Page Contains Element    xpath://h3[contains(@class,'card-header-checkout')]   timeout=30s
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h3[contains(@class,'card-header-checkout')]      Shipping Information
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'summary-text')]      Email
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'summary-email')]     ${guest_valid}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//button[@aria-label='Edit Shipping'])[2]   Edit
    Page Should Contain Element   xpath:(//p[contains(@class,'shipping-info-title')])[1]
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[contains(@class,'shipping-info-title')])[1]   Delivery
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title')])[1]/span   (1 Items)
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[1]    Shipping Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[1]  ${FIRST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[1]/span[2]  ${LAST_NAME}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address1')])[1]   ${Newuser_StreetAddress}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'address2')])[1]   ${Newuser_Flat}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[1]   ${Newuser_City},
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[2]   ${Newuser_State}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[3]   ${Newuser_Zipcode}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-text')])[4]/span[4]   ${Country}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'shipping-phone')]     ${Newuser_Phone}
    Page Should Contain Element   xpath:(//p[contains(@class,'shipping-info-title in-store-pickup')])
    Run Keyword And Warn On Failure   Element Text Should Be   xpath:(//p[contains(@class,'shipping-info-title in-store-pickup')])   Pick Up In Store
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title')])[5]/span   (1 Items)
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[4]    Store Address
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='store-info-container']//p  ${bopis_storeName} \n${bopis_storeDetails}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//p[contains(@class,'shipping-info-title-text')])[5]  Pick Up In Store
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'store-info-text')]   Available in 4-8 hours. We will notify you when your order is ready for pickup.


Verify order summary in payment page for mixed cart bopis and delivery
    [Arguments]  ${size}  ${size2}
    Run Keyword And Warn On Failure  Element Text Should Be    xpath://h2[contains(@class,'summary-header-title')]    Order Summary
##First Product details
    Wait Until Page Contains Element   xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[3]  10s
    Element Should Contain     xpath:(//div[@class='line-product-name-wrapper'])[3]    ${PDP_product_1_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[3]/span    ${PDP_product_1_secondary_name}
    ${payment_product_1_price}   Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[5]
    ${payment_product_1_price}   Remove currency and comma from price    ${payment_product_1_price}
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${payment_product_1_price}   ${PDP_product_1_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[7]    Size ${size2}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[3]   Qty 1
###Second Product details
    Page Should Contain Element    xpath:(//div[contains(@class,'order-product-summary')]//div[@class='item-image'])[4]
    Element Should Contain     xpath:(//div[@class='line-product-name-wrapper'])[4]   ${PDP_product_2_primary_name}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-product-name-wrapper'])[4]/span    ${PDP_product_2_secondary_name}
    ${checkout_product_2_price}   Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[6]
    ${checkout_product_2_price}   Remove currency and comma from price    ${checkout_product_2_price}
    Run Keyword And Warn On Failure     Should Be Equal As Strings  ${checkout_product_2_price}   ${PDP_product_2_price}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-attributes')])[10]    Size ${size}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'checkout-right-container')]//p[contains(@class,'line-item-pricing-info')])[4]   Qty 1
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//a[@aria-controls='promoCodeBlockInner'])[2]    Add Promo Code
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]    Subtotal
    ${subTotal}    Evaluate    ${PDP_product_2_price} + ${PDP_product_1_price}
    ${grandTotal}  Get Text    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[4]//parent::div//following-sibling::div//span
    ${grandTotal}  Remove currency and comma from price    ${grandTotal}
    Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='checkout-right-container-total']//p[contains(@class,'order-receipt-label')])[5]    Shipping


Accept Adyen authentication
    sleep  5s
    Switch Window  Payment Authentication
#    sleep  100s
    Wait Until Page Contains Element  //iframe  100s
    sleep  30s
    Select Frame    //iframe
    Wait Until Element Is Visible  ${Adyen_passwordField}  30s
    Check and Input text    ${Adyen_passwordField}    ${Adyen_password}
    Click by JS    ${Adyen_submitBtn}
    Unselect Frame
    Sleep  15s
