*** Settings ***
Test Setup        Run Keywords    Open website    Log into EPS  Accept Cookies
Test Teardown     Run Keywords    Close All Browsers
Force Tags        Regression    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../../Resources/Locators.robot
Resource          ../../Resources/Variables.robot
Resource          ../../Resources/Errors.robot
Resource          ../../Keywords/Checkout.robot
Resource          ../../Keywords/Cart.robot
Resource          ../../Keywords/OrderConfirmation.robot
Resource          ../../Keywords/Shipping.robot
Resource          ../../Keywords/Payment.robot
Resource          ../../Keywords/PDP.robot
Resource          ../../Keywords/PLP.robot
Resource          ../../Keywords/CommonWeb.robot
Resource          ../../Keywords/Login.robot
Resource          ../../Keywords/Homepage.robot
Resource          ../../Keywords/StoreLocator.robot
Resource          ../../Keywords/GiftCard.robot
Resource          ../../Keywords/MyAccount.robot

*** Test Cases ***
Check if About Us page is displayed correctly
    [Tags]    StaticPages
    Click on Footer Link                    About Us
    Get text and Compare                    ${about_us_title_locator}           ${about_us_title}
    Check Subtitles Text and Visibility     ${about_us_subtitle_locator}        ${expected_about_us_titles}

Check if Static Pages are displayed correctly
    [Tags]    StaticPages
    Click on Footer Link                        Returns & Exchanges
    Close the Get the First Look modal
    Check Subtitles Text and Visibility         ${static_page_accordion}        ${expected_return_exchanges_titles}
    Check Text Visibility in Accordion          ${static_page_accordion}        ${static_page_text_visible_locator}
    Click on Footer Link                        Customer Service
    Check Subtitles Text and Visibility         ${static_page_accordion}        ${expected_customer_service_titles}
    Check Text Visibility in Accordion          ${static_page_accordion}        ${static_page_text_visible_locator}
    Get text and Compare                        ${contact_customer_care_info_title_locator}         ${contact_customer_care_info_title}
    Check Subtitles Text and Visibility         ${contact_customer_care_info_subtitle_locator}      ${contact_customer_care_info_text}

Check all Links from header and footer
    [Tags]  StaticPages  Header  footer
    Check if empty minicart is accessible from header
    Check if Login is accessible from header
    Check if Country Selector is accessible from Footer
    Close the Country Selector modal
    Click on every link from footer and verify the correct pages are opened
    Social media links
    Generate Timestamp Email
    Subscribe to the newsletter    ${guest_valid}

Check privacy policy link
    [Tags]  StaticPages  CCMS-6550
    Navigate and check Privacy policy from Email footer
    Navigate and check Privacy policy from Account registration
    Navigate and check Privacy policy from Wishlist form
   IF  '${shoplocale}' in ['US','CN']
    Navigate and check Privacy policy from Contact form
   END