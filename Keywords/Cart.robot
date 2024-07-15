*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/PDP.robot
Resource          ../Keywords/Shipping.robot
*** Keywords ***
Hover over My Bag
    Mouse Over    ${minicart_icon_l}

Click on My Bag
    ${minicart_already_opened}    Run Keyword And Return Status    Element Should Be Visible    ${minicart_close_l}
    IF    "${minicart_already_opened}" == "True"
        Close the minicart
    END
    Click Element    ${minicart_icon_l}
   # Wait Until Element Is Visible    ${minicart_close_l}    10s    error=Minicart is not visible

Click on View Bag from minicart
    Click Element    ${minicart_view_bag_l}
    Wait Until Page Contains Element    ${cart_page_data_action_l}    10s    error=Cart Page is not visible

Close the wishlist minicart
    Wait Until Element Is Visible    //button[contains(@class,'close-thick')]
    Click Element  //button[contains(@class,'close-thick')]
    Wait Until Element Is Not Visible    //button[contains(@class,'close-thick')]  10s  error=wishlist minicart is still visible

Close the minicart
    Click Element    ${minicart_close_l}
    Wait Until Element Is Not Visible    ${minicart_close_l}    10s    error=Minicart is still visible

Close the empty minicart
    Click Element    ${minicart_empty_close_l}
    Wait Until Element Is Not Visible    ${minicart_empty_close_l}    10s    error=Minicart is still visible


Click on Checkout button from cart page
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    CommonWeb.Click by JS    ${cart_checkout_l}
    Check customer care number present at checkout header

Click on Chekout button from Minicart modal
    Scroll Element Into View    ${cart_checkout_l}

Submit the empty Promo Code field from Cart page and check the error message
    Press Keys    ${cart_coupon_input_l}    CONTROL+A DELETE
    CommonWeb.Check and Click    ${cart_coupon_submit_l}
    Wait Until Element Is Visible    ${cart_coupon_err_l}    10s    error=Promo Code Error Message is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${cart_coupon_err_l}    ${cart_coupon_err}

Remove all products from the Cart
    Retreive the number of items in the cart
    ${elements_in_cart}    Run Keyword And Return Status    Page Should Contain Element    ${cart_rem_prod_one_l}
    IF    "${elements_in_cart}" == "True"
        FOR    ${i}    IN RANGE    1    ${minicart_nr_of_items}+1
            Check and Click    css:.card:nth-child(${i}) .d-none .remove-product
        END
    END
    Wait Until Element Is Not Visible    ${cart_rem_prod_one_l}     5s     error=Remove CTA is still visible

Check empty Cart message
    Wait Until Page Contains Element     ${home_empty_minicart_l}     5s     error=Empty Minicart is not loaded
    Wait Until Element Is Visible     ${home_empty_minicart_l}     5s     error=Empty Minicart is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${home_empty_minicart_l}    ${home_empty_minicart_exp}

