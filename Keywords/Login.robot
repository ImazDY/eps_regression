*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/DataReader.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/MyAccount.robot

*** Keywords ***
Click on Sign In
    Click Element    ${sign_in_icon}
    Wait Until Element Is Visible    ${login_heading}           30      Login Page is not Loaded


Click on Register User
    Click Element    ${register_login_button}
    Wait Until Element Is Visible    ${register_box}           30       Register Pager is not Loaded
        

Click on Register
    Click on Register Button
    Wait Until Element Is Visible     ${account_container}      30       Account Page is not Loaded 

Click on Login button
    Click Element    ${login_button}

Click on Login
    Wait Until Element Is Visible    ${login_button}
    Click Element    ${login_button}
    Wait Until Element Is Visible     ${account_container}      30      Account Page is not Loaded


Fill in Login Form
    [Arguments]    ${username}    ${password}
    Input Text    ${login_username_field}    ${username}
    Input Text    ${login_password_field}    ${password}


Click on Register Button
    Sleep  3s
    Scroll Element Into View    ${register_create_account_button}
    Click Element       ${register_create_account_button}


Check Created User fields
    [Arguments]     ${firstname}    ${lastname}     ${email}
    ${logged_user_firstname_text}=    Get Element Attribute    ${logged_user_firstname_field}   value
    ${logged_user_lastname_text}=     Get Element Attribute    ${logged_user_lastname_field}    value
    
    Should Be Equal As Strings          ${logged_user_firstname_text}             ${firstname}
    Should Be Equal As Strings          ${logged_user_lastname_text}              ${lastname}
    Check Email in Account Page         ${email}


Check Email in Account Page
    [Arguments]     ${email}
    ${logged_user_email_text}=        Get Text    ${logged_user_email_field}
    Should Contain                      ${logged_user_email_text}                 ${email}


Clear all fields
    Clear Element Text    ${register_firstname_field}
    Clear Element Text    ${register_lastname_field}
    Clear Element Text    ${register_email_field}
    Clear Element Text    ${register_confirm_email_field}
    Clear Element Text     ${register_password_field}
    Clear Element Text     ${register_confirm_password_field}

Check Password Error on Personal Info
    [Arguments]         ${email_personal_info}  ${actual_password}
    ${validation_dict}    Create Dictionary
    ...    ${short_password}                                            ${password_check_personal_info_chars}
    ...    ${uppercase_invalid_password}                                ${password_check_personal_info_uppercase}
    ...    ${lowercase_invalid_password}                                ${password_check_personal_info_lowercase}
    ...    ${lowercase_invalid_password}                                ${password_check_personal_info_number}
    ...    ${with_space_invalid_password}                               ${password_check_personal_info_space}
    ...    ${email_personal_info}                                       ${password_check_personal_info_email}
    ...    ${lowercase_invalid_password}                                ${password_check_personal_info_specialchar}

    Click Element   ${change_pass_link}
    Wait Until Element Is Visible    ${current_password_locator}    30    Change Password Container is not displayed
    Input Text      ${current_password_locator}    ${actual_password}

    FOR    ${wrong_password}    IN    @{validation_dict.keys()}
        ${locator}=    Get From Dictionary    ${validation_dict}    ${wrong_password}
        Element Should Not Be Visible    ${locator} .checked
    END

Fill Password Fields
    [Arguments]     ${password}=${valid_password}           ${confirm_password}=${valid_password}
    Input Text      ${register_password_field}              ${password}
    Input Text      ${register_confirm_password_field}      ${confirm_password}


Fill Full Name
    [Arguments]     ${firstname}=${FIRST_NAME}    ${lastname}=${LAST_NAME}
    Input Text      ${register_firstname_field}             ${firstname}
    Input Text      ${register_lastname_field}              ${lastname}


