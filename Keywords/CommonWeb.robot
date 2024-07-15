*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot  screenshot_root_directory=EMBED
Library           Collections
Library           OperatingSystem
Library           XML
Library           DateTime
Library           String
Library           OperatingSystem
Library           JSONLibrary
Library           RequestsLibrary

Resource          ../Resources/Variables.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/LamdaTestSetup.robot

*** Keywords ***
Open website
    Set Test Variable    ${run_on_LT}    ${run_on_LT}
    Set Test Variable    ${product}      DY
    Set Test Variable    ${device}       ${device}
    Set Test Variable    ${product_added}    0
    Set Test Variable    ${available}    Not define
    Set Test Variable    ${shopLocale}   ${shopLocale}
    Set Library Search Order    SeleniumLibrary
    Set Test Variable    ${URL}    ${EPS_URL}
    Run Keyword If    '${run_on_LT}' == 'yes'   Open Lamda Test browser
    Run Keyword If    '${run_on_LT}' == 'no'    Open Browser    ${EPS_URL}    ${device}    options=add_argument("--ignore-certificate-errors")
    Set Selenium Implicit Wait    10 second
    Maximize Browser Window
    Accept Cookies


Accept Cookies
    Run Keyword And Warn On Failure    Wait until page contains element    ${cookies_accept}    timeout=20s
    Run Keyword And Warn On Failure    Wait until element is visible    ${cookies_accept}    timeout=20s
    sleep  5s