Check the elements of the Cart page
    Retreive the number of items in the cart
    FOR    ${nr}    IN RANGE    1    ${minicart_nr_of_items}+1
        Wait Until Element Is Visible   (//*[contains(@class,'line-item-primary-title')])[${nr}]  5s
        Wait Until Element Is Visible    (//*[contains(@class,'line-item-primary-title')])[${nr}]  5s
    END

Check Cart Subtotal after promo code is applied
    Run Keyword And Warn On Failure    Element Should Contain     ${cart_grand_total_l}    ${expected_subtotal}

Click on first Edit link from Cart
    Scroll Element Into View    ${cart_quick_edit_l}
    Click by JS    ${cart_quick_edit_l}
    Wait Until Page Contains Element    ${cart_quick_edit_show_l}     5s     error=Quick Edit modal is not loaded
    Wait Until Element Is Visible    ${cart_quick_edit_show_l}     5s     error=Quick Edit modal is not visible

Modify the Size of the first product from the cart
    [Arguments]    ${size_to_update}
    Click By JS    css:button[data-attr-value="${size_to_update}"]
    Set Test Variable    ${size_to_update}
    Sleep    2s

Click on Update button from Update Product modal
    Click Element    css:.edit-button-cart
    Sleep  10s
    Wait Until Element Is Not Visible    ${cart_quick_edit_show_l}     5s     error=Quick Edit modal is still visible

Verify if the size was modified in the Cart
    Run Keyword And Warn On Failure    Element Text Should Be    ${cart_size_prod_one_l}    ${size_to_update}

Click on Move to Wishlist link from the Cart and verify if the product was added to Wishlist
    Retrieve the number of items before removal
    Scroll Element Into View    ${cart_wish_prod_one_l}
    Click by JS    ${cart_wish_prod_one_l}
    Wait until success message is displayed in Cart
    Retreive the number of items in the cart
    Check if the quantity was decreased

Remove the first item from the Cart
    Retrieve the number of items before removal
    Scroll Element Into View    ${cart_rem_prod_one_l}
    Click by JS    ${cart_rem_prod_one_l}
    Wait until success message is displayed in Cart
    Retreive the number of items in the cart
    Check if the quantity was decreased

Wait until success message is displayed in Cart
    Wait Until Page Contains Element    ${cart_success_msg_l}     5s     error=Success Message is not loaded
    Wait Until Element Is Visible    ${cart_success_msg_l}     5s     error=Success Message is not visible

Update the quantity of the first item from the Cart
    Scroll Element Into View    ${cart_plus_qty_l}
    Sleep  5s
    Click by JS    ${cart_plus_qty_l}
    Wait Until Page Contains Element    ${cart_qty_input_l}     10     error=Product Quantity is not loaded
    Wait Until Element Is Visible    ${cart_qty_input_l}     10     error=Product Quantity is not visible
    Run Keyword And Warn On Failure    Element Attribute Value Should Be    ${cart_qty_input_l}    value    2

Check if the quantity was decreased
    ${expected_nr_of_items}    Evaluate    ${total_items_before_remove}-1
    Sleep    5s
    Run Keyword And Warn On Failure    Element Text Should Be    ${minicart_nr_of_items_l}    ${expected_nr_of_items}

Retreive the number of items in the cart
    ${minicart_nr_of_items}    Check and Get text    ${minicart_nr_of_items_l}
    Set Test Variable    ${minicart_nr_of_items}

Retrieve the number of items before removal
    ${total_items_before_remove}    Set Variable    ${minicart_nr_of_items}
    Set Test Variable    ${total_items_before_remove}

Return to Cart
    Check and Click    ${shipping_back_to_cart_l}
    Wait Until Page Contains Element    ${cart_page_data_action_l}     5s     error=Cart Body is not loaded
    Wait Until Element Is Visible    ${cart_page_title_l}     5s     error=Cart Title is not visible

Check Minicart elements
    Wait Until Element Is Visible    ${minicart_title_l}     5s     error=Minicart Title is not visible
    Wait Until Element Is Visible    ${minicart_prod_img_l}     5s     error=Minicart Product Image is not visible
    Wait Until Element Is Visible    ${minicart_view_cart_l}     5s     error=Minicart View Cart Button is not visible
    Wait Until Element Is Visible    ${minicart_checkout_btn_l}     5s     error=Minicart Checkout Button is not visible

Check if product price and total price is correct
    Run Keyword And Warn On Failure     Element Should Contain    ${minicart_price_line_l}    ${expected_subtotal}
    Run Keyword And Warn On Failure     Element Should Contain    ${minicart_subtotal_price_l}    ${subtotal_without_currency}


Capture product price from miniCart
    ${miniCart_product_price_1}    Get Text    xpath://div[contains(@class,'line-item-total-price-amount')]
    ${miniCart_product_price}    Remove currency and comma from price    ${miniCart_product_price_1}
    Set Global Variable  ${miniCart_product_price}   ${miniCart_product_price}

Capture product primary name from MiniCart
    Scroll To Element    xpath://div[@class='line-item-header line-item-primary-title']/a
    ${miniCart_product_primary_name}    Get Text    xpath://div[@class='line-item-header line-item-primary-title']/a
    Set Global Variable   ${miniCart_product_primary_name}   ${miniCart_product_primary_name}


Capture product secondary name from miniCart
    Scroll Element Into View    xpath://div[@class='line-item-header line-item-secondary-title ']/a
    ${miniCart_product_secondary_name}    Get Text    xpath://div[@class='line-item-header line-item-secondary-title ']/a
    Set Global Variable   ${miniCart_product_secondary_name}     ${miniCart_product_secondary_name}

Capture product quantity in minicart
    Scroll Element Into View     xpath:(//input[contains(@class,'quantity js-qty')])[1]
    ${minicart_product_quantity}  Get Element Attribute    xpath:(//input[contains(@class,'quantity js-qty')])[1]   value
    Set Global Variable    ${minicart_product_quantity}   ${minicart_product_quantity}


Compare item details in minicart with PDP
     [Arguments]  ${size}
     Wait Until Element Is Visible    xpath://div[contains(@class,'line-item-total-price-amount')]
     ${miniCart_product_price}    Get Text    xpath://div[contains(@class,'line-item-total-price-amount')]
     ${miniCart_product_price}    Remove currency and comma from price    ${miniCart_product_price}
     Wait Until Element Is Visible    xpath://div[@class='line-item-header line-item-primary-title']/a
     ${miniCart_product_primary_name}    Get Text    xpath://div[@class='line-item-header line-item-primary-title']/a
     Wait Until Element Is Visible    xpath://div[@class='line-item-header line-item-secondary-title ']/a
     ${miniCart_product_secondary_name}    Get Text    xpath://div[@class='line-item-header line-item-secondary-title ']/a
     Wait Until Element Is Visible     xpath:(//input[contains(@class,'quantity js-qty')])[1]
     ${minicart_product_quantity}  Get Element Attribute    xpath:(//input[contains(@class,'quantity js-qty')])[1]   value
     Wait Until Element Is Visible    xpath://div[@class='line-item-attributes']/span[2]
     Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='line-item-attributes']/span[2]    ${size}
     Should Be Equal As Strings    ${miniCart_product_price}    ${PDP_product_1_price}
     Should Contain   ${miniCart_product_primary_name}    ${PDP_product_1_primary_name}
     Run Keyword And Warn On Failure  Should Contain    ${miniCart_product_secondary_name}    ${PDP_product_1_secondary_name}
     Run Keyword And Warn On Failure    Element Text Should Be    xpath://span[contains(@class,'minicart-title-qty')]    ${minicart_product_quantity} item
     Element Should Contain    xpath://div[@class='sub-total-title']    Total
     Element Should Contain    xpath://div[@class='sub-total']    ${miniCart_product_price}


Compare item details in cart with minicart
     [Arguments]  ${shipmentType}  ${size}
     Wait Until Element Is Visible    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${cart_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${cart_product_price}    Remove currency and comma from price    ${cart_product_price}
     Should Be Equal As Strings   ${cart_product_price}  ${PDP_product_1_price}
     Wait Until Element Is Visible    xpath://div[@class='line-item-primary-title']
     Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='line-item-primary-title']    ${PDP_product_1_primary_name}
     Wait Until Element Is Visible    xpath://div[@class='line-item-secondary-title']
     Run Keyword And Warn On Failure    Element Text Should Be  xpath://div[@class='line-item-secondary-title']    ${PDP_product_1_secondary_name}
     ${cart_product_quantity}  Get Element Attribute    xpath:(//input[contains(@class,'quantity js-qty')])[4]   value
     Should Be Equal As Strings    ${cart_product_quantity}    1
     Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='line-item-attributes']/span[2]    ${size}
   IF  '${shipmentType}' in ['delivery']
     Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[contains(@class,'js-cart-items-group-count cart-items-group-count')])[3]    (1 item)
   ELSE IF  '${shipmentType}' in ['pick up']
     Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[contains(@class,'js-cart-items-group-count cart-items-group-count')])[2]    (1 item)
   ELSE IF  '${shipmentType}' in ['pre order']
     Run Keyword And Warn On Failure  Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[contains(@class,'js-cart-items-group-count cart-items-group-count')])[4]    (1 item)
   END

Verify order summary in correct in cart page
     ${order_summary_subtotal_1}   Get Text    xpath:(//span[contains(@class,'sub-total')])[1]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal_1}
     ${order_summary_shipping}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[1]
     ${order_summary_salesTax}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[2]
     Should Be Equal As Strings    ${order_summary_subtotal}    ${PDP_product_1_price}
   IF  '${shopLocale}' in ['US', 'CN']
      Should Be Equal As Strings    ${order_summary_shipping}    $12
      Should Be Equal As Strings    ${order_summary_salesTax}    Calculated at checkout
   ELSE
      Should Be Equal As Strings    ${order_summary_shipping}    Free
      Should Be Equal As Strings    ${order_summary_salesTax}    Included
   END

Verify order summary is correct in cart page for VGC
     ${order_summary_subtotal_1}   Get Text    xpath:(//span[contains(@class,'sub-total')])[1]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal_1}
     ${order_summary_shipping}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[1]
     ${order_summary_salesTax}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[2]
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_subtotal}    100
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_salesTax}    Calculated at checkout

Verify order summary is correct in cart page for GC
     ${order_summary_subtotal_1}   Get Text    xpath:(//span[contains(@class,'sub-total')])[1]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal_1}
     ${order_summary_shipping}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[1]
     ${order_summary_salesTax}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[2]
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_subtotal}    2000
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_salesTax}    Calculated at checkout



Verify order summary in correct in cart page for 2 products
     ${order_summary_subtotal}   Get Text    xpath:(//span[contains(@class,'sub-total')])[1]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal}
     ${order_summary_shipping}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[1]
     ${order_summary_salesTax}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[2]
     ${total} =  Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price}
     ${order_summary_subtotal}  Convert To Integer    ${order_summary_subtotal}
     Run Keyword And Warn On Failure   Should Be Equal As Integers    ${order_summary_subtotal}    ${total}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_salesTax}    Calculated at checkout
    IF  '${shopLocale}' in ['US', 'CN']
      Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
   ELSE
      Should Be Equal As Strings    ${order_summary_shipping}    Calculated at checkout
   END

