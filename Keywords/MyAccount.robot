*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
#Library           AutoItLibrary
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Login.robot
Resource          ../Resources/Errors.robot


*** Keywords ***
Check if new address was saved after purchase
    [Arguments]    ${fn}   ${ln}    ${adr}   ${zip}    ${tel}
    Wait Until Element Is Not Visible    ${myA_new_addr_fn_l}    10s
    Wait Until Element Is Visible    ${myA_new_addr_first_row_l}    10s
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_first_row_l}    ${fn}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_first_row_l}    ${ln}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_second_row_l}    ${adr}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_third_row_l}    ${zip}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_fourth_row_l}    ${tel}

See if Order History page contains the order from last purchase
    Run Keyword And Warn On Failure    Page Should Contain    ${order}
    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_order_details_cont_as_l}    10s

Check new credit card was saved after the purchase
    Run Keyword And Warn On Failure    Element Should Be Visible    ${myA_new_card_first_row_l}
    Run Keyword And Warn On Failure    Element Should Be Visible    ${myA_new_card_row_info_l}
    Run Keyword And Warn On Failure    Element Should Be Visible    ${myA_new_card_next_row_l}

Check that the user is successfully logged in and redirected to Account Details page
    [Arguments]    ${email}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${my_account_page_l}    10s
    Run Keyword And Warn On Failure    Element Should Contain    ${my_acc_email_elm_l}    ${email}

Click on Add a New Address button
    Scroll Element Into View    ${myA_add_address_cta_l}
    Click Element    ${myA_add_address_cta_l}
    Wait Until Page Contains Element    ${myA_add_show_address_cta_l}    10s
    Wait Until Element Is Visible    ${myA_add_addr_fn_l}    10s

Click on Save button from Add a New Address form
    Click Element    ${myA_add_addr_save_cta_l}
    sleep  5s

Verify the empty field validation messages for Add a New Address form
    IF  '${shoplocale}' in ['CN']
      Empty field validation msgs for Add New Address form - CN
    ELSE
      Empty field validation msgs for Add New Address form
    END

Empty field validation msgs for Add New Address form
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_fn_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_fn_err_l}    Please enter your first name.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_ln_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_ln_err_l}    Please enter your last name.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_addr_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_addr_err_l}    Please enter your address.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_city_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_city_err_l}    Please enter your city.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_state_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_state_err_l}    Please select a state.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_zip_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_zip_err_l}    Please enter your ZIP code.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_tel_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_tel_err_l}    Please enter your telephone number.

Empty field validation msgs for Add New Address form - CN
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_fn_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_fn_err_l}    Please enter your first name.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_ln_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_ln_err_l}    Please enter your last name.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_addr_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_addr_err_l}    Please enter your address.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_city_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_city_err_l}    Please enter your city.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_state_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_state_err_l}    Please select a province.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_zip_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_zip_err_l}    Please enter your postal code.
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_tel_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_tel_err_l}    Please enter your telephone number.


Fill in the Add a New Address form
    [Arguments]    ${fn}   ${ln}    ${adr}  ${adr2}   ${city}    ${state}    ${zip}    ${tel}
    ${myaccfname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_fn_l}    3s
    Run Keyword If    ${myaccfname}     Scroll To Element   ${myA_add_addr_fn_l}
    Run Keyword If    ${myaccfname}     CommonWeb.Check and Input text          ${myA_add_addr_fn_l}    ${fn}
    ${myacclname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_ln_l}    3s
    Run Keyword If    ${myacclname}     Scroll To Element   ${myA_add_addr_ln_l}
    Run Keyword If    ${myacclname}     CommonWeb.Check and Input text          ${myA_add_addr_ln_l}    ${ln}
    ${myaccaddr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_addr_l}    3s
    Run Keyword If    ${myaccaddr}     Scroll To Element   ${myA_add_addr_addr_l}
    Run Keyword If    ${myaccaddr}     CommonWeb.Check and Input text          ${myA_add_addr_addr_l}    ${adr}
    ${myaccaddr2}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='address2']    3s
    Run Keyword If    ${myaccaddr2}     Scroll To Element   xpath://input[@id='address2']
    Run Keyword If    ${myaccaddr2}     CommonWeb.Check and Input text          xpath://input[@id='address2']    ${adr2}
    ${myacccity}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_city_l}    3s
    Run Keyword If    ${myacccity}     Scroll To Element   ${myA_add_addr_city_l}
    Run Keyword If    ${myacccity}     CommonWeb.Check and Input text          ${myA_add_addr_city_l}    ${city}
    ${myaccstate}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_state_l}    5s
    Run Keyword If    ${myaccstate}    Click Element    ${myA_add_addr_state_l}
    Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addAddress']//div[contains(@class, 'selectric-custom-select')]//li[contains(.,'${state}')]
    ${myacczip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_zip_l}    3s
    Run Keyword If    ${myacczip}     Scroll To Element   ${myA_add_addr_zip_l}
    Run Keyword If    ${myacczip}     CommonWeb.Check and Input text          ${myA_add_addr_zip_l}    ${zip}
    ${myacctel}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_tel_l}    3s
    Run Keyword If    ${myacctel}     Scroll To Element   ${myA_add_addr_tel_l}
    Run Keyword If    ${myacctel}     CommonWeb.Check and Input text          ${myA_add_addr_tel_l}    ${tel}

