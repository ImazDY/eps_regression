*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot


*** Keywords ***
Click on Add Gift Message CTA
    CommonWeb.Scroll And Click    ${gift_msg_l}
    Wait Until Page Contains Element    ${gift_msg_show_l}    timeout=3s    error=Add Gift Message form is not displayed

Click on Remove Gift Message CTA
    Click Element    ${gift_msg_l}
    Wait Until Page Does Not Contain Element    ${gift_msg_show_l}    timeout=3s    error=Add Gift Message form is still displayed

Fill in the Gifting Form from Shipping step
    [Arguments]    ${gift_recipent}   ${gift_sender}   ${gift_message}
    ${recipent_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${giftRecipient_l}    timeout=3s    error=Recipent field is not visible
    Run Keyword If    ${recipent_true}    CommonWeb.Scroll To Element    ${giftRecipient_l}
    Run Keyword If    ${recipent_true}    Input text    ${giftRecipient_l}    ${gift_recipent}
    ${sender_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${giftSender_l}    timeout=3s    error=Sender field is not visible
    Run Keyword If    ${sender_true}    CommonWeb.Scroll To Element    ${giftSender_l}
    Run Keyword If    ${sender_true}    Input text    ${giftSender_l}    ${gift_sender}
    ${gift_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${giftMessage_l}    timeout=3s    error=Gift Message field is not visible
    Run Keyword If    ${gift_true}    CommonWeb.Scroll To Element    ${giftMessage_l}
    Run Keyword If    ${gift_true}    Input text    ${giftMessage_l}    ${gift_message}
    Set Test Variable    ${gift_recipent}
    Set Test Variable    ${gift_sender}
    Set Test Variable    ${gift_message}

Click on Preview Gift Message from Shipping step and verify the entered texts
    Click Element    ${gift_preview_l}
    Wait Until Page Contains Element    ${gift_preview_show_l}    timeout=3s        error=Preview Image did not appeared
    ${recipent_preview_text}    Get Text    ${gift_preview_rec_l}
    ${sender_preview_text}    Get Text    ${gift_preview_sen_l}
    ${gift_preview_text}    Get Text    ${gift_preview_txt_l}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${recipent_preview_text}    ${gift_recipent}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${sender_preview_text}    ${gift_sender}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${gift_preview_text}    ${gift_message}

Check that the Gifting Image is visible
    Element Should Be Visible    ${gifting_image_l}

Enter valid Shipping details
    [Arguments]    ${GUEST_EMAIL}   ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${CITY}  ${STATE}  ${ZIP}   ${PHONE}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_email}    timeout=3s
    Run Keyword If    ${shippingMail}     Scroll To Element   ${shipping_email}
    Run Keyword If    ${shippingMail}     CommonWeb.Check and Input text          ${shipping_email}    ${GUEST_email}
    Run Keyword If    ${shippingMail}     Wait Until Page Contains Element    ${shipping_email_entered_l}    5s    error=Email was not entered
    ${shippingName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_fn}    timeout=3s
    Run Keyword If    ${shippingName}     Scroll To Element   ${shipping_fn}
    Run Keyword If    ${shippingName}     CommonWeb.Check and Input text          ${shipping_fn}    ${FIRST_NAME}
    Wait Until Page Contains Element    ${shipping_fn_entered_l}    5s    error=First Name was not entered
    ${shippingLastName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_ln}    timeout=3s
    Run Keyword If    ${shippingLastName}     Scroll To Element   ${shipping_ln}
    Run Keyword If    ${shippingLastName}     CommonWeb.Check and Input text          ${shipping_ln}    ${LAST_NAME}
    Wait Until Page Contains Element    ${shipping_ln_entered_l}    5s    error=Last Name was not entered
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_phone}    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   ${shipping_phone}
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          ${shipping_phone}    ${PHONE}
    Wait Until Page Contains Element    ${shipping_phone_entered_l}    5s    error=Phone was not entered
    ${shippingAddress1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_address_one}    timeout=3s
    Run Keyword If    ${shippingAddress1}   Scroll To Element   ${shipping_address_one}
    Run Keyword If    ${shippingAddress1}   CommonWeb.Check and Input text          ${shipping_address_one}    ${ADDRESS}

    Wait Until Page Contains Element    ${shipping_address_one_entered_l}    5s    error=Address was not entered
    ${shippingCityName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_city}    timeout=3s
    Run Keyword If    ${shippingCityName}     Scroll To Element   ${shipping_city}
    Run Keyword If    ${shippingCityName}     CommonWeb.Check and Input text          ${shipping_city}    ${CITY}
    Wait Until Page Contains Element    ${shipping_city_entered_l}    5s    error=City was not entered
    CommonWeb.Scroll To Element    ${shipping_address_one}
    ${shippingStateName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_state}    timeout=5s
    Run Keyword If    ${shippingStateName}    Click Element    ${shipping_state_lbl}
    Run Keyword If    ${shippingStateName}    Click Element    xpath://div[contains(@class,"dwfrm_shipping_shippingAddress_addressFields_states_stateCode")]//li[contains(.,'${STATE}')]
    Wait Until Page Contains Element    ${shipping_state_selected_l}    5s
    Run Keyword And Warn On Failure  Element Text Should Be    ${shipping_state_selected_l}    ${STATE}
    ${shippingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_zip}    timeout=3s
    Run Keyword If    ${shippingZipCode}     Scroll To Element   ${shipping_zip}
    Sleep    2s
    Run Keyword If    ${shippingZipCode}     CommonWeb.Check and Input text          ${shipping_zip}   ${ZIP}
    Wait Until Page Contains Element    ${shipping_zip_entered_l}    5s    error=Zip was not entered

Enter invalid Shipping details
    [Arguments]    ${invalid_EMAIL}   ${invalid_PHONE}    ${invalid_CITY}    ${invalid_ZIP}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_email}    timeout=3s
    Run Keyword If    ${shippingMail}     Scroll To Element   ${shipping_email}
    Run Keyword If    ${shippingMail}     CommonWeb.Check and Input text          ${shipping_email}    ${invalid_EMAIL}
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_phone}    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   ${shipping_phone}
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          ${shipping_phone}    ${invalid_PHONE}
    ${shippingCityName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_city}    timeout=3s
    Run Keyword If    ${shippingCityName}     Scroll To Element   ${shipping_city}
    Run Keyword If    ${shippingCityName}     CommonWeb.Check and Input text          ${shipping_city}    ${invalid_CITY}
    CommonWeb.Scroll To Element    ${shipping_address_one}
    ${shippingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_zip}    timeout=3s
    Run Keyword If    ${shippingZipCode}     Scroll To Element   ${shipping_zip}
    Run Keyword If    ${shippingZipCode}     CommonWeb.Check and Input text          ${shipping_zip}   ${invalid_ZIP}