Verify order summary is correct in cart page for 2 products - EU
    ${order_summary_subtotal}   Get Text    xpath:(//span[contains(@class,'sub-total')])[1]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal}
     ${order_summary_shipping}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[1]
     ${order_summary_salesTax}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[2]
     ${total} =  Evaluate    ${PDP_product_1_price} + ${PDP_product_2_price}
     ${order_summary_subtotal}  Convert To Integer    ${order_summary_subtotal}
     Run Keyword And Warn On Failure   Should Be Equal As Integers    ${order_summary_subtotal}    ${total}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_salesTax}    Included
     Should Be Equal As Strings    ${order_summary_shipping}    Free
     
Check shipping method icon
    [Arguments]   ${method}
   IF  '${method}' in ['delivery']
    Page Should Contain Element    xpath://*[local-name()='svg' and @class='icon icon-delivery-icon icon-delivery-icon-dims ']
   ELSE IF  '${method}' in ['pick up']
     Page Should Contain Element    xpath://*[local-name()='svg' and @class='icon icon-pickup-in-store-icon icon-pickup-in-store-icon-dims ']
   ELSE IF  '${method}' in ['pre order']
     Page Should Contain Element    xpath://*[local-name()='svg' and @class='icon icon-pre-order-icon icon-pre-order-icon-dims ']
   END