Check if the new address is present in My Account
    [Arguments]    ${fn}   ${ln}    ${adr}  ${adr2}   ${city}    ${zip}    ${tel}
    Wait Until Element Is Not Visible    ${myA_new_addr_fn_l}    10s
    Wait Until Element Is Visible    ${myA_new_addr_first_row_l}    10s
    Wait Until Page Contains  ${fn}  10s
    Element Should Contain    ${myA_new_addr_first_row_l}    ${fn}
    Element Should Contain    ${myA_new_addr_first_row_l}    ${ln}
    Element Should Contain    ${myA_new_addr_second_row_l}    ${adr}
    Element Should Contain    xpath://div[contains(@class,'address-item-detail')]/div[3]    ${adr2}
    Element Should Contain    ${myA_new_addr_third_row_l}    ${city}
    Element Should Contain    ${myA_new_addr_third_row_l}    ${zip}
    Element Should Contain    ${myA_new_addr_fourth_row_l}    ${tel}

Click on Edit link near first address
    CommonWeb.Scroll And Click by JS    ${myA_first_addr_edit_l}
    Wait Until Page Contains Element    ${myA_add_addr_fn_l}    10s

Fill in the Edit Address form
    [Arguments]    ${fn}   ${ln}    ${adr}  ${adr2}  ${city}    ${state}    ${zip}    ${tel}
    ${myaccfname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_fn_l}    3s
    Run Keyword If    ${myaccfname}     Press Keys     ${myA_add_addr_fn_l}     CONTROL+A   DELETE
    Run Keyword If    ${myaccfname}     Scroll To Element   ${myA_add_addr_fn_l}
    Run Keyword If    ${myaccfname}     CommonWeb.Check and Input text          ${myA_add_addr_fn_l}    ${fn}
    ${myacclname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_ln_l}    3s
    Run Keyword If    ${myacclname}     Press Keys     ${myA_add_addr_ln_l}     CONTROL+A   DELETE
    Run Keyword If    ${myacclname}     Scroll To Element   ${myA_add_addr_ln_l}
    Run Keyword If    ${myacclname}     CommonWeb.Check and Input text          ${myA_add_addr_ln_l}    ${ln}
    ${myaccaddr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_addr_l}    3s
    Run Keyword If    ${myaccaddr}     Press Keys     ${myA_add_addr_addr_l}     CONTROL+A   DELETE
    Run Keyword If    ${myaccaddr}     Scroll To Element   ${myA_add_addr_addr_l}
    Run Keyword If    ${myaccaddr}     CommonWeb.Check and Input text          ${myA_add_addr_addr_l}    ${adr}
    ${myaccaddr2}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='address2']    3s
    Run Keyword If    ${myaccaddr2}     Press Keys     xpath://input[@id='address2']     CONTROL+A   DELETE
    Run Keyword If    ${myaccaddr2}     Scroll To Element   xpath://input[@id='address2']
    Run Keyword If    ${myaccaddr2}     CommonWeb.Check and Input text          xpath://input[@id='address2']    ${adr2}
    ${myacccity}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_city_l}    3s
    Run Keyword If    ${myacccity}     Press Keys     ${myA_add_addr_city_l}     CONTROL+A   DELETE
    Run Keyword If    ${myacccity}     Scroll To Element   ${myA_add_addr_city_l}
    Run Keyword If    ${myacccity}     CommonWeb.Check and Input text          ${myA_add_addr_city_l}    ${city}
    ${myaccstate}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_state_l}    5s
    Run Keyword If    ${myaccstate}    Click Element    ${myA_add_addr_state_l}
    Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addAddress']//div[contains(@class, 'selectric-custom-select')]//li[contains(.,'${state}')]
    ${myacczip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_zip_l}    3s
    Run Keyword If    ${myacczip}     Press Keys     ${myA_add_addr_zip_l}     CONTROL+A   DELETE
    Run Keyword If    ${myacczip}     Scroll To Element   ${myA_add_addr_zip_l}
    Run Keyword If    ${myacczip}     CommonWeb.Check and Input text          ${myA_add_addr_zip_l}    ${zip}
    ${myacctel}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_tel_l}    3s
    Run Keyword If    ${myacctel}     Press Keys     ${myA_add_addr_tel_l}     CONTROL+A   DELETE
    Run Keyword If    ${myacctel}     Scroll To Element   ${myA_add_addr_tel_l}
    Run Keyword If    ${myacctel}     CommonWeb.Check and Input text          ${myA_add_addr_tel_l}    ${tel}