Clear the Checkout Shipping form
    Press Keys     ${shipping_email}     CONTROL+A   DELETE
    Press Keys     ${shipping_fn}     CONTROL+A   DELETE
    Press Keys     ${shipping_ln}     CONTROL+A   DELETE
    Press Keys     ${shipping_phone}     CONTROL+A   DELETE
    Press Keys     ${shipping_address_one}     CONTROL+A   DELETE
    Press Keys     ${shipping_address_two}     CONTROL+A   DELETE
    Press Keys     ${shipping_city}     CONTROL+A   DELETE
    Press Keys     ${shipping_zip}     CONTROL+A   DELETE
    Click Element    ${shipping_state_lbl}
    Click Element    css:.selectric-shippingState [data-index="1"]

Verify the empty fields validation on Shipping Address step
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_email_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_email_empty_err_l}    ${shipping_email_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_fn_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_fn_empty_err_l}    ${shipping_fn_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_ln_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_ln_empty_err_l}    ${shipping_ln_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_phone_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_phone_empty_err_l}    ${shipping_phone_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_city_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_city_empty_err_l}    ${shipping_city_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_state_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_state_empty_err_l}    ${shipping_state_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_zip_empty_err_l}     5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_zip_empty_err_l}    ${shipping_zip_empty_err}

Click on Continue To Payment button
    CommonWeb.Scroll And Click by JS    ${submit_shipping_l}

Select an Address from Address Suggestion modal
    [Arguments]    ${selection}
    ${suggested_modal_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_show_verify_l}    10s
    Run Keyword If    ${suggested_modal_true}     CommonWeb.Check and Click    css:input[data-type='${selection}']+label
    Run Keyword If    ${suggested_modal_true}    Click on Continue button from Select An Address modal

Select the Suggested Address from Address Suggestion modal
    ${suggested_modal_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_show_verify_l}    10s
    Run Keyword If    ${suggested_modal_true}     CommonWeb.Check and Click           ${shipping_address_one_l}
    Run Keyword If    ${suggested_modal_true}    Click on Continue button from Select An Address modal