Check error message
    [Arguments]     ${error_locator}    ${expected_error_message}   ${warn}=Warning
    ${error_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${error_locator}
    IF    ${error_visible}
        ${errorMessage}    CommonWeb.Check and Get text    ${error_locator}
        Run Keyword And Warn On Failure    Should Be Equal As Strings    ${errorMessage}    ${expected_error_message}   ${warn}
    END


Check Field Error
    [Arguments]     ${email_field}      ${email_txt}    ${error_field}      ${expected_err}     ${warn}
    Input Text      ${email_field}      ${email_txt} 
    Click on Register Button
    Check error message     ${error_field}        ${expected_err}     ${warn}

Change Password
    [Arguments]     ${actual_password}    ${new_password}
    Click Element   ${change_pass_link}
    Wait Until Element Is Visible    ${current_password_locator}    30    Change Password Container is not displayed
    Input Text      ${current_password_locator}    ${actual_password}
    Input Text      ${new_password_locator}        ${new_password}
    Input Text      ${confirm_password_locator}    ${new_password}
    Click Element   ${submit_button}
    Wait Until Element Is Not Visible    ${current_password_locator}    30    Change Password Container is not displayed

Change Email
    [Arguments]     ${new_email}    ${password}
    Click Element   ${change_email_link}
    Wait Until Element Is Visible    ${new_email_locator}    30    Change Email Container is not displayed
    Input Text      ${new_email_locator}    ${new_email}
    Input Text      ${password_locator}    ${password}
    Click Element   ${save_email_button}
    Wait Until Element Is Not Visible    ${new_email_locator}    30    Change Email Container is not displayed

Logout
    Reload Page
    Wait Until Element Is Visible       ${header_icon_account}  10s
    Mouse Over                          ${header_icon_account}
    Wait until Element Is Visible       ${logout_link}    5s    Logout button is not displayed
    Click Element                       ${logout_link}

Check Invalid Login banner
    Wait until Element Is Visible    ${login_error_message}    30    Login error message is not displayed
    Check error message    ${login_error_message}    ${invalid_login_error_message}


Change Name in Personal Information
    [Arguments]    ${first_name}=     ${last_name}= 
    Input Text    ${first_name_personal_info_locator}    ${first_name}
    Input Text    ${last_name_personal_info_locator}    ${last_name}

Clear Name in Personal Information
    Clear Element Text    ${first_name_personal_info_locator}
    Clear Element Text    ${last_name_personal_info_locator}

Change Birthday in Personal Information
    [Arguments]    ${birthday}
    Input Text    ${birthday_personal_info_locator}    ${birthday}

Change Anniversary in Personal Information
    [Arguments]    ${anniversary}
    Input Text    ${anniversary_personal_info_locator}    ${anniversary}

Save Personal Information
    [Arguments]     ${first_name}
    Click Element    ${save_personal_info_button}
    Wait Until Element Contains    ${page_title_personal_info}    ${first_name}    timeout=30s

Save Personal Information with no arguments
    Click Element    ${save_personal_info_button}

Check Personal Information
    [Arguments]    ${first_name}    ${last_name}    ${birthday}    ${anniversary}
    ${actual_first_name}=                   Get text from form              ${first_name_personal_info_locator}
    ${actual_last_name}=                    Get text from form              ${last_name_personal_info_locator}
    ${actual_birthday}=                     Get text from form              ${birthday_personal_info_locator}
    ${actual_anniversary}=                  Get text from form              ${anniversary_personal_info_locator}
    Run Keyword And Warn On Failure         Should Be Equal As Strings      ${actual_first_name}      ${first_name}
    Run Keyword And Warn On Failure         Should Be Equal As Strings      ${actual_last_name}       ${last_name}
    Run Keyword And Warn On Failure         Should Be Equal As Strings      ${actual_birthday}        ${birthday}
    Run Keyword And Warn On Failure         Should Be Equal As Strings      ${actual_anniversary}     ${anniversary}

Get text from form
    [Arguments]     ${locator}
    ${text}=  Get Element Attribute    ${locator}   value
    RETURN    ${text}


Get Visible Invalid Feedback Elements
    ${elements}=    Get WebElements    ${invalid_feedback}
    ${visible_elements}=    Create List
    FOR    ${element}    IN    @{elements}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
        IF    ${is_visible}
            Append To List    ${visible_elements}    ${element}
        END
    END
    RETURN    ${visible_elements}


Check if Invalid Feedback is displayed
    ${visible_elements}=    Get Visible Invalid Feedback Elements
    Run Keyword And Warn On Failure    Should Be Equal As Integers    ${visible_elements.__len__()}    4    There are not exactly 4 visible invalid feedback elements

Check whether all elements are dislpayed in register section
     Wait Until Element Is Visible      ${registered_customer_subHeading}
     Element Text Should Be    ${faster_check_out}    ${faster_check_out_message}
     Element Text Should Be    ${access_order}    ${access_order_message}
     Element Text Should Be    ${view_online}    ${view_online_message}
     Element Text Should Be    ${add_items}    ${add_items_message}
     Wait Until Element Is Visible      ${register_button}

Check user navigates to registration page on clicking register button
     Click Element  ${register_button}
     Wait Until Element Is Visible    ${new_customer_heading}    5s    error=new customer page title is not seen

Check whether all elements are dislpayed in registration page
      Element Should Be Visible  ${first_name_textField_reg}
      ${first_name_label}  Get Text    xpath://label[@for='registration-form-fname']
      Should Contain Text      ${first_name_label}    First Name
      Element Should Be Visible  ${last_name_textField_reg}
      ${last_name_label}  Get Text    xpath://label[@for='registration-form-lname']
      Should Contain Text      ${last_name_label}   Last Name
      Element Should Be Visible  ${email_textField_reg}
      ${email_label}  Get Text    xpath://label[@for='registration-form-email']
      Should Contain Text     ${email_label}    Email
      Element Should Be Visible  ${retype_email_textField_reg}
      ${retype_email_label}  Get Text     xpath://label[@for='registration-form-email-confirm']
      Should Contain Text     ${retype_email_label}    Retype Email Address
      Element Should Be Visible  ${password_textField_reg}
      ${password_label}  Get Text     xpath://label[@for='registration-form-password']
      Should Contain Text     ${password_label}    Password
      Element Should Be Visible  ${retype_password_textField_reg}
      ${retype_password_label}  Get Text     xpath://label[@for='registration-form-password-confirm']
      Should Contain Text     ${retype_password_label}     Retype Password

Check privary policy link in registration page
   Scroll Element Into View    xpath://a[text()='Privacy Policy'][1]
   Click Element    xpath://a[text()='Privacy Policy'][1]
   @{window_handles}=    Get Window Handles
   Switch Window    ${window_handles}[1]
   Location Should Contain    /assistance/online-privacy-notice.html
   Close Window
   Switch Window    ${window_handles}[0]

Check whether registration is possible with valid details
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField_reg}  ${NewUser_Pwd}
     Sleep  2s
     Element Should Be Visible  ${minimum_length_requirement_checked}
     Element Should Be Visible  ${capital_lowercase_requirement_checked}
     Element Should Be Visible  ${no_spaces_requirement_checked}
     Element Should Be Visible  ${no_email_requirement_checked}
     Element Should Be Visible  ${one_number_requirement_checked}
     Element Should Be Visible  ${special_character_requirement_checked}
     User clicks register button
     Element Should Be Visible  ${my_account_title}