Click on Save button from Edit Address form
    Click Element    ${myA_edit_addr_save_l}

Click on Delete link near first address
    CommonWeb.Scroll And Click by JS    ${myA_first_addr_remove_l}
    Wait Until Page Contains Element    ${myA_first_addr_remove_conf_l}    10s
    Wait Until Element Is Visible    ${myA_first_addr_remove_conf_l}    10s

Click Confirm on the Delete Address modal
    Wait Until Element Is Visible    ${myA_first_addr_remove_conf_l}    20s
    Scroll Element Into View    ${myA_first_addr_remove_conf_l}
    Sleep  1s
    Click by JS    ${myA_first_addr_remove_conf_l}
    Wait Until Element Is Not Visible    ${myA_first_addr_remove_conf_l}    10s

Check that My Address section is empty
    Wait Until Page Does Not Contain Element    ${myA_new_addr_first_row_l}    10s
    Run Keyword And Warn On Failure    Element Should Not Be Visible    ${myA_new_addr_fourth_row_l}

Click on Add a New Credit Card button
    CommonWeb.Scroll And Click by JS    ${myA_add_payment_l}
    Wait Until Page Contains Element    ${myA_add_card_name_l}    10s

Click on Save button from Add a New Credit Card form
    CommonWeb.Scroll And Click by JS    ${myA_add_payment_save_l}

Close the New Credit Card form
    Mouse Over   ${myA_add_payment_cancel_l}
    Click Element    ${myA_add_payment_cancel_l}
    Wait Until Element Is Not Visible    ${myA_add_payment_cancel_l}    10s

Verify the empty field validation messages for Add a New Credit Card form
    IF  '${shoplocale}' in ['US']
        Empty field validation msgs for Add New Credit Card form - US
    ELSE IF  '${shoplocale}' in ['CN']
        Empty field validation msgs for Add New Credit Card form - CN
    ELSE
        Empty field validation msgs for Add New Credit Card form - EU
    END


Empty field validation msgs for Add New Credit Card form - US
#    Wait Until Page Contains Element    ${myA_card_owner_err_l}    10s
    Wait Until Page Contains   ${myA_card_owner_err}  5s
#    Wait Until Page Contains Element    ${myA_card_number_err_l}    10s
    Wait Until Page Contains    ${myA_card_number_err}  5s
#    Wait Until Page Contains Element    ${myA_card_csv_err_l}    10s
    Wait Until Page Contains    ${myA_card_csv_err}  5s
#    Wait Until Page Contains Element    ${myA_card_fn_err_l}    10s
    Wait Until Page Contains    ${myA_card_fn_err}  5s
#    Wait Until Page Contains Element    ${myA_card_ln_err_l}    10s
    Wait Until Page Contains    ${myA_card_ln_err}  5s
#    Wait Until Page Contains Element    ${myA_card_addr_err_l}    10s
    Wait Until Page Contains   ${myA_card_addr_err}  5s