Click on Continue button from Select An Address modal
    sleep  5s
    Click Element    ${shipping_save_selected_add}
    Wait Until Location Contains    ?stage=payment#payment    10s    Payment step was not loaded in 10s

Check that the default delivery method is selected
    [Arguments]    ${del}
    Run Keyword And Warn On Failure    Element Text Should Be    ${shipping_selected_del_l}    ${del}

Select Delivery
    [Arguments]    ${del}
   IF    "${del}" == "2-day"
        Wait Until Page Contains Element    ${shipping_2_day_del_l}    5s
        CommonWeb.Scroll And Click by JS    ${shipping_2_day_del_l}
    ELSE IF    "${del}" == "Overnight"
        Wait Until Page Contains Element    ${shipping_overnight_del_l}    5s
        CommonWeb.Scroll And Click by JS    ${shipping_overnight_del_l}
    ELSE IF    "${del}" == "Standard"
        Wait Until Page Contains Element    ${shipping_standard_del_l}    5s
        Scroll To Element  ${shipping_standard_del_l}
        Click by JS    ${shipping_standard_del_l}
    ELSE IF    "${del}" == "USPS"
        Wait Until Page Contains Element    ${shipping_usps_del_l}    5s
        CommonWeb.Scroll And Click by JS    ${shipping_usps_del_l}
    ELSE IF    "${del}" == "3 to 5 days"
        Wait Until Page Contains Element    ${shipping_3_day_del_l}    5s
        Center Element on Screen    ${shipping_3_day_del_l}
        Set Focus To Element    ${shipping_3_day_del_l}
        Click by JS    ${shipping_3_day_del_l}
   END
#    Wait Until Page Contains Element    ${shipping_selected_shipping_l}    10s    Shipping is not yet selected
    Sleep  1s
    ${selected_shipping_cost}     Check and Get text    ${shipping_sale_shipping_l}
    Set Test Variable    ${retrieved_shipping_cost}    ${selected_shipping_cost}

Check if the Shipping cost was update in the Summary
    ${summary_shipping}    Check and Get text    css:.d-lg-block .shipping-total-cost
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${summary_shipping}    ${retrieved_shipping_cost}

Verify the invalid fields validation on Shipping Address step
    Enter invalid Shipping details        io.com    000    $    ---
    Click on Continue To Payment button
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_email_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_email_empty_err_l}    ${shipping_email_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_phone_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_phone_empty_err_l}    ${shipping_phone_invalid_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_city_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_city_empty_err_l}    ${shipping_city_invalid_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_zip_empty_err_l}     5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_zip_empty_err_l}    ${shipping_zip_invalid_err}

Enter text in shipping address
    [Arguments]     ${add}
    Scroll Element Into View    ${shipping_phone}
    Clear Element Text     ${shipping_address_one}
    CommonWeb.Check and Input text          ${shipping_address_one}     ${add}

Verify the address suggestions are NOT displayed
    Scroll Element Into View    ${shipping_phone}
    Wait Until Page Contains Element    ${dqe_disabled}      20s     error= Address Suggestions are displayed

Verify the address suggestions are displayed
    Scroll Element Into View    ${shipping_phone}
    Wait Until Page Contains Element    ${dqe_enabled}    20s     error= Address Suggestions are not loaded
    Wait Until Element Is Visible    ${dqe_enabled}     20s     error= Address Suggestions are not visible
    Wait Until Element Is Visible    ${dqe_enabled_lbl}     20s     error= Address Suggestions are not visible

Select suggestion number
    [Arguments]     ${nr}
    Wait Until Element Is Visible    ${dqe_enabled_list}     20s     error= Address Suggestions are not visible
    Scroll Element Into View    css:.pac-container .pac-item:nth-child(${nr}) .pac-item-query+span
    Click Element   css:.pac-container .pac-item:nth-child(${nr}) .pac-item-query+span

Fill in the remaining Shipping details
    [Arguments]     ${mail}    ${fn}    ${ln}    ${phone}
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    Sleep  2s
    Scroll To Element   ${shipping_email}
    CommonWeb.Check and Input text          ${shipping_email}    ${mail}
    Sleep  2s
    Scroll To Element   ${shipping_fn}
    CommonWeb.Check and Input text          ${shipping_fn}    ${fn}
    Sleep  2s
    Scroll To Element   ${shipping_ln}
    CommonWeb.Check and Input text          ${shipping_ln}    ${ln}
    Sleep  2s
    Scroll To Element   ${shipping_phone}
    CommonWeb.Check and Input text          ${shipping_phone}    ${phone}

