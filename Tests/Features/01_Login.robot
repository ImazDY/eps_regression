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
*** Test Cases ***
01 - New customer registration feature with valid details
    [Tags]  register
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether all elements are dislpayed in registration page
    Check whether registration is possible with valid details

02 - New customer registration feature with valid details and signup
    [Tags]  register
    Check if Login is accessible from header
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check privary policy link in registration page
    Check whether all elements are dislpayed in registration page
    Check whether registration is possible with valid details and signup

03 - Change password and login for new customer
    [Tags]  register  login
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in Register Form           ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}      ${valid_password}+1
    Click on Register
    Check Created User fields       ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}
    Logout
    Click on Sign In
    Fill in Login Form              ${guest_valid}     ${valid_password}+1
    Click on Login
    User should not be able to save future date for birthday
    User should not be able to save future date for anniversary
    Check Email in Account Page     ${guest_valid}
    Change Email                    a_${guest_valid}    ${valid_password}+1
    Check Email in Account Page     a_${guest_valid}

04 - Login user with valid credentials
    [Tags]  login
    Click on Sign In
    Fill in Login Form              ${REGISTERED_email}     ${REGISTERED_pwd}
    Click on Login
    Check Email in Account Page     ${REGISTERED_email}

05 - Verify new customer registration feature with blank mandatory values
    [Tags]  register
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether all elements are displayed in customer registration page
    Check whether registration is possible with blank mandatory values
    Check whether registration is possible with blank first name value
    Check whether registration is possible with blank last name value
    Check whether registration is possible with blank email value
    Check whether registration is possible with blank retype email value
    Check whether registration is possible with blank password value
    Check whether registration is possible with blank retype password value

06 - Verify new customer registration feature with invalid email value
    [Tags]  register  invalidemail
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
#    Check whether registration is possible with invalid email value
#    Check whether registration is possible with invalid retype email value
    Valid email and invalid retype email

07 - Verify new customer registration feature with already existing email value
    [Tags]  register
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether registration is possible with already existing email value

08 - Verify new customer registration feature with mismatch email value
    [Tags]  register
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether registration is possible with email mismatch

09 - Verify new customer registration feature with password requirements not satisfied
    [Tags]  register
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether registration is possible with password requirement not satisfied - minimum length
    Check whether registration is possible with password requirement not satisfied - capital and lower case
    Check whether registration is possible with password requirement not satisfied - no space
    Check whether registration is possible with password requirement not satisfied - no special character
    Check whether registration is possible with password requirement not satisfied - one number
    Check whether registration is possible with password requirement not satisfied - minimum length