#    Wait Until Page Contains Element    ${myA_card_city_err_l}    10s
    Wait Until Page Contains    ${myA_card_city_err}  5s
#    Wait Until Page Contains Element    ${myA_card_zip_err_l}    10s
    Wait Until Page Contains    ${myA_card_zip_err}  5s
#    Wait Until Page Contains Element    ${myA_card_tel_err_l}    10s
    Wait Until Page Contains    ${myA_card_tel_err}  5s
#    Wait Until Page Contains Element    ${myA_card_state_err_l}   10s
    Wait Until Page Contains   ${myA_card_state_err}  5s

#    Wait Until Page Contains Element    xpath:(//div[@class='invalid-feedback'])[23]   10s
    Wait Until Page Contains    Please enter your credit card’s expiration month.  5s
#    Wait Until Page Contains Element    xpath:(//div[@class='invalid-feedback'])[23]   10s
   Wait Until Page Contains   Please enter your credit card’s expiration year.   5s

Empty field validation msgs for Add New Credit Card form - CN
#    Wait Until Page Contains Element    ${myA_card_owner_err_l}    10s
    Wait Until Page Contains   ${myA_card_owner_err}  5s
#    Wait Until Page Contains Element    ${myA_card_number_err_l}    10s
    Wait Until Page Contains    ${myA_card_number_err}  5s
#    Wait Until Page Contains Element    ${myA_card_csv_err_l}    10s
    Wait Until Page Contains    ${myA_card_csv_err}   5s
#    Wait Until Page Contains Element    ${myA_card_fn_err_l}    10s
    Wait Until Page Contains    ${myA_card_fn_err}   5s
#    Wait Until Page Contains Element    ${myA_card_ln_err_l}    10s
    Wait Until Page Contains    ${myA_card_ln_err}  5s
#    Wait Until Page Contains Element    ${myA_card_addr_err_l}    10s
    Wait Until Page Contains    ${myA_card_addr_err}   5s
#    Wait Until Page Contains Element    ${myA_card_city_err_l}    10s
    Wait Until Page Contains    ${myA_card_city_err}   5s
#    Wait Until Page Contains Element    ${myA_card_zip_err_l}    10s
    Wait Until Page Contains    Please enter your postal code.  5s
#    Wait Until Page Contains Element    ${myA_card_tel_err_l}    10s
    Wait Until Page Contains    ${myA_card_tel_err}   5s
#    Wait Until Page Contains Element    ${myA_card_state_err_l}   10s
    Wait Until Page Contains    Please select a province.   5s

#    Wait Until Page Contains Element    xpath:(//div[@class='invalid-feedback'])[23]   10s
    Wait Until Page Contains     Please enter your credit card’s expiration month.   5s
#    Wait Until Page Contains Element    xpath:(//div[@class='invalid-feedback'])[23]   10s
    Wait Until Page Contains    Please enter your credit card’s expiration year.   5s

Empty field validation msgs for Add New Credit Card form - EU
#    Wait Until Page Contains Element    ${myA_card_owner_err_l}    10s
    Wait Until Page Contains    ${myA_card_owner_err}   5s
#    Wait Until Page Contains Element    ${myA_card_number_err_l}    10s
    Wait Until Page Contains    ${myA_card_number_err}   5s
#    Wait Until Page Contains Element    ${myA_card_csv_err_l}    10s
    Wait Until Page Contains    ${myA_card_csv_err}   5s

#    Wait Until Page Contains Element    xpath:(//div[@class='invalid-feedback'])[23]   10s
    Wait Until Page Contains    Please enter your credit card’s expiration month.   5s
#    Wait Until Page Contains Element    xpath:(//div[@class='invalid-feedback'])[23]   10s
    Wait Until Page Contains    Please enter your credit card’s expiration year.   5s