Clear all fields on registration form
     Scroll Element Into View    ${new_customer_heading}
#     Click Element   ${first_name_textField_reg}
#     Press Keys    ${first_name_textField_reg}  CONTROL+A  DELETE
#     Click Element   ${last_name_textField_reg}
#     Press Keys    ${last_name_textField_reg}  CONTROL+A  DELETE
#     Click Element   ${email_textField_reg}
#     Press Keys    ${email_textField_reg}  CONTROL+A  DELETE
#     Click Element   ${retype_email_textField_reg}
#     Press Keys    ${retype_email_textField_reg}  CONTROL+A  DELETE
#     Click Element   ${password_textField_reg}
#     Press Keys    ${password_textField_reg}   CONTROL+A  DELETE
#     Click Element   ${retype_password_textField_reg}
#     Press Keys    ${retype_password_textField_reg}   CONTROL+A  DELETE
     Clear Element Text    ${first_name_textField_reg}
     Clear Element Text    ${last_name_textField_reg}
     Clear Element Text    ${email_textField_reg}
     Clear Element Text    ${retype_email_textField_reg}
     Clear Element Text    ${password_textField_reg}
     Clear Element Text    ${retype_password_textField_reg}

User clicks register button
    Scroll Element Into View    ${register_button_regPage}
    Scroll And Click by JS    ${register_button_regPage}

User clicks password requirement button
    Click Element    ${password_requirements_button}

User clicks add to email button
    Click Element   ${add_to_email}

