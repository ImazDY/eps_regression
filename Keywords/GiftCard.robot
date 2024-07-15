*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/DataReader.robot

*** Keywords ***
Fill Virtual GC PDP
    Click by JS    xpath://div[@class='selectric']/b
    Click by JS    xpath://div[@class='selectric-scroll'][1]//li[2]
    CommonWeb.Check and Input text          xpath://input[@id='recipientFirstName']       ${GiftCard_Recipient_FirstName}
    CommonWeb.Check and Input text          xpath://input[@id='recipientLastName']        ${GiftCard_Recipient_LastName}
    CommonWeb.Check and Input text          xpath://input[@id='recipientEmailAddress']    ${GiftCard_Recipient_Email}
    CommonWeb.Check and Input text          xpath://input[@id='senderName']               ${GiftCard_Sender_Name}
    @{expected_vdg_values}  create list  ${GiftCard_Recipient_FirstName}  ${GiftCard_Recipient_Email}  ${GiftCard_Sender_Name}
    Set Test Variable    ${expected_vdg_values}

Fill GC PDP with braillie  
    [Arguments]   ${braillie}
    CommonWeb.Check and Click    xpath://div[@class='selectric']/b
    Sleep  2s
    CommonWeb.Check and Click    xpath:(//div[@class='selectric-scroll'])[1]//li[4]
   IF  '${braillie}' in ['yes']
    Click Element    xpath://label[@for='gift-card-braille']
   END

Check VGC fields on the checkout
    ${li_elements}          Get WebElements                     ${gift_card_checkout_details}
    ${actual_services}      Convert WebElements to Strings      ${li_elements}
    CommonWeb.Check Substrings in List of String       ${actual_services}        ${expected_vdg_values}

Enter Gift message
     Scroll Element Into View    xpath://textarea[@id='giftMessageOrder']
     Input Text    xpath://textarea[@id='giftMessageOrder']    Happy wishes

Get An Gift Card with Balance
    Open Gift Card PDP 
    Go to Check Balance modal
    ${actual_balance}       Set Variable    0

    FOR    ${gift_card_number}    IN    @{gift_cards_dict.keys()}
        ${gift_card_pin}=    Get From Dictionary    ${gift_cards_dict}    ${gift_card_number}
        ${actual_balance}           Get Gift Card Balance from Check Balance Modal    ${gift_card_number}     ${gift_card_pin}
        Run Keyword If                          ${actual_balance} > 0       Return From Keyword         ${gift_card_number}     ${gift_card_pin}
    END
    RETURN    ${None}    ${None}


Add Perpetual Gift Card
    Scroll Element Into View    ${payment_gift_card_expand_button}
    Click Element         ${payment_gift_card_expand_button} 
    Scroll Element Into View    ${check_balance_modal_gc_number}
    Input text    ${check_balance_modal_gc_number}        ${gift_card_number_100}         GC Number
    Scroll Element Into View    ${check_balance_modal_gc_pin}
    Input text    ${check_balance_modal_gc_pin}           ${gift_card_pin_100}            GC Pin
    Scroll Element Into View    ${payment_gift_card_apply_button}
    Sleep  2s
    Click Element         ${payment_gift_card_apply_button}

Open Gift Card PDP
    [Arguments]    ${is_virtual}=True
    Scroll To Bottom
    Check and Click                         ${gift_card_footer}
    Close the Get the First Look modal
    Run Keyword And Warn On Failure    Wait Until Page Contains Element         ${virtual_gift_card_img_initial_page}     20s     error=Virtual Card Initail page is not visible
    Run Keyword If          ${is_virtual}               Check and Click                         ${virtual_gift_card_img_initial_page}
    Run Keyword If          not ${is_virtual}           Check and Click                         ${physical_gift_card_img_initial_page}


Get Gift Card Balance from Check Balance Modal
    [Arguments]    ${gift_card_number}    ${gift_card_pin}
    Check and Input text                ${check_balance_modal_gc_number}    ${gift_card_number}     Gift Card Number
    Check and Input text                ${check_balance_modal_gc_pin}       ${gift_card_pin}        Gift Card Pin
    Check and Click                     ${check_balance_modal_gc_button}    Check Balance Button
    ${element_exists}                   Check Element Existence             ${check_balance_modal_gc_balance}
    IF      ${element_exists}
            ${balance}    Check and Get text    ${check_balance_modal_gc_balance}    Gift Card Balance
            ${amount_number}    Convert String with Currency to Number   ${balance}    
    ELSE
            ${amount_number}    Set Variable    0
    END
    RETURN    ${amount_number}


Select Amount Gift Card PDP
    [Arguments]     ${index}
    CommonWeb.Scroll And Click by JS            css:.selectric
    CommonWeb.Scroll And Click by JS            css:.product-variations-wrapper .selectric-items [data-index="${index}"]
    Wait Until Element Is Not Visible           css:.product-variations-wrapper .selectric-items [data-index="${index}"]     10s     error=Amount Gift Card PDP is still visible


Select an Available Physical Gift Card PDP
    ${gc_found}     Set Variable    False
    ${vector}       Create List    100    250    500    1000    2000
    ${count}        Set Variable    1

    FOR    ${value}    IN    @{vector}
        Select Amount Gift Card PDP     ${count}
        Wait Until Element Contains    css:.product-name-title    ${value}    timeout=10s
        ${text}=   Check and Get text      ${pdp_add_to_cart_l}
        IF    '${text}' == "ADD TO BAG"
            ${gc_found}    Set Variable    True
            Exit For Loop
        END
        ${count}    Evaluate    ${count} + 1
    END
    Run Keyword If    not ${gc_found}    Fail    No available physical gift card found

Check Gift card page location
    ${url}  Get Location
    Wait Until Location Contains        /gifts/gift-cards   timeout=10s   message= Gift Card Page Not loaded

Check virtual gift card pdp elements
    Run Keyword And Warn On Failure    Element Should Contain    xpath://span[@class='product-name-title']    Virtual Gift Card
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[@class='giftcard-delivery-method w-100']      $100–$2,000
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[contains(@class,'electronic-gift-card-selector')]    EMAIL
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[contains(@class,'physical-gift-card-selector')]    MAIL
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://h2[@class='pdp-link-tag']/label    Amount
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://div[@class='selectric']
    Run Keyword And Warn On Failure    Element Should Contain    xpath://input[@id='recipientFirstName']//following-sibling::label/span       Recipient’s First Name
    Run Keyword And Warn On Failure    Element Should Contain    xpath://input[@id='recipientLastName']//following-sibling::label/span        Recipient’s Last Name
    Run Keyword And Warn On Failure    Element Should Contain    xpath://input[@id='recipientEmailAddress']//following-sibling::label/span    Recipient’s E-mail Address
    Run Keyword And Warn On Failure    Element Should Contain    xpath://input[@id='senderName']//following-sibling::label/span               Sender’s Name
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://a[@id='gc-check-balance-reset']

Check virtual gift card pdp elements - CN
    Run Keyword And Warn On Failure    Element Should Contain    xpath://span[@class='product-name-title']     Gift Card
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[@class='giftcard-delivery-method w-100']      C$100–C$2,000
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[contains(@class,'electronic-gift-card-selector')]    EMAIL
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[contains(@class,'physical-gift-card-selector')]    MAIL
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://h2[@class='pdp-link-tag']/label    Amount
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://div[@class='selectric']
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://input[@id='recipientFirstName']//following-sibling::label/span       Recipient’s First Name
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://input[@id='recipientLastName']//following-sibling::label/span        Recipient’s Last Name
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://input[@id='recipientEmailAddress']//following-sibling::label/span    Recipient’s E-mail Address
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://input[@id='senderName']//following-sibling::label/span               Sender’s Name
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://a[@id='gc-check-balance-reset']

Check validation messages in virtual gift card pdp
   Click Element    xpath://button[contains(text(),'Add to Bag')]
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://p[@class='attribute-error']    Please select an amount
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://label[@for='recipientFirstName']//following-sibling::div    Please enter the recipient’s first name
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://label[@for='recipientLastName']//following-sibling::div     Please enter the recipient’s last name
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://label[@for='recipientEmailAddress']//following-sibling::div   Please enter a valid email address
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://label[@for='senderName']//following-sibling::div    Please enter the sender’s name

Check gift card pdp elements
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[@class='product-name-title']   Gift Card
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[@class='giftcard-delivery-method w-100']      $100–$2,000
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[contains(@class,'electronic-gift-card-selector')]    EMAIL
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[contains(@class,'physical-gift-card-selector')]    MAIL
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://h2[@class='pdp-link-tag']/label    Amount
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://div[@class='selectric']
    Run Keyword And Warn On Failure    Page Should Contain Element    xpath://a[@id='gc-check-balance-reset']

Click on chat online button
    log  CCMS-6883
    Mouse Click    ${giftcard_chatButton}