Fill in the Add a New Credit Card form
    [Arguments]    ${name}    ${cc_nr}    ${csv}    ${fn}    ${ln}    ${adr}  ${adr2}  ${city}    ${state}    ${zip}    ${tel}
    ${myaccname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_name_l}    3s
    Run Keyword If    ${myaccname}     Scroll To Element   ${myA_add_card_name_l}
    Run Keyword If    ${myaccname}     CommonWeb.Check and Input text          ${myA_add_card_name_l}    ${name}
    ${myacccardnr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_nr_l}    3s
    Run Keyword If    ${myacccardnr}     Scroll To Element   ${myA_add_card_nr_l}
    Run Keyword If    ${myacccardnr}     CommonWeb.Check and Input text          ${myA_add_card_nr_l}    ${cc_nr}
    ${myacccsv}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_csv_l}    3s
    Run Keyword If    ${myacccsv}     Scroll To Element   ${myA_add_card_csv_l}
    Run Keyword If    ${myacccsv}     CommonWeb.Check and Input text          ${myA_add_card_csv_l}    ${csv}
    ${myaccfname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_fn_l}    3s
    Run Keyword If    ${myaccfname}     Scroll To Element   ${myA_add_card_fn_l}
    Run Keyword If    ${myaccfname}     CommonWeb.Check and Input text          ${myA_add_card_fn_l}    ${fn}
    ${myacclname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_ln_l}    3s
    Run Keyword If    ${myacclname}     Scroll To Element   ${myA_add_card_ln_l}
    Run Keyword If    ${myacclname}     CommonWeb.Check and Input text          ${myA_add_card_ln_l}    ${ln}
    ${myaccaddr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_adr_l}    3s
    Run Keyword If    ${myaccaddr}     Scroll To Element   ${myA_add_card_adr_l}
    Run Keyword If    ${myaccaddr}     CommonWeb.Check and Input text          ${myA_add_card_adr_l}    ${adr}
    ${myaccaddr2}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='address2']    3s
    Run Keyword If    ${myaccaddr2}     Scroll To Element   xpath://input[@id='address2']
    Run Keyword If    ${myaccaddr2}     CommonWeb.Check and Input text          xpath://input[@id='address2']    ${adr2}
    ${myacccity}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_city_l}    3s
    Run Keyword If    ${myacccity}     Scroll To Element   ${myA_add_card_city_l}
    Run Keyword If    ${myacccity}     CommonWeb.Check and Input text          ${myA_add_card_city_l}    ${city}
    ${myaccstate}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_state_l}    5s
    Run Keyword If    ${myaccstate}    Click Element    ${myA_add_card_state_l}
    #Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addPayment']//div[contains(@class, 'selectric-invalid')]//li[contains(.,'${state}')]    #to be uncommented after USSDY-333 is fixed
    Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addPayment']//div[contains(@class, 'selectric-text-entered')]//li[contains(.,'${state}')]
    ${myacczip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_zip_l}    3s
    Run Keyword If    ${myacczip}     Scroll To Element   ${myA_add_card_zip_l}
    Run Keyword If    ${myacczip}     CommonWeb.Check and Input text          ${myA_add_card_zip_l}    ${zip}
    ${myacctel}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_tel_l}    3s
    Run Keyword If    ${myacctel}     Scroll To Element   ${myA_add_card_tel_l}
    Run Keyword If    ${myacctel}     CommonWeb.Check and Input text          ${myA_add_card_tel_l}    ${tel}
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[1]
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[1]//following-sibling::div//li[text()='03']
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[2]
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[2]//following-sibling::div//li[text()='2030']

Check if the new card is present in My Account
    [Arguments]    ${fn}    ${ln}    ${addr}    ${city}    ${zip}    ${phone}
    IF  '${shopLocale}' in ['US','CN']
        Wait Until Page Contains Element    ${myA_new_card_onlyCardDetails}    30s
        Scroll To Element    ${myA_new_card_row_info_l}
#        Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_row_info_l}    ${fn}
#        Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_row_info_l}    ${ln}
#        Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_next_row_l}    ${addr}
#        Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_city_zip_l}    ${city}
#        Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_city_zip_l}    ${zip}
#        Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_first_row_l}    ${phone}
        @{cardInfo}  Create List  ${fn}  ${ln}  ${addr}  ${city}  ${zip}  ${phone}
        Run Keyword And Warn On Failure   Page Should Contain Multiple Texts  @{cardInfo}
    ELSE
        Verify card info
    END

Verify card info
    Wait Until Page Contains Element  ${myA_new_card_onlyCardDetails}  30s