Check product size in cart
   [Arguments]   ${size}
   Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='line-item-attributes']/span[2]    ${size}

Click on Checkout button from Cart page for EU
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    CommonWeb.Click by JS    xpath:(//a[@data-event-value='continue_checkout'])[1]
    Check customer care number present at checkout header

Verify whether delivery type for item is displayed in cart
    [Arguments]  ${deliveryType}
    IF  '${deliveryType}' in ['Pick up']
    Run Keyword And Warn On Failure    Element Should Contain   xpath:(//h2[@class='cart-items-group-title'])[3]  ${deliveryType} ${pickup_store}
    ELSE
    Wait Until Page Contains Element    xpath://h2[@class='cart-items-group-title' and contains(text(),'${deliveryType}')]
    Run Keyword And Warn On Failure    Element Should Contain   xpath://h2[@class='cart-items-group-title']   ${deliveryType}
    END

Compare item details in cart for ring sizer
     Wait Until Element Is Visible    xpath://div[@class='line-item-primary-title']
     Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='line-item-primary-title']         ${ringSizer_product_primary_name}
     Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='line-item-secondary-title']       ${ringSizer_product_secondary_name}
     Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='line-item-total-price-amount']    ${ringSizer_detail}

Verify order summary in correct in cart page for ring sizer
     ${order_summary_subtotal}   Get Text    xpath:(//span[contains(@class,'sub-total')])[1]
     ${order_summary_subtotal}   Remove currency and comma from price   ${order_summary_subtotal}
     ${order_summary_shipping}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[1]
     ${order_summary_salesTax}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[2]
     ${grandTotal}   Get Text   xpath:(//span[contains(@class,'grand-total')])[1]
     ${grandTotal}   Remove currency and comma from price    ${grandTotal}
     Should Be Equal As Strings    ${order_summary_subtotal}    0
     Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
     Should Be Equal As Strings    ${order_summary_salesTax}    Calculated at checkout
     Should Be Equal As Strings    ${grandTotal}                0

Click paypal checkout from cart
     Wait Until Element Is Visible    xpath:(//iframe[@title='PayPal'])[1]    timeout=10s
     Select Frame  xpath:(//iframe[@title='PayPal'])[1]
     Sleep  1s
     Click Element   xpath://div[@class='paypal-button-label-container']
     @{winHandles}=    Get Window Handles
     @{winTitles}=    Get Window Titles
     Switch Window    ${winHandles}[1]
     Wait Until Page Contains Element    ${paypal_email_l}     100s    Email field is not loaded

Check whether correct no:of products are added under group title in cart
   [Arguments]  ${groupTitle}  ${no_of_products}
   IF  '${groupTitle}' in ['delivery']
    Page Should Contain Element    xpath:(//h2[@class='cart-items-group-title'])[3]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//h2[@class='cart-items-group-title'])[3]    Delivery
   ELSE IF  '${groupTitle}' in ['pick up same store']
    Page Should Contain Element    xpath:(//h2[@class='cart-items-group-title'])[2]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//h2[@class='cart-items-group-title'])[2]   Pick Up In Store
   END
    ${products_in_cart}   Get WebElements   xpath://div[@class='line-item-header']
    ${no_of_products_in_cart_1}   Get Length    ${products_in_cart}
    ${no_of_products_in_cart}  Convert To String    ${no_of_products_in_cart_1}
    Should Be Equal As Strings    ${no_of_products_in_cart}    ${no_of_products}

Verify whether last added product is shown first in cart
    Wait Until Element Is Visible    xpath:(//div[contains(@class,'line-item-primary-title')])[1]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-primary-title')])[1]    ${PDP_product_2_primary_name}


Compare item details in cart for 2 products
     [Arguments]  ${size}   ${size2}
####First Product Details
     Wait Until Element Is Visible    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${miniCart_product_1_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
     ${miniCart_product_1_price}    Remove currency and comma from price    ${miniCart_product_1_price}
     Should Be Equal As Strings    ${PDP_product_2_price}    ${miniCart_product_1_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-item-primary-title'])[1]
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='line-item-primary-title'])[1]    ${PDP_product_2_primary_name}
     Wait Until Element Is Visible    xpath:(//div[@class='line-item-secondary-title'])[1]
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='line-item-secondary-title'])[1]    ${PDP_product_2_secondary_name}
     Wait Until Element Is Visible  xpath:(//div[@class='line-item-attributes']/span[2])[1]
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='line-item-attributes']/span[2])[1]    ${size2}
     Wait Until Element Is Visible    xpath:(//input[contains(@class,'quantity js-qty')])[4]
     ${item_quantity_1}    Get Element Attribute    xpath:(//input[contains(@class,'quantity js-qty')])[4]    value
     Should Be Equal    ${item_quantity_1}    1
####Second Product Details
     ${miniCart_product_2_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[3]
     ${miniCart_product_2_price}    Remove currency and comma from price    ${miniCart_product_2_price}
     Should Be Equal As Strings    ${PDP_product_1_price}    ${miniCart_product_2_price}
     Wait Until Element Is Visible    xpath:(//div[@class='line-item-primary-title'])[2]
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='line-item-primary-title'])[2]    ${PDP_product_1_primary_name}
     Wait Until Element Is Visible    xpath:(//div[@class='line-item-secondary-title'])[2]
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='line-item-secondary-title'])[2]    ${PDP_product_1_secondary_name}
     Wait Until Element Is Visible  xpath:(//div[@class='line-item-attributes']/span[2])[2]
     Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[@class='line-item-attributes']/span[2])[2]    ${size}
     Wait Until Element Is Visible    xpath:(//input[contains(@class,'quantity js-qty')])[8]
     ${item_quantity_2}    Get Element Attribute    xpath:(//input[contains(@class,'quantity js-qty')])[8]    value
     Should Be Equal    ${item_quantity_2}    1

Check virtual gift card details in cart
     IF  '${shopLocale}' in ['US']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]    US Virtual Gift Card
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    Country: US
     ELSE IF  '${shopLocale}' in ['CN']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]    CA Virtual Gift Card
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    Country: CA
     END
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[1]    Gift Card Type: Virtual
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[3]    Recipient: ${GiftCard_Recipient_FirstName} (${GiftCard_Recipient_Email})
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[4]    Sender: ${GiftCard_Sender_Name}

Check physical gift card details in cart
     IF  '${shopLocale}' in ['US']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]    $2000 Gift Card
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    Country: US
     ELSE IF  '${shopLocale}' in ['CN']
        Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[contains(@class,'line-item-primary-title')]    C$2000 Gift Card
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[2]    Country: CA
     END
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//div[contains(@class,'line-item-attributes')])[1]    Gift Card Type: Physical
        
Check prepopulated VGC fields
    ${reciepient_name}   Get Value    xpath://input[@name='giftRecipient']
    Should Be Equal As Strings    ${reciepient_name}    ${GiftCard_Recipient_FirstName} ${GiftCard_Recipient_LastName}
    ${senders_name}   Get Value    xpath://input[@name='giftSenders']
    Should Be Equal As Strings    ${senders_name}    ${GiftCard_Sender_Name}

Validate invalid login from checkout page
    Enter login credentials during checkout    testdummy@gmail.com    google@123
    Click on Sign In button during checkout
    Sleep  2s
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='customer-error']/div    Invalid login or password. Remember that password is case-sensitive. Please try again.

Check whether correct no:of products are added under group title in cart for mixed cart delivery and bopis
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//h2[@class='cart-items-group-title'])[2]    Pick Up In Store
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[@class='js-cart-items-group-count cart-items-group-count'])[2]    (1 item)
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//h2[@class='cart-items-group-title'])[3]    Delivery
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//span[@class='js-cart-items-group-count cart-items-group-count'])[3]    (1 item)