*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/DataReader.robot
*** Variables ***
${condition}    True
*** Keywords ***
Verify whether title is displayed in empty guest minicart
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h1[@class='empty-minicart-title text-center']
   Element Should Contain    xpath://h1[@class='empty-minicart-title text-center']     Your Bag\

Verify whether title is displayed in guest minicart
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h1[@class='minicart-title']
   Run Keyword And Warn On Failure    Element Should Contain    xpath://h1[@class='minicart-title']     Your Bag\

Verify whether remove button is displayed for the product
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://button[contains(text(),'Remove')]

Verify whether quantity selector is displayed for the product
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[@class='dy-custom-qty js-form-qty '])[1]

Verify whether discover more rails are displayed
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h3[text()='Discover More']
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[@class='ymal-tile-image'])[1]

Verify whether shopping bag empty message is displayed
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h2[@class='empty-card-title-text']
   Element Should Contain    xpath://h2[@class='empty-card-title-text']     Your Shopping Bag is Empty.
   Element Should Contain    xpath://h2[@class='empty-card-title-text']//following-sibling::p     Explore and add something you love.

Verify whether women and men toggle is displayed
  Run Keyword And Warn On Failure   Page Should Contain Element    xpath://span[@class='carousel-toggler-button']

Verify whether shop by rails are displayed
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[@class='slick-track'])[2]

Verify whether trending now rails are displayed
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h3[text()="Trending Now"]
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[@class='slick-track'])[4]

Verify by default women is selected
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://span[contains(@class,'is-tracked') and text()='Women']

Verify whether user can toggle to men
   Click Element    //span[contains(@class,'selection-two')]
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://span[contains(@class,'selection-on') and text()='Men']  5s