#    Element Should Contain  ${myA_new_card_onlyCardDetails}  **** **** **** 1111
#    Element Should Contain  ${myA_new_card_onlyCardDetails}  Expires: 3/2030
    @{texts}  Create List  **** **** **** 1111  Expires: 3/2030
    Page Should Contain Multiple Texts  @{texts}

Click on Make Default button near first CC and see if setting is applied
    Scroll And Click by JS    ${myA_paym_make_def_l}
    Wait Until Page Contains Element    ${myA_paym_make_def_select_l}    10s
    Wait Until Element Is Visible    ${myA_paym_make_def_select_l}    10s

Click on Remove button near first CC
    Scroll And Click by JS    ${myA_remove_payment_l}
    Wait Until Element Is Visible    ${myA_delete_paym_conf_l}    50s

Click Confirm on the Delete CC modal
    Wait Until Element Is Visible    ${myA_delete_paym_conf_l}    50
    Click Element    ${myA_delete_paym_conf_l}

Check that Credit Card section is empty
    Wait Until Page Does Not Contain Element    xpath://div[@class='payment-instrument-info ']    5s

Access My Account page directly
    Go To    ${UAT_URL}account
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${my_account_page_l}    10s

Click on Order History tab
    Click Element    ${myA_orders_tab_l}
    Wait Until Page Contains Element    ${myA_orders_page_l}    10s

Fill in the Register form
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  P@ssword00
     Check and Input text    ${retype_password_textField_reg}  P@ssword00
     Sleep  2s
     User clicks register button
     Element Should Be Visible  ${my_account_title}

Fill in credit card details and select a saved address
    [Arguments]    ${name}    ${cc_nr}    ${csv}
    Set Focus To Element    ${myA_add_card_name_l}
    sleep  2s
    ${myaccname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_name_l}    3s
    Run Keyword If    ${myaccname}     Scroll To Element   ${myA_add_card_name_l}
    Run Keyword If    ${myaccname}     CommonWeb.Check and Input text          ${myA_add_card_name_l}    ${name}
    ${myacccardnr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_nr_l}    3s
    Run Keyword If    ${myacccardnr}     Scroll To Element   ${myA_add_card_nr_l}
    Run Keyword If    ${myacccardnr}     CommonWeb.Check and Input text          ${myA_add_card_nr_l}    ${cc_nr}
    ${myacccsv}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_csv_l}    3s
    Run Keyword If    ${myacccsv}     Scroll To Element   ${myA_add_card_csv_l}
    Run Keyword If    ${myacccsv}     CommonWeb.Check and Input text          ${myA_add_card_csv_l}    ${csv}
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[1]
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[1]//following-sibling::div//li[text()='03']
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[2]
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[2]//following-sibling::div//li[text()='2030']
    IF  '${shoplocale}' in ['US','CN']
      Click Element    xpath:(//div[@class='row shipping-address-option']//label[@class='custom-control-label'])[1]
    END

Fill in credit card details and add a new address
    [Arguments]    ${name}    ${cc_nr}    ${csv}    ${fn}    ${ln}    ${adr}  ${adr2}  ${city}    ${state}    ${zip}    ${tel}
    ${myaccname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_name_l}    3s
    Run Keyword If    ${myaccname}     Scroll To Element   ${myA_add_card_name_l}
    Run Keyword If    ${myaccname}     CommonWeb.Check and Input text          ${myA_add_card_name_l}    ${name}
    ${myacccardnr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_nr_l}    3s
    Run Keyword If    ${myacccardnr}     Scroll To Element   ${myA_add_card_nr_l}
    Run Keyword If    ${myacccardnr}     CommonWeb.Check and Input text          ${myA_add_card_nr_l}    ${cc_nr}
    ${myacccsv}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_csv_l}    3s
    Run Keyword If    ${myacccsv}     Scroll To Element   ${myA_add_card_csv_l}
    Run Keyword If    ${myacccsv}     CommonWeb.Check and Input text          ${myA_add_card_csv_l}    ${csv}
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[1]
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[1]//following-sibling::div//li[text()='03']
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[2]
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[2]//following-sibling::div//li[text()='2030']
    Click Element    xpath:(//div[@class='row shipping-address-option']//label[@class='custom-control-label'])[2]
    ${myaccfname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_fn_l}    3s
    Run Keyword If    ${myaccfname}     Scroll To Element   ${myA_add_card_fn_l}
    Run Keyword If    ${myaccfname}     CommonWeb.Check and Input text          ${myA_add_card_fn_l}    ${fn}
    ${myacclname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_ln_l}    3s
    Run Keyword If    ${myacclname}     Scroll To Element   ${myA_add_card_ln_l}
    Run Keyword If    ${myacclname}     CommonWeb.Check and Input text          ${myA_add_card_ln_l}    ${ln}
    ${myaccaddr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_adr_l}    3s
    Run Keyword If    ${myaccaddr}     Scroll To Element   ${myA_add_card_adr_l}
    Run Keyword If    ${myaccaddr}     CommonWeb.Check and Input text          ${myA_add_card_adr_l}    ${adr}
    ${myaccaddr2}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='address2']    3s
    Run Keyword If    ${myaccaddr2}     Scroll To Element   xpath://input[@id='address2']
    Run Keyword If    ${myaccaddr2}     CommonWeb.Check and Input text          xpath://input[@id='address2']    ${adr2}
    ${myacccity}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_city_l}    3s
    Run Keyword If    ${myacccity}     Scroll To Element   ${myA_add_card_city_l}
    Run Keyword If    ${myacccity}     CommonWeb.Check and Input text          ${myA_add_card_city_l}    ${city}
    ${myaccstate}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_state_l}    5s
    Run Keyword If    ${myaccstate}    Click Element    ${myA_add_card_state_l}
    #Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addPayment']//div[contains(@class, 'selectric-invalid')]//li[contains(.,'${state}')]    #to be uncommented after USSDY-333 is fixed
    Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addPayment']//div[contains(@class, 'selectric-text-entered')]//li[contains(.,'${state}')]
    ${myacczip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_zip_l}    3s
    Run Keyword If    ${myacczip}     Scroll To Element   ${myA_add_card_zip_l}
    Run Keyword If    ${myacczip}     CommonWeb.Check and Input text          ${myA_add_card_zip_l}    ${zip}
    ${myacctel}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_tel_l}    3s
    Run Keyword If    ${myacctel}     Scroll To Element   ${myA_add_card_tel_l}
    Run Keyword If    ${myacctel}     CommonWeb.Check and Input text          ${myA_add_card_tel_l}    ${tel}