#    Run Keyword And Warn On Failure    Wait until element is visible    ${cookies_accept}    timeout=15s
    Run Keyword If    not ${cookies_closed}    Run Keyword    No Operation
        ${cookies_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${cookies_accept}    timeout=3s
        Run Keyword If    ${cookies_true}     Click by JS          ${cookies_accept}
        #Run Keyword If    ${cookies_true}     execute javascript    document.getElementsByClassName('privacy_prompt')[0].style.display='none';utag.gdpr.consent_prompt
        Set Global Variable    ${cookies_closed}    ${True}

Accept cookies until closed
    FOR  ${i}  IN RANGE  1  5
       Click by JS          ${cookies_accept}
       ${cookies_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${cookies_accept}

Launch Eps and Login
    Run Keyword If    '${run_on_LT}' == 'yes'   Open Lamda Test browser
    Run Keyword If    '${run_on_LT}' == 'no'    Open Browser    ${EPS_URL}    ${device}    options=add_argument("--ignore-certificate-errors")
    Set Selenium Implicit Wait    10 second
    Maximize Browser Window
    Set Window Size  1440  900
    Accept Cookies
    Log into EPS

Log into EPS
    Check and Input text    ${Eps_login_emailField}    ${Eps_login_email}
    Check and Input text    ${Eps_login_passField}    ${Eps_login_password}
    Check and Click    ${Eps_loginBtn}
    sleep  15s

Scroll To Element
    [Arguments]    ${locator}
    ${x}=    Get Horizontal Position    ${locator}
    ${y}=    Get Vertical Position    ${locator}
    Execute Javascript    window.scrollTo(${x}, ${y})

Scroll And Click
    [Arguments]    ${locator}
    Scroll To Element    ${locator}
    Check and click    ${locator}

Center Element on Screen
    [Arguments]    ${locator}   ${y_shift}=-200
    ${x}=    Get Horizontal Position    ${locator}
    ${y}=    Get Vertical Position    ${locator}
    ${adjusted_y}=    Evaluate    ${y} + ${y_shift}
    Execute Javascript    window.scrollTo(${x}, ${adjusted_y})

Generate Timestamp Email
    ${date}=    Get Current Date    result_format=timestamp
    ${time_stamp}=    Evaluate    '${date}'.replace(' ','').replace('-','').replace('.','').replace(':','')
    Set Test Variable    ${guest_valid}    testing_tm${time_stamp}_uat@mailsac.com

Scroll To Top
    Execute Javascript    window.scrollTo(0, 0)

Scroll To Bottom
    Execute Javascript    document.documentElement.scrollTop = document.documentElement.scrollHeight;

Scroll And Click by JS
    [Arguments]    ${locator}
    Scroll To Element    ${locator}
    ${element}    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Click by JS
    [Arguments]    ${locator}
    ${element}    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Check and Input text
    [Arguments]    ${locator}    ${text}    ${field}=Not define
    Wait Until Page Contains Element    ${locator}    timeout=10s    error=*Text field '${field}' is not displayed or unknow in DOM | *Locator :* ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10s    error=Text field '${field}' is not visible | *Locator :* ${locator}
    Input Text    ${locator}    ${text}
    Set Test Variable    ${text}    ${text}

Check and Get text
    [Arguments]    ${locator}    ${field}=Not defined
    Wait Until Page Contains Element    ${locator}    timeout=5s    error=Element '${field}' is not displayed or unknow in DOM | *Locator :* ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=5s    error=Element '${field}' is not visible | *Locator :* ${locator}
    Set Test Variable    ${var}    Not defined
    ${var}=    Get Text    ${locator}
    [Teardown]
    RETURN    ${var}

Check and Click
    [Arguments]    ${locator}    ${field}=Not defined
    Wait Until Page Contains Element    ${locator}    timeout=5s    error=Element '${field}' is not displayed or unknow in DOM | *Locator :* ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=20s    error=Element '${field}' is not visible | *Locator :* ${locator}
    Click Element    ${locator}

Click Using Javascript
    [Arguments]    ${locator}
    Execute Javascript    document.querySelector('${locator}').click()

Close the Get the First Look modal
    Run Keyword And Ignore Error  Wait Until Page Contains  Get the First Look    timeout=5s
    Run Keyword And Ignore Error  Wait Until Element Is Visible    ${gtfl}    timeout=5s
    Run Keyword And Ignore Error  Wait Until Page Contains  Get the First Look    timeout=5s
    Run Keyword And Ignore Error  Wait Until Element Is Visible    ${gtfl}    timeout=5s
    Run Keyword And Ignore Error  Wait Until Page Contains  Get the First Look    timeout=5s
    Run Keyword And Ignore Error  Wait Until Element Is Visible    ${gtfl}    timeout=5s
    Sleep  10s
    IF    "${GTFL_already_closed}" == "false"
        ${GTFL_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${gtfl}    timeout=20s
        Run Keyword If    ${GTFL_true}     CommonWeb.Check and Click          ${gtfl_close}
        Set Test Variable    ${GTFL_already_closed}    true
    END
    Sleep  2s


Should Be Greater Than
    [Arguments]    ${value}    ${threshold}
    Run Keyword If    ${value} <= ${threshold}    Fail    Value ${value} is not greater than ${threshold}

Get List Items From UL
    [Arguments]    ${ul_locator}
    ${li_elements}    Get WebElements    //*[text()='Available Services']/following-sibling::ul/li
    RETURN    ${li_elements}

Compare Lists
    [Arguments]    ${expected_list}    ${actual_list}
    FOR    ${expected_item}    IN    @{expected_list}
        Run Keyword If    '${expected_item}' not in ${actual_list}    Log    "Element '${expected_item}' not found in actual list"    WARN
    END

Convert WebElements to Strings
    [Arguments]    ${web_elements}
    ${string_list}    Create List
    FOR    ${element}    IN    @{web_elements}
        ${text}    Get Text    ${element}
        Append To List    ${string_list}    ${text}
    END
    RETURN    ${string_list}

Get Table Lines
    [Arguments]    ${table_locator}
    ${tbody_locator}    Set Variable    ${table_locator}//tbody
    ${line_locator}     Set Variable    ${tbody_locator}//tr
    ${lines}    Get WebElements    ${line_locator}
    RETURN    ${lines}

Check Substrings in List of String
    [Arguments]    ${list_of_strings}    ${list_of_substrings}
    ${concatenated_string}      Catenate        ${list_of_strings}
    ${result}                   Set Variable                     ${True}
    FOR    ${substring}    IN    @{list_of_substrings}
        ${contains_substring}    Run Keyword And Return Status    Should Contain    ${concatenated_string}    ${substring}
        Run Keyword If    not ${contains_substring}     Set Variable        ${result}       ${False}
    END
    Run Keyword And Warn On Failure      Should Be True    ${result}


Should Contain Text
    [Arguments]     ${actual_text}    ${expected_text}
    Run Keyword And Warn On Failure    Should Contain    ${actual_text}    ${expected_text}

Set location from ui
   IF  '${shopLocale}' in ['US']
    Run Keyword And Warn On Failure    Location Should Contain    uat.davidyurman.com
   ELSE IF  '${shopLocale}' in ['UK']
    Wait Until Element Is Visible    ${choose_country_button}
    Sleep  5s
    Scroll And Click by JS      ${choose_country_button}
    Wait Until Page Contains Element    ${choose_country_dropdown}
    Click Element    ${choose_country_dropdown}
    Click Element  xpath:(//div[@class='selectric-scroll'])[2]/ul/li[contains(text(),'United Kingdom')]
    Click by JS     xpath://button[@id='js-choosecountry-submit']
    Run Keyword And Warn On Failure  Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=20s
    Run Keyword And Warn On Failure  Click by JS     xpath://input[@value='Continue to shop']
    Run Keyword And Warn On Failure  Wait Until Location Contains    uat.davidyurman.com/en-gb
   ELSE IF  '${shopLocale}' in ['CN']
    Wait Until Element Is Visible    ${choose_country_button}
    Sleep  5s
    Scroll And Click by JS      ${choose_country_button}
    Wait Until Page Contains Element    ${choose_country_dropdown}
    Click Element    ${choose_country_dropdown}
    Click Element  xpath:(//div[@class='selectric-scroll'])[2]/ul/li[contains(text(),'Canada')]
    Click by JS     xpath://button[@id='js-choosecountry-submit']
    Run Keyword And Warn On Failure  Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=20s
    Run Keyword And Warn On Failure  Click by JS     xpath://input[@value='Continue to shop']
    Run Keyword And Warn On Failure  Wait Until Location Contains    uat.davidyurman.com/ca/en/home
   ELSE IF  '${shopLocale}' in ['FR']
    Wait Until Element Is Visible    ${choose_country_button}
    Sleep  5s
    Scroll And Click by JS      ${choose_country_button}
    Wait Until Page Contains Element    ${choose_country_dropdown}
    Click Element    ${choose_country_dropdown}
    Click Element  xpath:(//div[@class='selectric-scroll'])[2]/ul/li[contains(text(),'France')]
    Click by JS     xpath://button[@id='js-choosecountry-submit']
    Run Keyword And Warn On Failure  Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=20s
    Run Keyword And Warn On Failure  Click by JS     xpath://input[@value='Continue to shop']
    Run Keyword And Warn On Failure  Wait Until Location Contains    uat.davidyurman.com/en-fr
   ELSE IF  '${shopLocale}' in ['GR']
    Wait Until Element Is Visible    ${choose_country_button}
    Sleep  5s
    Scroll And Click by JS      ${choose_country_button}
    Wait Until Page Contains Element    ${choose_country_dropdown}
    Click Element    ${choose_country_dropdown}
    Click Element  xpath:(//div[@class='selectric-scroll'])[2]/ul/li[contains(text(),'Germany')]
    Click by JS     xpath://button[@id='js-choosecountry-submit']
    Run Keyword And Warn On Failure  Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=30s
    Run Keyword And Warn On Failure  Click by JS     xpath://input[@value='Continue to shop']
    Run Keyword And Warn On Failure  Wait Until Location Contains    uat.davidyurman.com/en-de
   ELSE IF  '${shopLocale}' in ['IT']
    Wait Until Element Is Visible    ${choose_country_button}
    Sleep  5s
    Scroll And Click by JS      ${choose_country_button}
    Wait Until Page Contains Element    ${choose_country_dropdown}
    Click Element    ${choose_country_dropdown}
    Click Element  xpath:(//div[@class='selectric-scroll'])[2]/ul/li[contains(text(),'Italy')]
    Click by JS     xpath://button[@id='js-choosecountry-submit']
    Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=30s
    Run Keyword And Warn On Failure   Click by JS     xpath://input[@value='Continue to shop']
    Run Keyword And Warn On Failure   Wait Until Location Contains    uat.davidyurman.com/en-it
   END


Enter text in Billing address
    [Arguments]     ${add}
    Scroll To Element   ${billing_address_one}
    CommonWeb.Check and Input text          ${billing_address_one}       ${add}

Fill in the remaining Billing details
    [Arguments]     ${mail}    ${fn}    ${ln}    ${phone}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_email}    timeout=3s
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    Run Keyword If    ${shippingMail}       Scroll To Element   ${billing_email}
    Run Keyword If    ${shippingMail}       CommonWeb.Check and Input text          ${billing_email}    ${mail}
    Scroll To Element   ${billing_fn}
    CommonWeb.Check and Input text          ${billing_fn}    ${fn}
    Scroll To Element   ${billing_ln}
    CommonWeb.Check and Input text          ${billing_ln}    ${ln}
    Scroll To Element   ${billing_phone}
    CommonWeb.Check and Input text          ${billing_phone}    ${phone}


Press Enter Key
     Press Keys    \\13

Get text from form
    [Arguments]     ${locator}
    ${text}=  Get Element Attribute    ${locator}   value
    RETURN    ${text}

Scroll Page
    [Arguments]    ${x_offset}    ${y_offset}
    Execute JavaScript    window.scrollBy(${x_offset}, ${y_offset})

Check Subtitles Text and Visibility
    [Arguments]    ${accordion_locator}    ${expected_titles}
    ${li_elements}              Get WebElements                     ${accordion_locator}
    ${actual_subtitles}         Convert WebElements to Strings      ${li_elements}
    CommonWeb.Check Substrings in List of String       ${actual_subtitles}        ${expected_titles}

Check Text Visibility in Accordion
    [Arguments]    ${locator}    ${text_locator}
    ${title_buttons}          Get WebElements                     ${locator}
    FOR    ${button}    IN    @{title_buttons}
        Click Element  ${button}
        Wait Until Element Is Visible    ${text_locator}  5s
        Element Should Be Visible    ${text_locator}
        Click Element  ${button}
        sleep  2s
    END

Click on Footer Link
    [Arguments]    ${title}
    Scroll Element Into View    xpath://a[contains(text(), '${title}')]
    Click Element       xpath://a[contains(text(), '${title}')]

Get text and Compare
    [Arguments]   ${locator}   ${expected_text}
    ${text}=    Check and Get text     ${locator}
    Should Be Equal     ${text}    ${expected_text}

Get text and assert
    [Arguments]  ${locator}  ${expectedText}
    ${actualText}   Get Text     ${locator}
    Should Contain  ${actualText}  ${expectedText}

Remove currency and comma from price
    [Arguments]  ${price}
    ${clean_price}     Remove String    ${price}           C$
    ${clean_price}     Remove String    ${clean_price}     $
    ${clean_price}     Remove String    ${clean_price}     €
    ${clean_price}     Remove String    ${clean_price}     £
    ${clean_price}     Remove String    ${clean_price}     ,
    ${clean_price}     Remove String    ${clean_price}     incl.
    ${clean_price}     Remove String    ${clean_price}     VAT
    ${clean_price}     Remove String    ${clean_price}     ${SPACE}
    ${clean_price}     Remove String    ${clean_price}     -
  RETURN  ${clean_price}
  
  
Close dev tools icon
   Run Keyword And Warn On Failure   Select Frame    xpath://iframe[@title='Customer Service Chat']
   Run Keyword And Warn On Failure   Select Frame    xpath://iframe[@id='DW-SFToolkit']
   Sleep  2s
   Run Keyword And Warn On Failure   Click by JS    xpath://div[@class='x-panel-body x-panel-body-noheader' and @id='ext-gen16']
   Run Keyword And Warn On Failure   Unselect Frame
   Run Keyword And Warn On Failure   Unselect Frame
   
Go to home page
   Click Element    xpath:(//a[@class='logo-home'])[1]
   
Go to Accounts
   [Arguments]  ${section}
   Mouse Over    //span[contains(@class,'link-header') and contains(text(),'Account')]
   Click Element  xpath://span[text()='${section}']
   
Go to Footer Signup
   Scroll To Bottom
   Wait Until Element Is Visible    xpath://input[@id='hpEmailSignUp']
   Scroll Element Into View    xpath://input[@id='hpEmailSignUp']

Check blank value validation in footer signup
   Clear Element Text    xpath://input[@id='hpEmailSignUp']
   Click Element    xpath://button[@id='btnSubscribeEmail']
   Element Text Should Be    xpath://span[contains(@class,'emailsignup-status')]    Please enter a valid email address

Check invalid email validation in footer signup
   Clear Element Text    xpath://input[@id='hpEmailSignUp']
   Check and Input text  xpath://input[@id='hpEmailSignUp']    tets@
   Click Element    xpath://button[@id='btnSubscribeEmail']
   Element Text Should Be    xpath://span[contains(@class,'emailsignup-status')]    Please enter a valid email address
   Clear Element Text    xpath://input[@id='hpEmailSignUp']
   Check and Input text  xpath://input[@id='hpEmailSignUp']    test
   Click Element    xpath://button[@id='btnSubscribeEmail']
   Element Text Should Be    xpath://span[contains(@class,'emailsignup-status')]    Please enter a valid email address
   Clear Element Text    xpath://input[@id='hpEmailSignUp']
   Check and Input text  xpath://input[@id='hpEmailSignUp']    tets.com
   Click Element    xpath://button[@id='btnSubscribeEmail']
   Element Text Should Be    xpath://span[contains(@class,'emailsignup-status')]    Please enter a valid email address


Check email footer signup
   Clear Element Text    xpath://input[@id='hpEmailSignUp']
   Check and Input text  xpath://input[@id='hpEmailSignUp']    test@mailsac.com
   Click Element    xpath://button[@id='btnSubscribeEmail']
   Wait Until Element Is Visible    xpath://span[contains(@class,'emailsignup-status')]
   Element Text Should Be    xpath://span[contains(@class,'emailsignup-status')]    Thank you! You have been subscribed.

Generate a future date
    ${date} =    Get Current Date    result_format=%m/%d/%Y    increment=30 day
    RETURN  ${date}

Remove Letters
    [Arguments]    ${input_string}
    ${result}    Evaluate    ''.join([char for char in "${input_string}" if not char.isalpha()])
    RETURN    ${result}

#Strings should be equal
#    [Arguments]  ${expected}  ${actual}

Fail
    Capture Page Screenshot
    Fail


Wait Until Page Contains Multiple Elements
    [Arguments]  @{listelements}
    FOR  ${element}  IN  @{listelements}
        Wait Until Element Is Visible    ${element}  30s
    END

Page Should Not Contain Multiple Elements
    [Arguments]  @{listelements}
    FOR  ${element}  IN  @{listelements}
        Wait Until Element Is Not Visible    ${element}  30s
    END

Page Should Contain Multiple Texts
    [Arguments]  @{listTexts}
    FOR  ${text}  IN  @{listTexts}
        Wait Until Page Contains    ${text}  10s
    END


Page should not contain Multiple Texts
    [Arguments]  ${listTexts}
    FOR  ${text}  IN  @{listTexts}
        Wait Until Page Does Not Contain    ${text}  30s
    END

Mouse Click
    [Arguments]  ${element}
    Set Selenium Implicit Wait    15s
    Mouse Over  ${element}
    Click Element   ${element}

Check for Broken Links
    ${URL}  Get Location
    ${URL}  Replace String  ${URL}  'dytest:TwistedCable23'  ${EMPTY}
    ${response}    Get Request    ${URL}
    @{links}    Get Links    ${response.content}
    Log    Found ${links.__len__()} links.
    FOR    ${link}    IN    @{links}
        ${status_code}    Get Status Code    ${link}
        Should Be Equal As Strings    ${status_code}    200
    END


Get Request
    [Arguments]    ${url}
    ${response}    Get Request    ${url}
    Should Be Equal As Strings    ${response.status_code}    200
    RETURN    ${response}

Get Links
    [Arguments]    ${html}
    ${links}    Parse Links    ${html}
    RETURN    ${links}

Parse Links
    [Arguments]    ${html}
    ${links}    Parse Links    ${html}
    RETURN    ${links}

Get Status Code
    [Arguments]    ${link}
    ${response}    Get Request    ${link}
    RETURN    ${response.status_code}