Verify whether the shop by rails changes to men
   Run Keyword And Warn On Failure   Page Should Contain Element   xpath:(//p[@class='category-name'])[4]
   Run Keyword And Warn On Failure    Element Should Contain    xpath:(//p[@class='category-name'])[4]    Shop Rings

Verify whether user can toggle to women
   Click Element    id=tabWomen
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://span[contains(@class,'selection-on') and text()='Women']  5s

Verify whether the shop by rails changes to women
   Run Keyword And Warn On Failure   Page Should Contain Element   xpath:(//p[@class='category-name'])[2]
   Run Keyword And Warn On Failure    Element Should Contain    xpath:(//p[@class='category-name'])[2]    Shop Necklace
   
Verify navigation from shop braclets for women
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//p[@class='category-name'])[1]
   Scroll To Element    xpath:(//p[@class='category-name'])[1]
   Click Element    xpath:(//p[@class='category-name'])[1]
   Close the Get the First Look modal
   Run Keyword And Warn On Failure  Run Keyword And Warn On Failure   Page Should Contain Element    xpath://div[@class='pd-text d-none d-lg-block ']
   Run Keyword And Warn On Failure  Element Should Contain    xpath://h1[@class='pd-text d-lg-none ']    Women’s Bracelets

Verify navigation from shop braclets for men
   Click Element    xpath:(//p[@class='category-name'])[2]
   Sleep  10s
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://div[@class='pd-text d-none d-lg-block ']
   Run Keyword And Warn On Failure    Element Should Contain    xpath://h1[@class='pd-text d-lg-none ']    Men’s Bracelets
   
Verify whether user navigates to correct PLP page from trending now
    Wait Until Page Contains Element    xpath:(//p[@class='ymal-product_name'])[1]
    ${product_name} =  Get Text    xpath:(//p[@class='ymal-product_name'])[1]
    Click Element    xpath:(//p[@class='ymal-product_name'])[1]
    Scroll Element Into View    xpath://span[@class='product-name--title js-primary-title']
    ${PDP_product_primary_name}    Get Text    xpath://span[@class='product-name--title js-primary-title']
    Run Keyword And Warn On Failure     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${PDP_product_primary_name}    ${product_name}

Verify whether item count is displayed in minicart
    [Arguments]  ${count}
    Wait Until Page Contains Element    xpath://span[@class='js-minicart-title-qty minicart-title-qty']
    Run Keyword And Warn On Failure    Element Should Contain   xpath://span[@class='js-minicart-title-qty minicart-title-qty']   ${count}

Verify whether delivery type for item is displayed in minicart
    [Arguments]  ${deliveryType}
    IF  '${deliveryType}' in ['Pick up']
    Run Keyword And Warn On Failure    Element Should Contain   xpath://h2[@class='store-pickup-info']   ${deliveryType} - ${pickup_store}
    ELSE
    Wait Until Page Contains Element    xpath://h2[@class='cart-items-group-title' and contains(text(),'${deliveryType}')]
    Run Keyword And Warn On Failure    Element Should Contain   xpath://h2[@class='cart-items-group-title']   ${deliveryType}
    END

Get store location shown with product
   Wait Until Page Contains Element    xpath://span[@class='pickup-in-store-btn-modal text-underline']
   ${pickup_store}   Get Text    xpath://span[@class='pickup-in-store-btn-modal text-underline']
   ${pickup_store}   Set Test Variable    ${pickup_store}

Verify minicart buttons
    Run Keyword And Warn On Failure   Page Should Contain Element     xpath://a[@title='View Bag']
    Run Keyword And Warn On Failure   Page Should Contain Element     xpath://a[@data-event-value='continue_checkout']
    IF  '${shopLocale}' in ['US','CN']
      Run Keyword And Warn On Failure   Wait Until Page Contains Element     xpath://div[@class='paypal-button-label-container']   timeout=20s
    END

Verify minicart buttons for preorder
    Run Keyword And Warn On Failure   Page Should Contain Element     xpath://a[@title='View Bag']
    Run Keyword And Warn On Failure   Page Should Contain Element     xpath://a[@data-event-value='continue_checkout']
    Run Keyword And Warn On Failure   Page Should Not Contain Element   xpath://div[@class='paypal-button-label-container']   timeout=20s

Verify navigation to PDP from mini cart 
     Click Element   xpath://div[@class='line-item-header line-item-primary-title']/a
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath://span[@class='product-name--title js-primary-title']

Verify navigation from view bag button
     Click Element   xpath://a[@title='View Bag']
     Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h1[@class='page-title']
     Run Keyword And Warn On Failure    Element Should Contain    xpath://h1[@class='page-title']    Your Bag

Verify navigation from continue checkout button
     Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${continue_checkout_minicart}
     Scroll To Element    ${continue_checkout_minicart}
     Click Element   ${continue_checkout_minicart}
     Run Keyword And Warn On Failure   Page Should Contain Element    ${checkout_page_title}

Verify navigation from paypal
     Select Frame  xpath:(//iframe[@title='PayPal'])[1]
     Wait Until Element Is Visible    //div[@class='paypal-button-label-container']  10s
     sleep  2s
     Click by JS   xpath://div[@class='paypal-button-label-container']
     @{winHandles}=    Get Window Handles
     @{winTitles}=    Get Window Titles
     Switch Window    ${winHandles}[1]
     Wait Until Page Contains Element    ${paypal_email_l}     100s    Email field is not loaded
     Close Window

Verify quantity selector functionality
   FOR    ${index}    IN RANGE    10
   Run Keyword If  '${condition}' != True  Click By JS    (//button[@aria-label='Add quantity minicart'])[1]
    ${condition}  Run Keyword And Return Status    Page Should Not Contain Element    xpath://span[contains(text(),'The maximum available quantity for this item is')]
   Run Keyword If    '${condition}' != True   Exit For Loop
   END

Verify validation messages for item not available in minicart
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://span[@class='error-bold-red']
   Run Keyword And Warn On Failure    Element Should Contain    xpath://span[@class='error-bold-red']     We’re sorry! This item is no longer available in the quantity selected.
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://div[@class='js-unavailable-items-error-message mt-2 unavailable-items-error']
   Run Keyword And Warn On Failure    Element Should Contain    xpath://div[@class='js-unavailable-items-error-message mt-2 unavailable-items-error']      Please remove unavailable items to continue with checkout

Click paypal checkout from minicart
     Sleep  2s
     Wait Until Element Is Visible    xpath:(//iframe[@title='PayPal'])[1]    timeout=30s
     Select Frame  xpath:(//iframe[@title='PayPal'])[1]
     Sleep  1s
     Click Element   xpath://div[@class='paypal-button-label-container']
     @{winHandles}=    Get Window Handles
     @{winTitles}=    Get Window Titles
     Switch Window    ${winHandles}[1]
     Wait Until Page Contains Element    ${paypal_email_l}     100s    Email field is not loaded

Check ring sizer details in miniCart
     sleep  2s
     Wait Until Element Is Visible    xpath://div[@class='line-item-header line-item-primary-title']
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='line-item-header line-item-primary-title']    ${ringSizer_product_primary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='line-item-header line-item-secondary-title ']    ${ringSizer_product_secondary_name}
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='line-item-total-price-amount']    ${ringSizer_detail}
#     ${miniCart_subTotal}  Get Text    xpath://div[@class='sub-total']
#     ${miniCart_subTotal}  Remove currency and comma from price    ${miniCart_subTotal}
#     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${miniCart_subTotal}    0
     Element Should Contain  xpath://div[@class='sub-total']  0

Check whether correct no:of products are added under group title in minicart
   [Arguments]  ${groupTitle}  ${no_of_products}
   IF  '${groupTitle}' in ['delivery']
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2    Delivery

   ELSE IF  '${groupTitle}' in ['pick up same store']
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h2[@class='store-pickup-info']
    Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[@class='store-pickup-info']    Pick up at ${bopis_storeName}

   ELSE IF  '${groupTitle}' in ['pick up different store']
    Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath:(//h2[@class='store-pickup-info'])[1]  5s
    Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath:(//h2[@class='store-pickup-info'])[2]  5s
    Element Text Should Be    xpath:(//h2[@class='store-pickup-info'])[2]    Pick up at ${bopis_storeName_2}
    Element Text Should Be    xpath:(//h2[@class='store-pickup-info'])[1]    Pick up at ${bopis_storeName}
   END
    ${products_in_minicart}   Get WebElements   xpath://div[@class='product-line-item-details d-flex flex-row']
    ${no_of_products_in_minicart_1}   Get Length    ${products_in_minicart}
    ${no_of_products_in_minicart}   Convert To String    ${no_of_products_in_minicart_1}
    Run Keyword And Warn On Failure   Should Be Equal As Strings    ${no_of_products_in_minicart}    ${no_of_products}

Compare item details in minicart for 2 products
     [Arguments]  ${size}   ${size2}
####First Product Details
     Wait Until Element Is Visible    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${miniCart_product_1_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${miniCart_product_1_price}    Remove currency and comma from price    ${miniCart_product_1_price}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${PDP_product_2_price}    ${miniCart_product_1_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-item-header line-item-primary-title']/a)[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-item-header line-item-primary-title']/a)[1]    ${PDP_product_2_primary_name}
     Wait Until Element Is Visible    xpath:(//div[@class='line-item-header line-item-secondary-title ']/a)[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-item-header line-item-secondary-title ']/a)[1]    ${PDP_product_2_secondary_name}
     Wait Until Element Is Visible  xpath:(//div[@class='line-item-attributes']/span[2])[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-item-attributes']/span[2])[1]    ${size2}
     Wait Until Element Is Visible    xpath:(//input[contains(@class,'quantity js-qty')])[1]
     ${item_quantity_1}    Get Element Attribute    xpath:(//input[contains(@class,'quantity js-qty')])[1]    value
     Should Be Equal    ${item_quantity_1}    1
####Second Product Details
     Wait Until Element Is Visible    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${miniCart_product_2_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[2]
     ${miniCart_product_2_price}    Remove currency and comma from price    ${miniCart_product_2_price}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${PDP_product_1_price}    ${miniCart_product_2_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-item-header line-item-primary-title']/a)[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-item-header line-item-primary-title']/a)[2]    ${PDP_product_1_primary_name}
     Wait Until Element Is Visible    xpath:(//div[@class='line-item-header line-item-secondary-title ']/a)[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-item-header line-item-secondary-title ']/a)[2]    ${PDP_product_1_secondary_name}
     Wait Until Element Is Visible  xpath:(//div[@class='line-item-attributes']/span[2])[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[@class='line-item-attributes']/span[2])[2]    ${size}
     Wait Until Element Is Visible    xpath:(//input[contains(@class,'quantity js-qty')])[3]
     ${item_quantity_2}    Get Element Attribute    xpath:(//input[contains(@class,'quantity js-qty')])[3]    value
     Should Be Equal    ${item_quantity_2}    1

Check total minicart item quantity
     [Arguments]  ${total_quantity}
     Wait Until Element Is Visible    xpath://span[contains(@class,'minicart-title-qty')]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath://span[contains(@class,'minicart-title-qty')]    ${total_quantity} items

Verify whether last added product is shown first in minicart
     Sleep  2s
     Wait Until Element Is Visible    xpath:(//div[contains(@class,'line-item-primary-title')])[1]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-primary-title')])[1]    ${PDP_product_2_primary_name}

Check shipping method group title in minicart
    [Arguments]  ${shippingMethod}
   IF  '${shippingMethod}' in ['Delivery']
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2
    Run Keyword And Warn On Failure   Element Should Contain    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2    Delivery
   ELSE IF  '${shippingMethod}' in ['pre order']
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h2[@class='cart-items-group-title']
    Run Keyword And Warn On Failure   Element Should Contain    xpath://h2[@class='cart-items-group-title']    Pre-Order
    ELSE IF  '${shippingMethod}' in ['pick up']
    Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h2[@class='store-pickup-info']
    Run Keyword And Warn On Failure    Element Should Contain    xpath://h2[@class='store-pickup-info']   Pick up at ${bopis_storeName}
   END

Check product size in minicart
    [Arguments]  ${size}
    Run Keyword And Warn On Failure    Element Should Contain    xpath://div[@class='line-item-attributes']/span[2]    ${size}

Check virtual gift card details in minicart
     IF  '${shopLocale}' in ['US']
        Wait Until Element Is Visible    xpath://div[contains(@class,'line-item-primary-title')]/a
        Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]/a    US Virtual Gift Card
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    Country: US
     ELSE IF  '${shopLocale}' in ['CN']
        Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]/a    CA Virtual Gift Card
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    Country: CA
     END
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[1]    Gift Card Type: Virtual
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[3]    Recipient: ${GiftCard_Recipient_FirstName} (${GiftCard_Recipient_Email})
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[4]    Sender: ${GiftCard_Sender_Name}


Check physical gift card details in minicart
     IF  '${shopLocale}' in ['US']
        Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]/a    $500 Gift Card
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    Country: US
     ELSE IF  '${shopLocale}' in ['CN']
        Run Keyword And Warn On Failure   Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]/a    C$500 Gift Card
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    Country: CA
     END
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[1]    Gift Card Type: Physical

Check whether correct no:of products are added under group title in minicart for mixed cart delivery and bopis
        Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[@class='store-pickup-info']    Pick up at ${bopis_storeName}
        Scroll To Element    xpath:(//h2[@class='cart-items-group-title'])[1]
        Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//h2[@class='cart-items-group-title'])[1]    Delivery

Increase the nth product count by n
    [Arguments]  ${nth}  ${n}
    ${initialCount}   Get Element Attribute    (//input[contains(@class,'quantity') and contains(@value,'')])[${nth}]    value
    ${count}  Set Variable  ${initialCount}
    FOR  ${num}  IN RANGE  1  ${n}+1
        Click by JS    (${minicart_quantityUp})[${nth}]
        sleep  3s
        ${count}  Evaluate  ${count} + 1
    END
    ###Verifies selector count based on increased quantity
    Wait Until Page Contains Element  (//input[contains(@class,'quantity') and contains(@value,'${count}')])[${nth}]     5s

Decrease the nth product count by n
    [Arguments]  ${nth}  ${n}
    ${initialCount}   Get Element Attribute    (//input[contains(@class,'quantity') and contains(@value,'')])[${nth}]    value
    ${count}  Set Variable  ${initialCount}
    FOR  ${num}  IN RANGE  1  ${n}+1
        Click by JS    (${minicart_quantityDown})[${nth}]
        sleep  3s
    END
    ${count}  Evaluate  ${count} - ${n}
    ###Verifies selector count based on increased quantity
    Wait Until Page Contains Element  (//input[contains(@class,'quantity') and contains(@value,'${count}')])[${nth}]     5s

Make sure product is still in the cart after decrease in quantity
     log  CCMS-6472
     Wait Until Element Is Visible    xpath://div[@class='line-item-header line-item-primary-title']/a
     ${miniCart_product_primary_name}    Get Text    xpath://div[@class='line-item-header line-item-primary-title']/a
     Should Contain   ${miniCart_product_primary_name}    ${PDP_product_1_primary_name}

Remove a product from cart and verify remove success message
     log  CCMS-6609
     ${miniCart_product_title}    Get Text    xpath://div[@class='line-item-header line-item-primary-title']/a
     Wait Until Element Is Visible    xpath://div[@class='line-item-header line-item-secondary-title ']/a
     ${miniCart_product_description}    Get Text    xpath://div[@class='line-item-header line-item-secondary-title ']/a
     Wait Until Element Is Visible     xpath:(//input[contains(@class,'quantity js-qty')])[1]
     Set Test Variable   ${miniCart_product_title}
     Set Test Variable   ${miniCart_product_description}
     Click by JS    (${minicart_removeProduct})[1]
     Remove success message should be displayed in minicart

Remove success message should be displayed in minicart
     Wait Until Page Contains  ${miniCart_product_title} in ${miniCart_product_description} removed from cart.  5s