Fill in credit card details for EU
    [Arguments]    ${name}    ${cc_nr}    ${csv}
    Click on Add a New Credit Card button
    ${myaccname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_name_l}    3s
    Run Keyword If    ${myaccname}     Scroll To Element   ${myA_add_card_name_l}
    Run Keyword If    ${myaccname}     CommonWeb.Check and Input text          ${myA_add_card_name_l}    ${name}
    ${myacccardnr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_nr_l}    3s
    Run Keyword If    ${myacccardnr}     Scroll To Element   ${myA_add_card_nr_l}
    Run Keyword If    ${myacccardnr}     CommonWeb.Check and Input text          ${myA_add_card_nr_l}    ${cc_nr}
    ${myacccsv}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_csv_l}    3s
    Run Keyword If    ${myacccsv}     Scroll To Element   ${myA_add_card_csv_l}
    Run Keyword If    ${myacccsv}     CommonWeb.Check and Input text          ${myA_add_card_csv_l}    ${csv}
    Sleep   2s
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[1]
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[1]//following-sibling::div//li[text()='03']
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[2]
    Click Element    xpath:(//div[@class='row card-details']//div[@class='selectric'])[2]//following-sibling::div//li[text()='2030']

Fill in credit card details in payments page - visa
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Set Focus To Element  //*[@data-title='Visa']
    sleep  2s
    Click by JS    //*[@data-title='Visa']
    sleep  5s
    Select Frame    id=secureWindow
    Set Focus To Element  ${cardNumber_field}
    Check and Input text    ${cardNumber_field}    ${visa_number}
    Select From List By Label    ${cardexpiry_MonthSelect}  03
    Select From List By Label    ${cardexpiry_yearSelect}  2030
    Check and Input text    ${card_cvv}    ${csv}
    Unselect Frame

User should not be able to save future date for birthday
    log  CCMS-6470
    ${date}  Generate a future date
    Change Birthday in Personal Information  ${date}
    Click Element    ${save_personal_info_button}
    Wait Until Page Contains  Please enter a valid date  10s
    Clear Element Text    ${birthday_personal_info_locator}
    Wait Until Page Does Not Contain  Please enter a valid date  10s

User should not be able to save future date for anniversary
    log  CCMS-6470
    ${date}  Generate a future date
    Change Anniversary in Personal Information  ${date}
    Click Element    ${save_personal_info_button}
    Wait Until Page Contains  Please enter a valid date  10s
    Clear Element Text    ${anniversary_personal_info_locator}
    Wait Until Page Does Not Contain  Please enter a valid date  10s

##
Go to email preferences page
    Go to Accounts    Overview
    Check and Click    ${EmailPref_tab}
    Close the Get the First Look modal
    Select Frame  ${EmailPrefFrame}
    Scroll Element Into View    ${EmailPref_Title}

Verify expected elements in Email preferences page
    @{elements}  Create List  ${EmailPref_Title}  ${EmailPref_currentStatus}  ${EmailPref_countrySelect}  ${EmailPref_langSelect}
    ...  ${EmailPref_allUpdatesRadio}  ${EmailPref_emailPromoRadio}   ${EmailPref_BAradio}   ${EmailPref_unsubAllRadio}
    Wait Until Page Contains Multiple Elements  @{elements}

    @{texts}  Create List  ${EmailPref_updatePrefDescription}
    Page Should Contain Multiple Texts  @{texts}

    Element Should Contain  ${EmailPref_emailPromoRadio}  Receive emails, promotions, and special offers from David Yurman.
    Element Should Contain  ${EmailPref_BAradio}  Receive communications from my local store Brand Ambassador.

Verify country selector dropdown
    Select From List By Label  ${EmailPref_countrySelect}  Canada
    Element Should Contain    ${EmailPref_countrySelect}    Canada

    Select From List By Label  ${EmailPref_countrySelect}  USA
    Element Should Contain    ${EmailPref_countrySelect}    USA


Select Unsibscribe from all updates and save
    Center Element on Screen     ${EmailPref_unsubAllRadio}
    Set Focus To Element    ${EmailPref_unsubAllRadio}
    Click by JS  ${EmailPref_unsubAllRadio}
#    Wait Until Element Is Visible    ${EmailPref_unsubAllRadio}/preceding-sibling::input[contains(@checked,'checked')]  2s
    Click by JS    ${EmailPref_saveBtn}
    Verify success message after saving email preference

Verify email promotions and BA radios should be disabled
    Center Element on Screen    ${EmailPref_emailPromoRadio}
    Set Focus To Element    ${EmailPref_emailPromoRadio}
    Element Should Be Disabled   id=Optin_Marketing
    Element Should Be Disabled    id=Optin_BA

Status Should Be
    [Arguments]  ${status}
    Element Should Contain    ${EmailPref_currentStatus}    ${status}

Select Receive all updates and save
    Click by JS  ${EmailPref_allUpdatesRadio}
    Click by JS    ${EmailPref_saveBtn}
    Verify success message after saving email preference

Select Only Email Promotions and save
    Click by JS  ${EmailPref_emailPromoRadio}
    Click by JS    ${EmailPref_saveBtn}
    Verify success message after saving email preference

Select Only Brand Ambassador Updates and save
    Click by JS  ${EmailPref_BAradio}
    Click by JS    ${EmailPref_saveBtn}
    Verify success message after saving email preference

Verify all radio buttons should be enabled
    Center Element on Screen    ${EmailPref_emailPromoRadio}
    Set Focus To Element    ${EmailPref_emailPromoRadio}
    Element Should Be Enabled    ${EmailPref_allUpdatesRadio}
    Element Should Be Enabled    ${EmailPref_emailPromoRadio}
    Element Should Be Enabled    ${EmailPref_BAradio}
    Element Should Be Enabled    ${EmailPref_unsubAllRadio}

Back to email preference
    Unselect Frame
    Select Frame    //iframe[contains(@src,'configure')]
    Mouse Click    ${EmailPref_backBtn}
#    sleep  5s
#    Select Frame    ${EmailPrefFrame}

Verify success message after saving email preference
    Wait Until Page Contains  ${EmailPref_updateSuccessMsg}  20s
    Wait Until Element Is Visible    ${EmailPref_exploreDyBtn}  5s