Check whether all elements are displayed in customer registration page
     log  CCMS-6550
     Wait Until Element Is Visible    ${first_name_textField}
     Wait Until Element Is Visible    ${last_name_textField}
     Wait Until Element Is Visible    ${email_textField}
     Wait Until Element Is Visible    ${retype_email_textField}
     Wait Until Element Is Visible    ${password_textField}
     Wait Until Element Is Visible    ${retype_password_textField}
     Wait Until Element Is Visible    ${retype_password_textField}
     Run Keyword And Warn On Failure  Element Text Should Be  ${first_name_placeHolder}  ${first_name_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${last_name_placeHolder}  ${last_name_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${email_placeHolder}  ${email_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_email_placeHolder}  ${retype_email_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_placeHolder}  ${password_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_password_placeHolder}  ${retype_password_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_1}  ${password_requirement_1_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_2}  ${password_requirement_2_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_3}  ${password_requirement_3_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_4}  ${password_requirement_4_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_5}  ${password_requirement_5_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_6}  ${password_requirement_6_value}
     Wait Until Element Is Visible    ${add_to_email}
     Run Keyword And Warn On Failure  Element Text Should Be  ${add_to_email}  ${add_to_emailValue}

Check whether registration is possible with blank mandatory values
     Clear all fields on registration form
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${first_name_validation}  ${first_name_validation_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${last_name_validation}  ${last_name_validation_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${email_validation}  ${email_validation_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_email_validation}  ${retype_email_validation_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_validation}  ${password_validation_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_password_validation}  ${retype_password_validation_value}


Check whether registration is possible with blank first name value
     Clear all fields on registration form
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${first_name_validation}  ${first_name_validation_value}

Check whether registration is possible with blank last name value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${last_name_validation}  ${last_name_validation_value}

Check whether registration is possible with blank email value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${email_validation}  ${email_validation_value}

Check whether registration is possible with blank retype email value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_email_validation}  ${retype_email_validation_value}

Check whether registration is possible with blank password value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_validation}  ${password_validation_value}

Check whether registration is possible with blank retype password value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Check and Input text    ${email_textField}        ${GUEST_email}
     Check and Input text    ${retype_email_textField}  ${GUEST_email}
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_password_validation}  ${retype_password_validation_value}

Check whether registration is possible with invalid email value
     @{invalid_values}  Create List   @#@$#@$@#$#@   io.com   io@ji
     ${length} =  Get Length    ${invalid_values}
     FOR    ${invalid_values}    IN RANGE    0    ${length}
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Check and Input text    ${email_textField}        ${invalid_values}
     Generate Timestamp Email
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${email_validation}  ${email_validation_value}
     END

Check whether registration is possible with invalid retype email value
     @{invalid_values}  Create List    @#@$#@$@#$#@   io.com   io@ji
     ${length} =  Get Length    ${invalid_values}
     FOR    ${invalid_values}    IN RANGE    0    ${length}
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  rt$hj
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_email_validation}  ${retype_email_validation_value}
     END

Valid email and invalid retype email
    log  CCMS-6633
    Generate Timestamp Email
    Clear all fields on registration form
    Check and Input text    ${email_textField}        ${guest_valid}
    Check and Input text    ${retype_email_textField}  dirty${guest_valid}
    User clicks register button
    Run Keyword And Warn On Failure  Element Should Contain  ${retype_email_validation}  Please enter the same value again


Check whether registration is possible with already existing email value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${GUEST_email}
     Check and Input text    ${retype_email_textField}  ${GUEST_email}
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Run Keyword And Warn On Failure  Wait Until Page Contains  ${already_existing_user_validation}  5s

Check whether registration is possible with email mismatch
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        john@doe.com
     Check and Input text    ${retype_email_textField}  jon@doe.com
     Check and Input text    ${password_textField}  ${NewUser_Pwd}
     Check and Input text    ${retype_password_textField}  ${NewUser_Pwd}
     User clicks register button
     Wait Until Page Contains Element    ${retype_email_validation}
     Run Keyword And Warn On Failure  Wait Until Page Contains    ${email_mismatch_validation}  5s

Check whether registration is possible with password requirement not satisfied - minimum length
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  123
     Check and Input text    ${retype_password_textField}  123
     User clicks register button
     Wait Until Page Contains Element    ${password_validation}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_validation}  ${password_requirement_minimum_length}
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_password_validation}  ${password_requirement_minimum_length}
     Run Keyword And Warn On Failure  Element Should Be Visible  ${minimum_length_requirement_unchecked}

Check whether registration is possible with password requirement not satisfied - capital and lower case
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  123456
     Check and Input text    ${retype_password_textField}  123456
     Run Keyword And Warn On Failure     Wait Until Page Contains Element  ${capital_lowercase_requirement_unchecked}

Check whether registration is possible with password requirement not satisfied - one number
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  abcdefgh
     Check and Input text    ${retype_password_textField}  abcdefgh
     Run Keyword And Warn On Failure   Wait Until Page Contains Element  ${one_number_requirement_unchecked}

Check whether registration is possible with password requirement not satisfied - no space
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  abcd efgh
     Check and Input text    ${retype_password_textField}  abcd efgh
     Run Keyword And Warn On Failure   Wait Until Page Contains Element  ${no_spaces_requirement_unchecked}