Change the state and zip
    [Arguments]    ${STATE}    ${ZIP}
    CommonWeb.Scroll To Element    ${shipping_address_one}
    ${shippingStateName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_state}    timeout=5s
    Run Keyword If    ${shippingStateName}    Click Element    ${shipping_state_lbl}
    Run Keyword If    ${shippingStateName}    Click Element    xpath://fieldset[@class="shipping-address-block "]//li[contains(.,'${STATE}')]
    ${shippingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_zip}    timeout=3s
    Run Keyword If    ${shippingZipCode}     Scroll To Element   ${shipping_zip}
    Run Keyword If    ${shippingZipCode}     CommonWeb.Check and Input text          ${shipping_zip}   ${ZIP}


Enter valid Shipping details for EU
    [Arguments]    ${GUEST_EMAIL}   ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}  ${CITY}  ${ZIP}   ${PHONE}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    ${shippingName}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_BillingFirstName']    timeout=3s
    Run Keyword If    ${shippingName}     Scroll To Element   xpath://input[@id='CheckoutData_BillingFirstName']
    Run Keyword If    ${shippingName}     CommonWeb.Check and Input text      xpath://input[@id='CheckoutData_BillingFirstName']    ${FIRST_NAME}
    ${shippingLastName}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_BillingLastName']    timeout=3s
    Run Keyword If    ${shippingLastName}     Scroll To Element   xpath://input[@id='CheckoutData_BillingLastName']
    Run Keyword If    ${shippingLastName}     CommonWeb.Check and Input text     xpath://input[@id='CheckoutData_BillingLastName']    ${LAST_NAME}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_Email']    timeout=3s
    Run Keyword If    ${shippingMail}         Scroll Page    0    document.getElementById('CheckoutData_Email').offsetTop
    Run Keyword If    ${shippingLastName}     CommonWeb.Check and Input text   xpath://input[@id='CheckoutData_Email']    ${guest_valid}
    ${shippingAddress1}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_BillingAddress1']    timeout=3s
    Run Keyword If    ${shippingAddress1}   Scroll To Element   xpath://input[@id='CheckoutData_BillingAddress1']
    Run Keyword If    ${shippingAddress1}   CommonWeb.Check and Input text          xpath://input[@id='CheckoutData_BillingAddress1']    ${ADDRESS}
    Select dropdown Address - EU
    ${shippingAddress2}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_BillingAddress1']    timeout=3s
    Run Keyword If    ${shippingAddress2}   Scroll To Element   xpath://input[@id='CheckoutData_BillingAddress2']
    Run Keyword If    ${shippingAddress2}   CommonWeb.Check and Input text          xpath://input[@id='CheckoutData_BillingAddress2']    ${ADDRESS2}
    ${shippingCityName}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='BillingCity']    timeout=3s
    Run Keyword If    ${shippingCityName}     Scroll To Element   xpath://input[@id='BillingCity']
    Run Keyword If    ${shippingCityName}     CommonWeb.Check and Input text          xpath://input[@id='BillingCity']    ${CITY}
    ${shippingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='BillingZIP']    timeout=3s
    Run Keyword If    ${shippingZipCode}     Scroll To Element   xpath://input[@id='BillingZIP']
    Sleep    2s
    Run Keyword If    ${shippingZipCode}     CommonWeb.Check and Input text          xpath://input[@id='BillingZIP']   ${ZIP}
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='CheckoutData_BillingPhone']    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   xpath://input[@id='CheckoutData_BillingPhone']
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          xpath://input[@id='CheckoutData_BillingPhone']    ${PHONE}
    Unselect Frame



