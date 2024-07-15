*** Settings ***
Test Setup        Run Keywords    Open website   Read Data From JSON File  Log into EPS
Test Teardown     Run Keywords    Close All Browsers
Force Tags        prod    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../../Resources/Locators.robot
Resource          ../../Resources/Variables.robot
Resource          ../../Resources/Errors.robot
Resource          ../../Keywords/Homepage.robot
Resource          ../../Keywords/Checkout.robot
Resource          ../../Keywords/Cart.robot
Resource          ../../Keywords/OrderConfirmation.robot
Resource          ../../Keywords/Shipping.robot
Resource          ../../Keywords/Payment.robot
Resource          ../../Keywords/PDP.robot
Resource          ../../Keywords/PLP.robot
Resource          ../../Keywords/CommonWeb.robot
Resource          ../../Keywords/Login.robot
Resource          ../../Keywords/StoreLocator.robot
Resource          ../../Keywords/GiftCard.robot
Resource          ../../Keywords/MyAccount.robot
Resource          ../../Keywords/DataReader.robot
Resource          ../../Resources/Errors.robot
Resource          ../../Keywords/Login.robot  
*** Test Cases ***
#00 _ Broken links verification
#    [Tags]  links
#    Check for Broken Links

01 - Add/Edit/Remove Address details and card details
    [Tags]  MyAccount
    Generate Timestamp Email
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Fill in Register Form           ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}      ${valid_password}+1
    Click on Register
    Check that the user is successfully logged in and redirected to Account Details page    ${guest_valid}
    Click on Add a New Address button
    Click on Save button from Add a New Address form
    Verify the empty field validation messages for Add a New Address form
    Fill in the Add a New Address form    ${FIRST_NAME}   ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_State}    ${NewUser_Zipcode}  ${NewUser_Phone}
    Click on Save button from Add a New Address form
    Check if the new address is present in My Account    ${FIRST_NAME}   ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}   ${NewUser_Zipcode}  ${NewUser_Phone}
    Click on Edit link near first address
    Fill in the Edit Address form    ${FIRST_NAME_EDITED}   ${LAST_NAME_EDITED}    ${NewUser_StreetAddress_EDITED}    ${NewUser_Flat_EDITED}    ${NewUser_City_EDITED}    ${NewUser_State_EDITED}    ${NewUser_Zipcode_EDITED}  ${NewUser_Phone_EDITED}
    Click on Save button from Edit Address form
    Check if the new address is present in My Account    ${FIRST_NAME_EDITED}   ${LAST_NAME_EDITED}    ${NewUser_StreetAddress_EDITED}    ${NewUser_Flat_EDITED}    ${NewUser_City_EDITED}    ${NewUser_Zipcode_EDITED}  ${NewUser_Phone_EDITED}
    Click on Delete link near first address
    Click Confirm on the Delete Address modal
    Check that My Address section is empty
    Click on Add a New Credit Card button
    Click on Save button from Add a New Credit Card form
    Verify the empty field validation messages for Add a New Credit Card form
    Close the New Credit Card form
    Click on Add a New Credit Card button
    Fill in the Add a New Credit Card form    ${FIRST_NAME}   ${visa_number}    ${csv}    ${FIRST_NAME}    ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}  ${NewUser_State}   ${NewUser_Zipcode}  ${NewUser_Phone}
    Click on Save button from Add a New Credit Card form
    Check if the new card is present in My Account    ${FIRST_NAME}    ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_City}  ${NewUser_Zipcode}  ${NewUser_Phone}
    Click on Make Default button near first CC and see if setting is applied
    Click on Remove button near first CC
    Click Confirm on the Delete CC modal
    Check that Credit Card section is empty


02 -Add/Edit/Remove card details
    [Tags]  MyAccount  carddet
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in the Register form
    Check that the user is successfully logged in and redirected to Account Details page    ${guest_valid}
    Click on Add a New Address button
    Fill in the Add a New Address form    ${FIRST_NAME}   ${LAST_NAME}    ${NewUser_StreetAddress}    ${NewUser_Flat}    ${NewUser_City}    ${NewUser_State}    ${NewUser_Zipcode}  ${NewUser_Phone}
    Click on Save button from Add a New Address form
    Check if the new address is present in My Account    ${FIRST_NAME}    ${LAST_NAME}    ${NewUser_StreetAddress}  ${NewUser_Flat}   ${NewUser_City}  ${NewUser_Zipcode}  ${NewUser_Phone}
    Click on Add a New Credit Card button
    Fill in credit card details and select a saved address    ${FIRST_NAME}   ${visa_number}    ${csv}
    Click on Save button from Add a New Credit Card form
    Check if the new card is present in My Account    ${FIRST_NAME}    ${LAST_NAME}    ${NewUser_StreetAddress}   ${NewUser_City}  ${NewUser_Zipcode}  ${NewUser_Phone}
    Click on Make Default button near first CC and see if setting is applied
    Click on Remove button near first CC
    Click Confirm on the Delete CC modal
    Check that Credit Card section is empty
    Click on Add a New Credit Card button
    Fill in credit card details and select a saved address    ${FIRST_NAME}   ${visa_number}    ${csv}
    Click on Save button from Add a New Credit Card form
    Check if the new card is present in My Account    ${FIRST_NAME}    ${LAST_NAME}    ${NewUser_StreetAddress}   ${NewUser_City}  ${NewUser_Zipcode}  ${NewUser_Phone}

03 - Validate Personal Info change
    [Tags]  MyAccount
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in Register Form           ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}      ${valid_password}
    Click on Register
    Check Created User fields       ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}
    Change Name in Personal Information             First   Last
    Change Birthday in Personal Information         12/12/2012
    Change Anniversary in Personal Information      11/11/2002
    Save Personal Information                       First
    Check Personal Information                      First   Last     12/12/2012    11/11/2002


04 - Validate Personal validation messages
    [Tags]  MyAccount
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in Register Form           ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}      ${valid_password}
    Click on Register
    Check Created User fields       ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}
    Clear Name in Personal Information
    Save Personal Information with no arguments
    Check validation message for first name and last name field

05 - Validate the preference center
    [Tags]  MyAccount  pc  CCMS-6675
    Click on Sign In
    Fill in Login Form              ${REGISTERED_email}     ${REGISTERED_pwd}
    Click on Login
    Check Email in Account Page     ${REGISTERED_email}
    Go to email preferences page
    Verify expected elements in Email preferences page
    Verify country selector dropdown
    Select Unsibscribe from all updates and save
    Back to email preference
    Verify email promotions and BA radios should be disabled
    Status Should Be  Not Subscribed
    Select Receive all updates and save
    Back to email preference
    Verify all radio buttons should be enabled
    Status Should Be    Subscribed to All

    Select Only Email Promotions and save
    Back to email preference
    Verify all radio buttons should be enabled
    Status Should Be    Only Email Promotions

    Select Only Brand Ambassador Updates and save
    Back to email preference
    Verify all radio buttons should be enabled
    Status Should Be    Only Ambassador Updates