Check whether registration is possible with password requirement not satisfied - no special character
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  abcdefgh
     Check and Input text    ${retype_password_textField}  abcdefgh
     Run Keyword And Warn On Failure   Wait Until Page Contains Element  ${special_character_requirement_unchecked}

Check whether registration is possible with valid details and signup
     Clear all fields on registration form
     Check and Input text    ${first_name_textField}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField}        ${guest_valid}
     Check and Input text    ${retype_email_textField}  ${guest_valid}
     Check and Input text    ${password_textField}  P@ssword00
     Check and Input text    ${retype_password_textField}  P@ssword00
     Run Keyword And Warn On Failure  Element Should Be Visible  ${minimum_length_requirement_checked}
     Run Keyword And Warn On Failure  Element Should Be Visible  ${capital_lowercase_requirement_checked}
     Run Keyword And Warn On Failure  Element Should Be Visible  ${no_spaces_requirement_checked}
     Run Keyword And Warn On Failure  Element Should Be Visible  ${no_email_requirement_checked}
     Run Keyword And Warn On Failure  Element Should Be Visible  ${one_number_requirement_checked}
     Run Keyword And Warn On Failure  Element Should Be Visible  ${special_character_requirement_checked}
     Scroll And Click by JS   css:#add-to-email-list
     User clicks register button
     Run Keyword And Warn On Failure  Element Should Be Visible  ${my_account_title}

Fill in Register Form
    [Arguments]     ${firstname}    ${lastname}     ${email}    ${password}
    Fill Full Name              ${firstname}    ${lastname}
    Fill Email fields           ${email}        ${email}
    Fill Password Fields        ${password}     ${password}

Fill Email fields
    [Arguments]     ${email}=${GUEST_email}    ${confirm_email}=${GUEST_email}
    Input Text      ${register_email_field}                 ${email}
    Input Text      ${register_confirm_email_field}         ${confirm_email}
    
    
Check validation message for first name and last name field
    Wait Until Page Contains Element    //label[@for='firstName']//following-sibling::div
    Run Keyword And Warn On Failure  Wait Until Page Contains   This field is required.  5s
    Run Keyword And Warn On Failure  Wait Until Page Contains   This field is required.  5s


Check Empty Fields Message on Create Account Form
    ${register_dict_err}=   Create Dictionary
    ...    ${register_firstname_err}            ${register_empty_first_name_err}
    ...    ${register_lastname_err}             ${register_empty_last_name_err}
    ...    ${register_email_err}                ${register_invalid_email_err}
    ...    ${register_confirm_email_err}        ${register_invalid_email_err}
    ...    ${register_password_err}             ${register_empty_pwd_err}
    ...    ${register_confirm_password_err}     ${register_empty_pwd_err}

    FOR    ${key}    IN    @{register_dict_err.keys()}
        ${expectedErr}=    Get From Dictionary    ${register_dict_err}    ${key}
        Check error message    ${key}    ${expectedErr}
    END


Register a user and add details
   Check if Login is accessible from header
   Check user navigates to registration page on clicking register button
   Close the Get the First Look modal
   Check whether registration is possible with valid details
   Check that the user is successfully logged in and redirected to Account Details page    ${guest_valid}
   Click on Add a New Address button
   Fill in the Add a New Address form    ${FIRST_NAME}   ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_State}    ${NewUser_Zipcode}  ${NewUser_Phone}
   Click on Save button from Add a New Address form
  IF   '${shopLocale}' in ['US','CN']
   Check if the new address is present in My Account    ${FIRST_NAME}   ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}   ${NewUser_Zipcode}  ${NewUser_Phone}
   Click on Add a New Credit Card button
   Fill in credit card details and select a saved address    ${FIRST_NAME}   ${NewUser_CardNumber}    ${NewUser_CardCvv}
   Click on Save button from Add a New Credit Card form
   Check if the new card is present in My Account    ${FIRST_NAME}    ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_City}  ${NewUser_Zipcode}  ${NewUser_Phone}
   Click on Make Default button near first CC and see if setting is applied
  ELSE
   Fill in credit card details for EU    ${FIRST_NAME}   ${NewUser_CardNumber}    ${NewUser_CardCvv}
   Click on Save button from Add a New Credit Card form
   Click on Make Default button near first CC and see if setting is applied
  END

Logout and log back in
    Logout
    Click on Sign In
    Fill in Login Form  ${Eps_login_email}  ${Eps_login_password}
    Click on Login



Logout and log back in - Affirm
    Logout
    Click on Sign In
    Fill in Login Form  ${REG_affirm_account}  ${REG_affirm_pwd}
    Click on Login