Check delivery date and message for the shipping method
   [Arguments]  ${shipping_method}
   ${currentDate}         Get Current Date
   ${currentDay}          Get Current Date    result_format=%A
   ${current_time}        Get Current Date    result_format=%H:%M:%S
   ${threshold_time}      Set Variable    15:00:00
   ${current_time_obj}    Convert Time    ${current_time}
   ${threshold_time_obj}  Convert Time    ${threshold_time}
   IF  "${shipping_method}" == "2-day"
     IF  '${currentDay}' == 'Thursday'
        ${deliveryDate}=  Add Time To Date    ${currentDate}    4 days   result_format=%m/%d/%y
        #${convertedDate}=  Add Time To Date    ${currentDate}    4 days   result_format=A%, %m/%d/%y
     ELSE IF  '${currentDay}' == 'Friday'
        ${deliveryDate}=  Add Time To Date    ${currentDate}    3 days   result_format=%m/%d/%y
        #${convertedDate}=  Add Time To Date    ${currentDate}    3 days   result_format=A%, %m/%d/%y
     ELSE
        ${deliveryDate}=  Add Time To Date     ${currentDate}    2 days   result_format=%m/%d/%y
        ${convertedDate}=  Add Time To Date    ${currentDate}    2 days   result_format=%A, %m/%d/%y
     END
   ELSE IF  "${shipping_method}" == "Overnight"
      ${deliveryDate}=  Add Time To Date    ${currentDate}    1 days
   ELSE IF  "${shipping_method}" == "3 to 5 days"
      ${deliveryDate}=  Add Time To Date    ${currentDate}    5 days
   END
   IF  '${current_time_obj}' < '${threshold_time_obj}'
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'shipping-method-option') and contains(@class,'selected')]//span[contains(@class,'arrival-time')]    Order today for delivery by ${deliveryDate}.
   ELSE
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'shipping-method-option') and contains(@class,'selected')]//span[contains(@class,'arrival-time')]    Order before 3 PM Eastern Time for delivery by ${deliveryDate}.
   END

Check delivery date and message for the shipping method - CN
   [Arguments]  ${shipping_method}
   IF  "${shipping_method}" == "3 to 5 days"
         Element Text Should Be    xpath://div[contains(@class,'shipping-method-option') and contains(@class,'selected')]//span[contains(@class,'arrival-time')]    Delivery within 4-10 business days.
   END


Verify the empty fields validation on Shipping Address step for EU
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_email_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_email_empty_err_l}    ${shipping_email_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_fn_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_fn_empty_err_l}    ${shipping_fn_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_ln_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_ln_empty_err_l}    ${shipping_ln_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_phone_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_phone_empty_err_l}    ${shipping_phone_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_city_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_city_empty_err_l}    ${shipping_city_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_state_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_state_empty_err_l}    ${shipping_state_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_zip_empty_err_l}     5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_zip_empty_err_l}    ${shipping_zip_empty_err}


Verify the invalid fields validation on Shipping Address step for EU
    Enter invalid Shipping details        io.com    000    $    ---
    Click on Continue To Payment button
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_email_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_email_empty_err_l}    ${shipping_email_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_phone_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_phone_empty_err_l}    ${shipping_phone_invalid_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_city_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_city_empty_err_l}    ${shipping_city_invalid_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_zip_empty_err_l}     5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_zip_empty_err_l}    ${shipping_zip_invalid_err}

Verify shipping charge for selected delivery
   [Arguments]  ${delivery}
  IF  '${delivery}' in ['2-day', '3 to 5 days', 'pick up']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'shipping-method-list')]//div[contains(@class,'selected')]//div[contains(@class,'shipping-cost')])[1]    Complimentary
  ELSE IF  '${delivery}' in ['Overnight']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'shipping-method-list')]//div[contains(@class,'selected')]//div[contains(@class,'shipping-cost')])[1]    $17
  END

Check delivery message for pickup order
   Wait Until Element Is Visible    xpath:(//span[contains(@class,'arrival-time')])[1]
   Element Text Should Be    xpath:(//span[contains(@class,'arrival-time')])[1]    Available in 4-8 hours. We will notify you when your order is ready for pickup.

Select dropdown address
    log  CCMS-6444
    Wait Until Element Is Visible  (//*[@class='dropdown-item'])[1]  5s
    Click by JS    (//*[@class='dropdown-item'])[1]

Select dropdown address - EU
    Wait Until Element Is Visible  (//input[@id='CheckoutData_BillingAddress1']/following-sibling::*//div/a)[1]  5s
#    Set Focus To Element  (//input[@id='CheckoutData_BillingAddress1']/following-sibling::*//div/a)[1]
    Center Element on Screen    (//input[@id='CheckoutData_BillingAddress1']/following-sibling::*//div/a)[1]
    Click by JS  (//input[@id='CheckoutData_BillingAddress1']/following-sibling::*//div/a)[1]

Check customer care number present at checkout header
    log  CCMS-6476
    Run Keyword And Warn On Failure  Wait Until Page Contains Element  //*[contains(@class,'block') and contains(text(),'${CustomerCarePhone}')]  5s