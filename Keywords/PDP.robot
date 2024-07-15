*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/PLP.robot
Resource          ../Keywords/Search.robot
Resource          ../Keywords/DataReader.robot

*** Keywords ***
Open PDP for product with id
    [Arguments]    ${id}
    Go To    ${URL}${id}.html
    Wait Until Element Is Visible    ${pdp_product_name_l}    3s    error=Product Name is not visible

Select Size
    [Arguments]    ${size}
    Click by JS    //*[contains(@data-attr-value,'${size}')]
    Wait Until Page Contains Element    ${pdp_selected_size_l}     10s    error=Size is not visible
    Sleep  3s


Select Color
    [Arguments]    ${color}
    Click Element    css:button[aria-label*='${color}']
    Wait Until Page Contains Element    ${pdp_selected_size_l}     10s    error=Size is not visible

Click Add To Cart Button from PDP
    Scroll To Element    ${pdp_add_to_cart_l}
    Scroll And Click by JS    ${pdp_add_to_cart_l}
    Verify Minicart modal is displayed

Click Add To Cart from wishlist minicart
    Scroll To Element    ${pdp_add_to_cart_l}
    Scroll And Click by JS    ${pdp_add_to_cart_l}
    Verify minicard modal display from Move to bag

Verify minicard modal display from Move to bag
    Wait Until Element Is Visible    //*[contains(@class,'product-quickview-wrapper')]  5s

Click Preorder Button from PDP
    Wait until underlay dissapears
    Scroll And Click by JS    xpath://button[text()='Pre-order']
    Verify Minicart modal is displayed

Wait until underlay dissapears
    Wait Until Page Contains Element    ${pdp_add_to_cart_l}     10s    error=Add To Cart is not loaded
    Wait Until Element Is Visible    ${pdp_add_to_cart_l}     10s    error=Add To Cart is not visible
    Wait Until Page Does Not Contain Element    ${pdp_underlay_l}    10s    error=Underlay is still visible

Verify Minicart modal is displayed
    Wait Until Page Contains Element    ${pdp_minicart_l}     50s    error=Minicart is not visible
    #Wait Until Element Is Visible    ${pdp_minicart_l}     10s    error=Minicart is not visible

Check that the button label is Pre-Order
    Wait until underlay dissapears
    Run Keyword And Continue On Failure    Element Text Should Be    ${pdp_add_to_cart_l}    PRE-ORDER

Add multiple products to the cart
    [Arguments]    @{products_with_sizes}
    FOR    ${product_with_size}    IN    @{products_with_sizes}
        ${split_product_with_size}=    Evaluate    $product_with_size.split('=')
        ${product_id}=    Set Variable    ${split_product_with_size[0]}
        ${size}=    Set Variable    ${split_product_with_size[1]}
        Search for a product from header search  ${product_id}
        Click search icon from header search
        Close the Get the First Look modal
        Open the Product from PLP product list  1
        Close the Get the First Look modal
        Select Size    ${size}
        Click Add To Cart Button from PDP
        Close the minicart
    END

Navigate to Category
    [Arguments]    ${category}
    Mouse Over    css:#${category}
    Wait Until Page Contains Element    css:#${category}+button+.mega-menu.show     5s    error=Category is not loaded
    Wait Until Element Is Visible    css:#${category}+button+.mega-menu.show     5s    error=Category is not visible
    Set Test Variable    ${category}

Navigate to Subcategory
    [Arguments]    ${subcategory}
    Mouse Over    css:#${category}-${subcategory}
    Wait Until Page Contains Element    css:.show [aria-label='${category}'] li:nth-child(1).dropdown-item.level-2     5s    error=Category is not loaded
    Wait Until Element Is Visible    css:.show [aria-label='${category}'] li:nth-child(1).dropdown-item.level-2     5s    error=Category is not visible

    Set Test Variable    ${subcategory}

Click on Subcategory
    Click Element    css:#${category}-${subcategory}
    Page should not contain null or NA

Navigate and click on Subcategory
    [Arguments]    ${subcategory}
    Navigate to Subcategory    ${subcategory}
    Click on Subcategory

Navigate to l3 subcategory
    [Arguments]    ${l3subcategory}
    Wait Until Element Is Visible    css:.dropdown-menu [href*='/${category}/${subcategory}/${l3subcategory}-${subcategory}.html']    5s    error=Category is not visible
    Mouse Over    css:.dropdown-menu [href*='/${category}/${subcategory}/${l3subcategory}-${subcategory}.html']
    Click Element    css:.dropdown-menu [href*='/${category}/${subcategory}/${l3subcategory}-${subcategory}.html']
    Page should not contain null or NA

Navigate to subcategory in high-jewelry
    [Arguments]  ${subcategory}
    Mouse Click   id=${subcategory}

Click on Wish icon from PDP
    CommonWeb.Scroll And Click by JS    ${pdp_wish_icon_l}
    sleep  2s

Check if PDP is displayed correctly (general information, buttons, tabs, price)
     Element Text Should Be       ${pdp_add_to_cart_l}           ${pdp_add_to_cart_exp}
     Element Text Should Be       ${pdp_customer_care_l}         ${pdp_customer_care_exp}
     Element Should Be Visible    ${pdp_complimentary_links_l}
     Element Text Should Be       ${pdp_designer_note_l}         ${pdp_designer_note_exp}
     Element Text Should Be       ${pdp_care_l}                  ${pdp_care_exp}
     Element Text Should Be       ${pdp_gifting_l}               ${pdp_gifting_exp}

Compare the price from PLP to the one from PDP
    ${range_avalable}    Run Keyword And Return Status    Wait Until Element Is Visible    ${pdp_price_range_l}    5s    Price range is not visible
    IF    "${range_avalable}" == "True"
        ${pdp_product_price}    Get Text    ${pdp_price_range_l}
        ${pdp_product_price}    Remove String    ${pdp_product_price}  ${SPACE}
    ELSE
        ${pdp_product_price}    Get Text    ${pdp_price_value_l}
        ${pdp_product_price}    Remove String    ${pdp_product_price}  ${SPACE}
    END
    Should Contain    ${plp_product_price}    ${PDP_product_1_price}

Save the product subtitle on PDP
    ${product_name_subtitle}    Get Text    ${pdp_product_subtitle_l}
    Set Test Variable    ${product_name_subtitle}

Save the product title on PDP
    ${product_name_title}    Get Text    ${pdp_product_name_l}
    Set Test Variable    ${product_name_title}

Check if a product with variations is displayed correctly
    Wait Until Element Is Visible    ${pdp_variant_l}
    ${total_variants}    Get Element Count    ${pdp_variant_title_l}
    FOR    ${nr}    IN RANGE    1    ${total_variants}+1
        Mouse Over    css:.attribute-variants-pdp [data-secondarytitle]:nth-child(${nr})
        ${variant_title}    Get Element Attribute    css:.attribute-variants-pdp [data-secondarytitle]:nth-child(${nr})    data-secondarytitle
        Save the product subtitle on PDP
         Should Be Equal As Strings    ${product_name_subtitle}    ${variant_title}
    END

Check if a product with no stock is displayed correctly
  IF  '${shopLocale}' in ['US', 'CN']
     Wait Until Element Is Visible    ${pdp_notify_me_btn_l}     10s    Notify Me button is not visible
     Element Text Should Be    ${pdp_notify_me_btn_l}    ${pdp_notify_me_btn_exp}
  ELSE
     Wait Until Element Is Visible    xpath://button[text()='Out of Stock']
     Element Text Should Be    xpath://button[text()='Out of Stock']   OUT OF STOCK
  END

Click on Notify Me button
    Click Element    ${pdp_add_to_cart_l}
    Wait Until Page Contains Element    ${pdp_notify_me_title_l}    5s    Notify Me button is not loaded
    Wait Until Element Is Visible    ${pdp_notify_me_title_l}    5s    Notify Me button is not visible
     Element Text Should Be    ${pdp_notify_me_title_l}    ${pdp_notify_me_title_exp}

Fill in the Notify Me form
    [Arguments]    ${fn}    ${ln}    ${mail}
    Input Text    ${pdp_notify_me_fn_l}    ${fn}
    Input Text    ${pdp_notify_me_ln_l}    ${ln}
    Input Text    ${pdp_notify_me_mail_l}    ${mail}
    Wait Until Page Contains Element    ${pdp_notify_me_mail_fill_l}     5s    error=Submit button is not activated

Submit the Notify Me form and check the result
    Scroll To Element    ${pdp_notify_me_l}
    Sleep  1s
    Click by JS    ${pdp_notify_me_l}
    Wait Until Element Is Visible    ${pdp_notify_me_msg_l}     20s    error=Notify Me modal is not yet closed
     Element Text Should Be    ${pdp_notify_me_msg_l}    ${pdp_notify_me_msg_exp}

Click on Contact Customer Care button from PDP
#    Scroll To Element    ${pdp_customer_care_l}
    Click Element    ${pdp_customer_care_l}
    Wait Until Element Is Visible    ${pdp_customer_care_title_l}     10s    error=We’re here to help modal is not yet opened

Close the Contact Customer Care modal
    Click Element    ${pdp_customer_care_close_l}
    Wait Until Element Is Not Visible    ${pdp_customer_care_title_l}     10s    error=We’re here to help modal is not yet closed

Click on Size Guide button from PDP
    Click Element    ${pdp_size_guide_l}
    Wait Until Element Is Visible    ${pdp_size_guide_title_l}    10s    error=Find the Perfect Fit modal is not yet opened

Close the Size Guide modal
    Click Element    ${pdp_size_guide_close_l}
    Wait Until Element Is Not Visible    ${pdp_size_guide_title_l}    10s    error=Find the Perfect Fit modal is not yet opened

Capture the product price from PDP
    ${product_price_from_pdp}    Get Text    ${pdp_price_value_l}
    ${product_price_pdp}    Set Test Variable    \${product_price_from_pdp}

Click on image nr from PDP image gallery
    [Arguments]    ${open_img}
    Click Element    css:.pdp-img-container:nth-child(${open_img}) a img
    Wait Until Element Is Visible    ${pdp_open_image_l}    10s    error=PDP image is not visible
    ${img_total}    Get Element Count    ${pdp_total_image_l}
    Set Test Variable    ${img_total}
    Set Test Variable    ${open_img}

Swipe to last image (on PDP image gallery)
    FOR    ${img}    IN RANGE    ${open_img}    ${img_total}
        Click Element    ${pdp_img_next_arrow_l}
        ${current_img}=    Evaluate    ${img}+1
         Element Text Should Be    ${pdp_img_counter_l}    ${current_img} / ${img_total}
    END

Click on Zoom icon from PDP image gallery
    Click Element    ${pdp_img_zoom_l}
    Wait Until Page Contains Element    ${pdp_img_zoom_in_l}    10s    error=Image is not zoomed in

Click on Close icon from PDP image gallery
    Click Element    ${pdp_img_close_l}
    Wait Until Element Is Not Visible    ${pdp_img_close_l}    10s    error=Close icon is still visible

Click on Pick up at David Yurman boutique
    Click Element    ${pdp_pickup_store_btn_l}
    Wait Until Element Is Visible    ${pdp_pickup_store_close_l}    10s    error=Pick Up modal is not visible

Fill in the Zip and Distance on Pickup In Store modal
    [Arguments]    ${zip}    ${distance}
    Input Text    ${pdp_pickup_store_zip_l}    ${zip}
    Click Element    ${pdp_pickup_store_dist_l}
    Wait Until Page Contains Element    ${pdp_pickup_store_drop_l}    10s    error=Distance list is not visible
    Click Element    xpath://div[contains(@class, 'selectric-open')]//li[contains(.,'${distance}')]

Click on Search from Pickup In Store modal
    Click Element    ${pdp_pickup_store_search_l}
    Wait Until Element Is Visible    ${store_locator_available_store}    10s    error=Stores list is not visible

Click on Select This Store for available store nr
    [Arguments]    ${store_no}
    ${store_total}    Get Element Count    ${pdp_pickup_store_list_l}
    ${modal_store_title}    set variable    ""
    FOR    ${i}    IN RANGE    1    ${store_total}+1
        ${select_visible}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://div[contains(@class, 'mx-0')][${i}]//button[contains(.,'Select This Store')]    10s
        IF    "${select_visible}" == "True"
            ${modal_store_title}    Get Text    xpath://div[contains(@class, 'mx-0')][${i}]//span[contains(@class, 'title')]
            Click Element    xpath://div[contains(@class, 'mx-0')][${i}]//button[contains(.,'Select This Store')]
            Wait Until Element Is Not Visible    ${pdp_pickup_store_close_l}    10s    error=Pick Up modal is not visible
        END
    END
    Set Test Variable    ${modal_store_title}

Check that the selected store appears on PDP pick up
    Wait Until Element Is Visible    ${pdp_selected_store_l}    10s    error=Pick Up store name is not visible
     Element Text Should Be    ${pdp_selected_store_l}    ${modal_store_title}

Verify the You May Also Like carousel
     Element Text Should Be    ${pdp_ymal_title_l}    ${pdp_ymal_title_us_exp}
     Element Should Be Visible    ${pdp_ymal_carousel_l}

Verify the Explore More From This Collection carousel
     ${status}  Run Keyword And Return Status  Element should be visible  ${pdp_emftc_carousel_l}
     IF  ${status}
       Element Text Should Be    ${pdp_emftc_title_l}    ${pdp_emftc_title_us_exp}
       Element Should Be Visible    ${pdp_emftc_carousel_l}
     ELSE
       Log To Console  EMFT carousel not found as recommendation page is loaded
     END

Verify the Recently Viewed carousel
    ${status}  Run Keyword And Return Status  Element should be visible  ${pdp_rv_carousel_l}
    IF  ${status}
      Element Should Be Visible  ${pdp_rv_carousel_l}
    ELSE
      Log To Console  Recently Viewed carousel not found as not more than 4 products viewed recently
    END

Verify the Trending Now carousel
     Element Text Should Be    ${pdp_trend_now_l}    ${pdp_trend_now_us_exp}
     Element Should Be Visible    ${pdp_trend_now_carousel_l}

Check that badge is displayed on PDP
     Wait Until Element Is Visible    ${pdp_badge_l}    10s    error=Badge is not visible
     Element Text Should Be    ${pdp_badge_l}    ${pdp_badge_exp}

Select available store at
    [Arguments]    ${zip_code}
    CommonWeb.Check and Input text          ${store_locator_zipcode}            ${zip_code}
    CommonWeb.Check and Click               ${store_locator_distance_btn}
    CommonWeb.Check and Click               ${store_locator_distance_list}
    CommonWeb.Check and Click               ${store_locator_search_btn}
    Wait Until Element Is Visible           ${store_locator_available_store}             timeout=10s        error=Store not Available at ${zip_code}
    ${bopis_storeName}  Get Text   xpath:(//button[@data-store-type='BOUTIQUE'])[1]//parent::div//preceding-sibling::div/span[1]
    ${bopis_storeDetails}  Get Text   xpath:(//button[@data-store-type='BOUTIQUE'])[1]//parent::div//preceding-sibling::div/span[3]
    Set Global Variable    ${bopis_storeName}
    Set Global Variable    ${bopis_storeDetails}
    CommonWeb.Scroll And Click by JS        xpath:(//button[@data-store-type='BOUTIQUE'])[1]
    CommonWeb.Scroll To Top
    sleep  5s
#    Wait Until Page Contains Element  //*[contains(@class,'pickup-in-store-link')]  5s

Select available store for second product at
    [Arguments]    ${zip_code}
    CommonWeb.Check and Input text          ${store_locator_zipcode}            ${zip_code}
#    CommonWeb.Check and Click               ${store_locator_distance_btn}
#    CommonWeb.Check and Click               ${store_locator_distance_list}
    CommonWeb.Check and Click               ${store_locator_search_btn}
    Wait Until Element Is Visible           ${store_locator_available_store}             timeout=10s        error=Store not Available at ${zip_code}
    ${bopis_storeName_2}  Get Text   xpath:(//button[@data-store-type='BOUTIQUE'])[2]//parent::div//preceding-sibling::div/span[1]
    ${bopis_storeDetails_2}  Get Text   xpath:(//button[@data-store-type='BOUTIQUE'])[2]//parent::div//preceding-sibling::div/span[3]
    Set Global Variable    ${bopis_storeName_2}
    Set Global Variable    ${bopis_storeDetails_2}
    Click by JS        xpath:(//button[@data-store-type='BOUTIQUE'])[2]
    sleep  5s
    CommonWeb.Scroll To Top


Open BOPIS modal
    Scroll To Element    ${store_pickup_button}
    Scroll And Click by JS       ${store_pickup_button}
    Wait Until Element Is Visible         ${bopis_modal}             timeout=20s        error=BOPIS Modal is not visible

Close BOPIS modal   
    Scroll And Click by JS    xpath://div[contains(@class,'bopisModal')]//button[@data-dismiss='modal']
     
Select Address Pickup
    Scroll Element Into View    ${address_pickup_button}
    Click Element                         ${address_pickup_button}
    Wait Until Element Is Enabled           ${address_pickup_button}        timeout=5s

Wait Until Minibag is Close
    Wait Until Element is not Visible       ${minicart_modal}         timeout=5s


Click size guide
   Wait Until Page Contains Element    xpath://a[@data-target='#sizeChartModal1']
   Scroll And Click by JS    xpath://a[@data-target='#sizeChartModal1']
   Check whether size guide is opened
   
Check whether size guide is opened
    Run Keyword And Warn On Failure  Wait Until Page Contains Element    xpath:(//div[@class='modal-content'])[1]
    Run Keyword And Warn On Failure  Wait Until Page Contains Element    xpath://div[contains(@class,'select-size')]/button
   
Close size guide
    Scroll Element Into View    xpath:(//button[@aria-label='Close'])[1]
    Click Element    xpath:(//button[@aria-label='Close'])[1]
    
Check pdp bread crumbs are displayed
    [Arguments]   ${category}  ${subcategory}
    Element Should Be Visible    xpath://ol[@class='breadcrumb']
    Element Should Contain        xpath:(//li[@class='breadcrumb-item'])[1]     Home
    ${text1}  Replace String    ${category}    '    ’
    Element Should Contain       xpath:(//li[@class='breadcrumb-item'])[2]     ${text1}
    ${text2}  Replace String    ${subcategory}    '    ’
    Element Should Contain       xpath:(//li[@class='breadcrumb-item'])[3]     ${text2}

Check gift card bread crumbs are displayed
    [Arguments]
    Element Should Be Visible    xpath://ol[@class='breadcrumb']
    Element Should Contain        xpath:(//li[@class='breadcrumb-item'])[1]     Home
    Element Should Contain       xpath:(//li[@class='breadcrumb-item'])[2]     Gift Cards


Check whether image gallery is displayed
   Element Should Be Visible    xpath://div[@class='product-carousel pdp-product-carousel js-image-gallery']

Check if product name and sub title is displayed
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://span[@class='product-name--title js-primary-title']
   Run Keyword And Warn On Failure   Element Text Should Not Be     xpath://span[@class='product-name--title js-primary-title']   ${EMPTY}
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://span[@class='product-name--subtitle js-secondary-title']
   Run Keyword And Warn On Failure   Element Text Should Not Be     xpath://span[@class='product-name--subtitle js-secondary-title']   ${EMPTY}

Check if product price is displayed
  ${range_available}    Run Keyword And Return Status    Wait Until Element Is Visible    ${pdp_price_range_l}    5s    Price range is not visible
   IF    "${range_available}" == "True"
        Run Keyword And Warn On Failure   Page Should Contain Element     xpath:(//span[@class='value'])[3]
        Run Keyword And Warn On Failure   Page Should Contain Element     xpath:(//span[@class='value'])[4]
        Run Keyword And Warn On Failure   Element Text Should Not Be     xpath:(//span[@class='value'])[3]   ${EMPTY}
        Run Keyword And Warn On Failure   Element Text Should Not Be     xpath:(//span[@class='value'])[4]   ${EMPTY}
   ELSE
        Run Keyword And Warn On Failure   Page Should Contain Element     xpath:(//span[@class='value'])[2]
        Run Keyword And Warn On Failure   Element Text Should Not Be     xpath:(//span[@class='value'])[2]   ${EMPTY}
   END
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath:(//span[@class='value'])[2]


Check if size selector is displayed
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://div[contains(@class,'select-size')]
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://h2[@class='pdp-link-tag']/label    Size

Check if add to cart button is displayed
   Wait Until Page Contains Element    xpath://button[contains(@class,'add-to-cart')]
   ${status}  Run Keyword And Return Status  Element Should Contain    xpath://button[contains(@class,'add-to-cart')]       ADD TO BAG
    IF  ${status}
        log to console  Add to card button is visible
    ELSE IF  ${status}
        Element Should Contain    xpath://button[contains(@class,'add-to-cart')]       OUT OF STOCK
    END

Check if add to wishlist list button is displayed
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://button[contains(@class,'add-to-wish-list')]
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://button[contains(@class,'add-to-wish-list')]//*[name()='svg']

Check if contact customer care button is displayed
   Run Keyword And Warn On Failure   Wait Until Page Contains Element    xpath://a[contains(@class,'customer-care-btn')]
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://a[contains(@class,'customer-care-btn')]    CONTACT CUSTOMER CARE
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://p[contains(@class,'customer-care-copy')]   We’re here to help with style advice, a second opinion, or finding your perfect size.

Verify complimentary link if GWP enabled
     ${status}  =  Run Keyword And Return Status  Wait Until Page Contains Element    //a[contains(@data-content,'shipping') and contains(text(),'Complimentary 2-day shipping')]  3s
     Run Keyword If  ${status}
       log to console  Complimentary 2 days since GWP not enabled
     ELSE
       Wait Until Page Contains Element    //a[contains(@data-content,'shipping') and contains(text(),'Complimentary Overnight shipping')]  10s
     END


Check if complimentary links are displayed
  IF  '${shopLocale}' in ['US']

     Wait Until Page Contains Element    //a[contains(@data-content,'returns') and contains(text(),'Complimentary 30-day returns')]  10s
    #Element Text Should Be    xpath://a[contains(@data-content,'30-day-returns')]  Complimentary 30-day returns
     Wait Until Page Contains Element    //a[contains(@data-content,'boutique') and contains(text(),'Complimentary boutique pick up')]  10s
    #Run Keyword And Warn On Failure   Element Text Should Be    xpath://a[contains(@data-content,'complimentary-boutique-pick-up')]   Complimentary boutique pick up
  ELSE IF  '${shoplocale}' in ['CN']
     Wait Until Page Contains Element    //a[contains(@data-content,'shipping') and contains(text(),'Complimentary shipping')]  10s
     Wait Until Page Contains Element    //a[contains(@data-content,'returns') and contains(text(),'Complimentary 30-day returns')]  10s
     Wait Until Page Contains Element    //a[contains(@data-content,'boutique') and contains(text(),'Complimentary boutique pick up')]  10s
  ELSE
     Wait Until Page Contains Element    //a[contains(@data-content,'shipping') and contains(text(),'Free shipping')]  10s
#     Element Text Should Be    xpath://a[contains(@data-content,'two-day-shipping')]   Free shipping
     Wait Until Page Contains Element    //a[contains(@data-content,'returns') and contains(text(),'Free 14-day returns')]  10s
#     Element Text Should Be    xpath://a[contains(@data-content,'30-day-returns')]  Free 14-day returns
  END
  
Check if details section is displayed
   Wait Until Page Contains Element    //button[@data-target='#designerNotes' and contains(text(),'Details')]  10s
#   Element Text Should Be    xpath://button[@data-target='#designerNotes']    Details

Check if Details is opened is default
   Wait Until Page Contains Element    xpath://button[@data-target='#designerNotes' and @class='btn btn-link js-btn-accordion']  10s

Check if care section is displayed
   Wait Until Page Contains Element    //button[@data-target='#detailsAndCare' and contains(text(),'Care')]  10s
#   Element Text Should Be    xpath://button[@data-target='#detailsAndCare']   Care

Check if Gem stone care and metal care are diplayed in care section
   Wait Until Page Contains Element    xpath://button[@data-target='#detailsAndCare']  10s
   Scroll And Click by JS    //button[@data-target='#detailsAndCare']
   Element Should Contain    xpath:(//h6[@class='product-details-label'])[1]     Metal Care
   Set Focus To Element  xpath:(//h6[@class='product-details-label'])[2]
   sleep  2s
#   Scroll Element Into View   xpath:(//h6[@class='product-details-label'])[2]
   Element Should Contain    xpath:(//h6[@class='product-details-label'])[2]     Gemstone Care



Check if gifting section is displayed
   Wait Until Page Contains Element    xpath://button[@data-target='#gifting' and contains(text(),'Gifting')]  10s
#   Element Text Should Be    xpath://button[@data-target='#gifting']   Gifting

Check if deliver to address radio button is displayed
   Wait Until Page Contains Element    //div[contains(@class,'address-pickup-btn') and contains(text(),'Deliver to address')]  10s
#   Run Keyword And Warn On Failure  Element Text Should Be   xpath://div[contains(@class,'address-pickup-btn')]   Deliver to address

Click deliver to address radio button
   Wait Until Page Contains Element    xpath://div[contains(@class,'address-pickup-btn')]
   Click Element   xpath://div[contains(@class,'address-pickup-btn')]

Check if deliver to address radio button is selected by default
   Wait Until Page Contains Element    xpath://div[contains(@class,'address-pickup-btn selected ')]

Check if pickup from boutique radio button is displayed
   Wait Until Page Contains Element    xpath://div[contains(@class,'pickup-in-store-btn')]
   Scroll Element Into View    xpath://div[contains(@class,'pickup-in-store-btn')]
   Element Text Should Be   xpath://div[contains(@class,'pickup-in-store-btn')]   Pick up at David Yurman boutique


Check Info Texts in PDP
    Scroll To Bottom
    Sleep  3s
    Element Text Should Be    xpath:(//a[@data-content='two-day-shipping'])[2]   ${checkout_info_2day_shipping_message}
    CommonWeb.Check and Click    xpath:(//a[@data-content='two-day-shipping'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_2day_shipping_title}
    ${2DayText}  Get Text    xpath://div[@class='order-summary-content']
    Should Contain Text    ${2DayText}   ${checkout_info_2day_shipping_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible

    Scroll To Element    xpath:(//a[@data-content='30-day-returns'])[2]
    Element Text Should Be    xpath:(//a[@data-content='30-day-returns'])[2]   ${checkout_info_30day_returns_title}
    CommonWeb.Check and Click    xpath:(//a[@data-content='30-day-returns'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_30day_returns_title}
    ${30DayText}  Get Text    xpath://div[@class='order-summary-content']
    Should Contain Text    ${30DayText}   ${checkout_info_30day_returns_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible

  IF  '${shopLocale}' in ['US', 'CN']
    Scroll To Element    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]
    Element Text Should Be    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]   ${checkout_info_boutique_pick_up_title}
    CommonWeb.Check and Click    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_boutique_pick_up_title}
    ${boutiqueText}  Get Text    xpath://div[@class='order-summary-content']
    Should Contain Text    ${boutiqueText}   ${checkout_info_boutique_pickup_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible
  END

Check currency of product price in PDP
    ${range_available}    Run Keyword And Return Status    Wait Until Element Is Visible    ${pdp_price_range_l}    5s    Price range is not visible
   IF    "${range_available}" == "True"
        ${pdp_product_price}    Get Text    ${pdp_price_range_l}
   ELSE
        ${pdp_product_price}    Get Text    ${pdp_price_value_l}
   END
   IF  '${shopLocale}' in ['US']
     Should Contain    ${pdp_product_price}    $
   ELSE IF  '${shopLocale}' in ['CN']
     Should Contain    ${pdp_product_price}    C$
   ELSE IF  '${shopLocale}' in ['UK']
     Should Contain    ${pdp_product_price}    £
   ELSE IF  '${shopLocale}' in ['IT','GR','FR']
     Should Contain    ${pdp_product_price}    €
   END

Compare size displayed in PDP and size guide
    ${pdp_size_count}  Get Element Count    xpath://div[contains(@class,'select-size')]/button
    @{pdp_sizes}     Get WebElements    xpath://div[contains(@class,'select-size')]/button
    ${size_guide_size_count}  Get Element Count    xpath://div[contains(@class,'size-chart-button')]
    @{size_guide_sizes}  Get WebElements    xpath://div[contains(@class,'size-price')]/span[1]
    Should Be Equal    ${pdp_size_count}    ${size_guide_size_count}

Click contact customer care button
    Scroll And Click by JS    xpath://a[contains(text(),'Contact Customer Care')]
    
Close contact customer care slide out
   Scroll And Click by JS    xpath://div[@id='customerCareModal']//button[@data-dismiss]

Close customer care service modal
  Scroll And Click by JS    xpath:(//button[@class='close customer-service-close'])[1]

Check contact customer care modal details
   Wait Until Page Contains Element  //*[contains(@class,'modal-body')]//h2[@class='customer-care-title']  10s
   sleep  3s
   Run Keyword And Warn On Failure   Element Text Should Be    //*[contains(@class,'modal-body')]//h2[@class='customer-care-title']    We’re here to help
#   Element Text Should Be    xpath://h2[@class='customer-care-title']                                  We’re here to help
   Element Text Should Be    xpath://div[@class='customer-care-text']//div[@class='content-asset']     From finding the perfect gift to jewelry styling or size advice, our Customer Care Specialists are always here to help.
   Element Text Should Be    xpath://*[contains(@class,'icon-appointment')]/parent::*             Book an Appointment
   Element Text Should Be    xpath://div[@class='opening-hours']//p[@class='opening-hours-title']      Hours of Operation
  IF  '${shopLocale}' in ['US','CN']
   Element Text Should Be    xpath://*[contains(@class,'customer-care-email-btn')]                E-mail • customercare@davidyurman.com
   IF  '${shoplocale}' in ['US']
     Element Text Should Be    //*[contains(@class,'call icon')]/parent::*             Call • 1-888-398-7626
   ELSE
     Element Text Should Be    //*[contains(@class,'call icon')]/parent::*             Call 1-833-211-2442
   END
   Element Text Should Be    xpath:(//div[@class='opening-hours']//p[@class='opening-hours-line'])[1]  Monday-Friday: 8:30AM-7:30PM ET
   Element Text Should Be    xpath:(//div[@class='opening-hours']//p[@class='opening-hours-line'])[2]  Saturday & Sunday: 9:00AM-5:00PM ET
  ELSE
   Element Text Should Be    xpath://*[contains(@class,'customer-care-email-btn')]                E-mail • CustomerCareEurope@davidyurman.com
   Element Text Should Be    //*[contains(@class,'call icon')]/parent::*             Call • (+33) 1 73 03 06 80
   Element Text Should Be    xpath:(//div[@class='opening-hours']//p[@class='opening-hours-line'])[1]  Monday-Saturday: 11:00AM-7:00PM CET
   Element Text Should Be    xpath:(//div[@class='opening-hours']//p[@class='opening-hours-line'])[2]  Sunday: 12:00PM-6:00PM CET
  END

Click email customer care button
   Scroll And Click by JS    xpath://*[contains(@class,'customer-care-email-btn')]
   sleep  2s
   Wait Until Page Contains Element    xpath:(//h2[contains(@class,'customer-service-email')])[1]
   Wait Until Page Contains Element    xpath://input[@name='dwfrm_customerService_customerService_firstName']

Check email customer care modal details
   Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//h2[contains(@class,'customer-service-email')])[1]    Email Customer Care
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://input[@name='dwfrm_customerService_customerService_firstName']//parent::div/label/span            First Name
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://input[@name='dwfrm_customerService_customerService_lastName']//parent::div/label/span             Last Name
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://input[@name='dwfrm_customerService_customerService_email']//parent::div/label/span                Email
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://input[@name='dwfrm_customerService_customerService_emailConfirm']//parent::div/label/span         Confirm Email Address
   Run Keyword And Warn On Failure   Element Text Should Be         xpath:(//div[@class='selectric'])[1]/span                                                            General Inquiry
   Run Keyword And Warn On Failure   Element Text Should Be         xpath://input[@name='dwfrm_customerService_customerService_productName']//parent::div/label/span     Product Name and Style number
   Run Keyword And Warn On Failure   Element Text Should Be         xpath://textarea[@name='dwfrm_customerService_customerService_message']//parent::div/label/span      Message
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://input[@id='customerSericeEmailSignupCheckbox']
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://input[@id='customerSericeEmailSignupCheckbox']//parent::div//span                                 Sign up to receive email updates from David Yurman about the latest collections and news. You can unsubscribe at any time at no cost. See our Privacy Policy for details.
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://input[@id='customerSericeEmailSignupCheckbox']//parent::div//span/a                               Privacy Policy
   Run Keyword And Warn On Failure   Element Text Should Be    xpath://button[@id='btnCustomService']    SUBMIT

Check email customer care negative validations
   Clear Element Text    xpath://input[@name='dwfrm_customerService_customerService_firstName']
   Clear Element Text    xpath://input[@name='dwfrm_customerService_customerService_lastName']
   Clear Element Text    xpath://input[@name='dwfrm_customerService_customerService_email']
   Clear Element Text    xpath://input[@name='dwfrm_customerService_customerService_emailConfirm']
   Click Element    xpath://button[@id='btnCustomService']
   sleep  3s
   Run Keyword And Warn On Failure  Element Text Should Be    xpath://input[@name='dwfrm_customerService_customerService_firstName']//parent::div//div[@class='invalid-feedback']      Please enter your first name.
   Run Keyword And Warn On Failure  Element Text Should Be    xpath://input[@name='dwfrm_customerService_customerService_lastName']//parent::div//div[@class='invalid-feedback']       Please enter your last name.
   Run Keyword And Warn On Failure  Element Text Should Be    xpath://input[@name='dwfrm_customerService_customerService_email']//parent::div//div[@class='invalid-feedback']          Please enter a valid email address.
   Run Keyword And Warn On Failure  Element Text Should Be    xpath://input[@name='dwfrm_customerService_customerService_emailConfirm']//parent::div//div[@class='invalid-feedback']   Please enter a valid email address.

Fill and submit email customer care form with reason and signup
   [Arguments]   ${reason}  ${signup}
   Clear Element Text    xpath://input[@name='dwfrm_customerService_customerService_firstName']
   Clear Element Text    xpath://input[@name='dwfrm_customerService_customerService_lastName']
   Clear Element Text    xpath://input[@name='dwfrm_customerService_customerService_email']
   Clear Element Text    xpath://input[@name='dwfrm_customerService_customerService_emailConfirm']
   Check and Input text  xpath://input[@name='dwfrm_customerService_customerService_firstName']   ${FIRST_NAME}
   Check and Input text    xpath://input[@name='dwfrm_customerService_customerService_lastName']  ${LAST_NAME}
   Check and Input text    xpath://input[@name='dwfrm_customerService_customerService_email']     ${guest_valid}
   Check and Input text    xpath://input[@name='dwfrm_customerService_customerService_emailConfirm']  ${guest_valid}
   IF  '${shoplocale}' in ['US']
    Scroll And Click by JS    (//*[@class='modal-body']//*[contains(@class,'form-group')])[5]//select
    Click by JS    (//*[@class='modal-body']//*[contains(@class,'form-group')])[5]//select//*[@value='${reason}']
#    Select From List By Value  (//*[@class='modal-body']//*[contains(@class,'form-group')])[5]//select  ${reason}
   ELSE
   Scroll And Click by JS    (//*[@class='modal-body']//*[contains(@class,'form-group')])[5]//select
       Click by JS    (//*[@class='modal-body']//*[contains(@class,'form-group')])[5]//select//*[@value='${reason}']
   END
   Check and Input text    xpath://textarea[@name='dwfrm_customerService_customerService_message']   Message to be send
   IF  '${signup}' in ['no']
   Scroll And Click by JS    xpath://div[@class='notify-me-checkbox']//span
   END
   Scroll And Click by JS    xpath://button[@id='btnCustomService']
   Wait Until Page Contains Element    xpath://h2[contains(text(),'Thank you for contacting')]
   Wait Until Page Contains Element    xpath:(//button[contains(text(),'Continue Shopping')])[1]
   Scroll And Click by JS    xpath:(//button[contains(text(),'Continue Shopping')])[1]
   
Check schedule consultation
   Scroll And Click by JS    xpath://*[contains(@class,'icon-appointment')]/parent::*
   @{handles}=    Get Window Handles
   Switch Window  ${handles}[1]
   Location Should Contain    https://davidyurman.jrni.com/
   Close Window
   Switch Window  ${handles}[0]

Check affirm link
#   Element Should Contain    xpath://a[@class='affirm-modal-trigger']    Learn more
#   Scroll Element Into View   xpath://a[@class='affirm-modal-trigger' and contains(text(),'Learn more')]
    Wait Until Element Is Visible       ${affirmLink_pdp}   10s
    Wait Until Element Is Enabled       ${affirmLink_pdp}   10s
    Wait Until Page Contains Element    ${affirmLink_pdp}   10s
    Wait Until Element Is Visible       ${affirmLink_pdp}   10s
    sleep  5s
    Mouse Click                          ${affirmLink_pdp}
#   Click by JS     xpath://a[@class='affirm-modal-trigger']
   sleep  10s
   Wait Until Page Contains Element    xpath://div[@class='affirm-sandbox-iframe-container']  10s
#   Wait Until Page Contains  Buy now, pay over time  10s
   Select Frame    xpath://iframe[@class='affirm-sandbox-iframe']
   Wait Until Element Is Visible    xpath://button[@id='close-button']  10s
   Sleep  2s
   Click Element    xpath://button[@id='close-button']
   Unselect Frame

Check size guide elements
    [Arguments]   ${product}
    Click size guide
    Sleep  2s
    Compare size displayed in PDP and size guide
    Element Text Should Be    xpath://h2[contains(@class,'size-chart-title')]    Find the Perfect Fit
  IF  '${product}' in ['ring']
     Check ring chart
  ELSE IF  '${product}' in ['bracelet']
     Check bracelet chart
  ELSE IF  '${product}' in ['bracelet']
     Check necklace chart
  END
     Close size guide
     sleep  3s

Check ring chart
     Element Text Should Be    xpath://p[contains(@class,'size-chart-text')]      Choose your corresponding size by comparing your finger measurements to the chart below or by following the directions in our printable guide.
     Element Text Should Be    xpath://a[contains(text(),'printable guide')]      printable guide
    IF  '${shopLocale}' in ['US']
     Element Text Should Be    xpath://h4[text()='Ring Sizing Kit']                  Ring Sizing Kit
     Element Text Should Be    xpath://div[contains(@class,'text-sizechart')]/p      If you're uncertain about your measurements, we have a simple solution: our ring sizing kit.
     Element Text Should Be    xpath://div[contains(@class,'buy-kit')]/a             ORDER SIZING KIT
    END
     Click Element    xpath://a[contains(text(),'printable guide')]
     @{handles}=    Get Window Handles
     Switch Window    ${handles}[1]
     Wait Until Location Contains   /DY_Ring_Size_Guide
     Close Window
     Switch Window    ${handles}[0]
     Element Text Should Be    xpath:(//span[contains(@class,'ring-chart-title')])[1]    Find your ring size
#     IF  '${shopLocale}' in ['US','CN']
      Wait Until Page Contains Element    ${pdp_sizeguide_toggleOffChecked}  10s
      Element Text Should Be    xpath:(//h4[@class='size-chart-text'])[1]    Ring Size
      Element Text Should Be    xpath:(//h4[@class='size-chart-text'])[2]    Finger Circumference
      Wait Until Page Contains Element    xpath://span[contains(@class,'inch size-chart')]  10s
      Scroll And Click by JS    xpath://div[@class='switcher-button-container']//input
      Wait Until Page Contains Element    xpath://span[contains(@class,'centimeter size-chart')]  10s
      Wait Until Page Contains Element    ${pdp_sizeguide_toggleOnChecked}  10s
#     ELSE
#      Page Should Contain Element    xpath://div[contains(@class,'toggle-on')]
#      Element Text Should Be    xpath:(//h4[@class='size-chart-text'])[1]    Ring Size
#      Element Text Should Be    xpath:(//h4[@class='size-chart-text'])[2]    Finger Circumference
#      Page Should Contain Element    xpath://span[contains(@class,'centimeter size-chart')]
#      Scroll And Click by JS    xpath://div[@class='switcher-button-container']//input
#      Page Should Contain Element    xpath://span[@class='size-measured centimeter size-chart-text']
#     END

     Element Text Should Be    xpath://span[@class='ring-chart-title']              How to measure at home:
     Element Text Should Be    xpath://div[@class='card-accordion'][1]//button      Measure a ring on your own
     Element Text Should Be    xpath://div[@class='card-accordion'][2]//button      Measure your finger
     Scroll And Click by JS    xpath://div[@class='card-accordion'][1]//button
     Sleep  2s
     Page Should Contain Element    xpath:(//div[@class='size-chart-icon'])[1]
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[1]    Select a ring you already own that perfectly fits the finger on which you will wear your David Yurman ring.
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[2]    Measure the interior diameter of the ring in millimeters.
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[3]    Find your measurement, compare it to the size chart, and choose the appropriate bracelet size. If you are between two sizes, we suggest you opt for the larger size.
     Scroll And Click by JS    xpath://div[@class='card-accordion'][1]//button
     Execute JavaScript    document.querySelector('div#sizeChartModal1').scrollTop = document.querySelector('div#sizeChartModal1').scrollHeight
     Scroll And Click by JS    xpath://div[@class='card-accordion'][2]//button
     Sleep  2s
     Page Should Contain Element    xpath:(//div[@class='size-chart-icon'])[2]
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[2]/li[1]    If you can’t use our printable guide, grab a tape measure, length of string or strip of paper.
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[2]/li[2]    Wrap the sizer around the intended finger with the numbers facing out.
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[2]/li[3]    Move the sizer to the larger part of the finger and pull tightly. The sizer must fit snugly to produce and accurate size.
     Run Keyword And Warn On Failure   Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[2]/li[4]    The number that lines up with the slit represents the ring size for that finger.

Check bracelet chart
     Element Text Should Be    xpath://p[contains(@class,'size-chart-text')]      Choose your corresponding size by comparing your wrist measurements to the chart below or by following the directions in our printable guide.
     Element Text Should Be    xpath://a[contains(text(),'printable guide')]      printable guide
     Click Element    xpath://a[contains(text(),'printable guide')]
     @{handles}=    Get Window Handles
     Switch Window    ${handles}[1]
     Wait Until Location Contains   /DY_Bracelet_Size_Guide
     Close Window
     Switch Window    ${handles}[0]
     Wait Until Page Contains Element    ${pdp_sizeguide_toggleOffChecked}  10s
     Element Text Should Be    xpath:(//h4[@class='size-chart-text'])[1]    Bracelet Size
     Element Text Should Be    xpath:(//h4[@class='size-chart-text'])[2]    Wrist Size
     Page Should Contain Element    xpath://span[@class='size-measured inch size-chart-text']
     Scroll And Click by JS    xpath://div[@class='switcher-button-container']//input
     Wait Until Page Contains Element    ${pdp_sizeguide_toggleOnChecked}  10s
     Page Should Contain Element    xpath://span[@class='size-measured centimeter size-chart-text']
     Element Text Should Be    xpath://div[contains(@class,'size-chart-instructions')]/span              How to measure at home:
     Page Should Contain Element    xpath://span[contains(@class,'size-chart-icon')]
     Element Text Should Be    xpath://span[contains(@class,'size-chart-icon')]//following-sibling::span    Our three-step guide
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[1]    If you can’t use our printable guide, grab a tape measure, length of string or strip of paper.
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[2]    Wrap the sizer around your wrist below the wrist bone, with numbers facing out. Adjust for a comfortable fit.
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[3]    Find your measurement, compare it to the size chart, and choose the appropriate bracelet size. If you are between two sizes, we suggest you opt for the larger size.


Check necklace chart
     Wait Until Page Contains Element    ${pdp_sizeguide_toggleOffChecked}  10s
     Element Text Should Be    xpath:(//h4[@class='size-chart-text'])[1]    Selection
     Page Should Contain Element    xpath://span[@class='size-measured inch size-chart-text']
     Scroll And Click by JS    xpath://div[@class='switcher-button-container']//input
     Wait Until Page Contains Element    ${pdp_sizeguide_toggleOnChecked}  10s
     Page Should Contain Element    xpath://span[@class='size-measured centimeter size-chart-text']
     Element Text Should Be    xpath://div[contains(@class,'size-chart-instructions')]/span              How to measure at home:
     Page Should Contain Element    xpath://span[contains(@class,'size-chart-icon')]
     Element Text Should Be    xpath://span[contains(@class,'size-chart-icon')]//following-sibling::span    Our three-step guide
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[1]    Measure and cut a piece of string to the same length as the necklace you like.
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[2]    Place it around your neck to see where it falls, don’t forget to consider the size and shape of the pendant.
     Element Text Should Be    xpath:(//ol[contains(@class,'size-chart-list')])[1]/li[3]    Choose your size based on your preferred length.

Check whether size guide is not visible
     Page Should Not Contain Element    xpath://a[@data-target='#sizeChartModal1']

Check pdp bread crumbs are displayed for ring sizer
    Element Should Be Visible    xpath://ol[@class='breadcrumb']
    Element Should Contain        xpath:(//li[@class='breadcrumb-item'])[1]     Home

Check if product name and sub title is displayed for ring sizer
   Wait Until Page Contains Element    xpath://span[@class='product-name--title js-primary-title']
   Element Text Should Not Be     xpath://span[@class='product-name--title js-primary-title']   Ring Sizer
   Wait Until Page Contains Element    xpath://span[@class='product-name--subtitle js-secondary-title']
   Element Text Should Not Be     xpath://span[@class='product-name--subtitle js-secondary-title']   FIND YOUR SIZE
   Element Text Should Be    xpath:(//div[@class='ring-sizing-price'])[1]    Complimentary
   Element Text Should Be    xpath:(//div[@class='ring-sizing-price'])[2]    Limit One Per Order

Close email customer modal
  Wait Until Page Contains Element    xpath:(//button[@class='close customer-service-close'])[1]//*//*
  Click Element    xpath:(//button[@class='close customer-service-close'])[1]

Check if preorder button is displayed
   Wait Until Page Contains Element    xpath://button[contains(@class,'add-to-cart')]
   Element Text Should Be    xpath://button[contains(@class,'add-to-cart')]    PRE-ORDER

Check if not available for pickup from boutique radio button is displayed
   Wait Until Page Contains Element    xpath://div[contains(@class,'pickup-in-store-btn')]
   Element Text Should Be   xpath://div[contains(@class,'pickup-in-store-btn')]   This item is not available for pick up

Check Not avaialble in saved store location is displayed
   Wait Until Element Is Visible    //div[@role='radio'][2] 
   Center Element on Screen    //div[@role='radio'][2]
   Set Focus To Element    //div[@role='radio'][2]
   Element Text Should Be    xpath://div[@role='radio'][2]    Not available at ${modal_store_title} in the quantity selected. Please adjust the quantity, or select a different store for pickup.
   
Check Navigation from Collections link
   Click Element    xpath://a[@class='pdp-link pdp-collection']
   Location Should Contain    /dy-elements-collection.html

Initiate and check order from order ring sizer
  Scroll And Click by JS    xpath://div[contains(@class,'buy-kit')]/a
  @{handles}=    Get Window Handles
   Switch Window  ${handles}[1]
   Location Should Contain    ring-sizing-kit-PK_RNGSZER.html
   sleep  5s
   Check if add to cart button is displayed
   Check if contact customer care button is displayed
   Click contact customer care button
   Check contact customer care modal details
   Close Window
   Switch Window  ${handles}[0]

Capture item details from PDP - VGC
   Wait Until Element Is Visible   //*[contains(@class,'delivery-method')]  10s
   ${PDP_product_1_price}    Get Text    //*[contains(@class,'delivery-method')]
   ${PDP_product_1_price}    Remove currency and comma from price    ${PDP_product_1_price}
   Set Global Variable    ${PDP_product_1_price}    ${PDP_product_1_price}
   Scroll Element Into View    //*[contains(@class,'product-name-title')]
   ${PDP_product_1_primary_name}    Get Text    //*[contains(@class,'product-name-title')]
   Set Global Variable    ${PDP_product_1_primary_name}    ${PDP_product_1_primary_name}


Capture item details from PDP
   Wait Until Element Is Visible   xpath://div[@class='prices']//span[@class='value']  10s
   ${PDP_product_1_price}    Get Text    xpath://div[@class='prices']//span[@class='value']
   ${PDP_product_1_price}    Remove currency and comma from price    ${PDP_product_1_price}
   Set Global Variable    ${PDP_product_1_price}    ${PDP_product_1_price}
#   Scroll Element Into View    xpath://span[@class='product-name--title js-primary-title']
   ${PDP_product_1_primary_name}    Get Text    xpath://span[@class='product-name--title js-primary-title']
   Set Global Variable    ${PDP_product_1_primary_name}    ${PDP_product_1_primary_name}
#   Scroll Element Into View    xpath://span[@class='product-name--subtitle js-secondary-title']
   ${PDP_product_1_secondary_name}    Get Text    xpath://span[@class='product-name--subtitle js-secondary-title']
   Set Global Variable    ${PDP_product_1_secondary_name}   ${PDP_product_1_secondary_name}

Capture item details from PDP in high-jewelry
    Wait Until Page Contains Element   //span[@class='product-name--title js-primary-title']  15s
    Wait Until Element Is Visible   //span[@class='product-name--title js-primary-title']  15s
   ${PDP_product_1_primary_name}    Get Text    xpath://span[@class='product-name--title js-primary-title']
   Set Global Variable    ${PDP_product_1_primary_name}    ${PDP_product_1_primary_name}
#   Scroll Element Into View    xpath://span[@class='product-name--subtitle js-secondary-title']
   ${PDP_product_1_secondary_name}    Get Text    xpath://span[@class='product-name--subtitle js-secondary-title']
   Set Test Variable    ${PDP_product_1_primary_name}
   Set Test Variable    ${PDP_product_1_secondary_name}

Capture item details from PDP for second product
    Wait Until Page Contains Element    xpath://div[@class='prices']//span[@class='value']
    ${PDP_product_2_price}  Get Text   xpath://div[@class='prices']//span[@class='value']
    ${PDP_product_2_price}  Remove currency and comma from price    ${PDP_product_2_price}
    Set Global Variable   ${PDP_product_2_price}   ${PDP_product_2_price}
    Wait Until Page Contains Element    xpath://span[@class='product-name--title js-primary-title']
    ${PDP_product_2_primary_name}    Get Text    xpath://span[@class='product-name--title js-primary-title']
    Set Global Variable    ${PDP_product_2_primary_name}    ${PDP_product_2_primary_name}
    Wait Until Page Contains Element    xpath://span[@class='product-name--title js-primary-title']
    ${PDP_product_2_secondary_name}    Get Text    xpath://span[@class='product-name--subtitle js-secondary-title']
    Set Global Variable    ${PDP_product_2_secondary_name}   ${PDP_product_2_secondary_name}

Compare the PLP product details with PDP
   Should Be Equal  ${PDP_product_1_primary_name}  ${PLP_product_title}
#   Should Be Equal  ${PDP_product_1_secondary_name}  ${PLP_product_subtitle}

Capture store details
    Wait Until Element Is Visible    xpath://button[contains(text(),'My Store')]//parent::div//preceding-sibling::div/span[1]
    ${bopis_storeName}  Get Text   xpath://button[contains(text(),'My Store')]//parent::div//preceding-sibling::div/span[1]
    ${bopis_storeDetails}  Get Text   xpath://button[contains(text(),'My Store')]//parent::div//preceding-sibling::div/span[3]
    Set Global Variable    ${bopis_storeName}
    Set Global Variable    ${bopis_storeDetails}

Capture Ring sizer details from PDP
    Scroll To Element    xpath://span[@class='product-name--title js-primary-title']
    ${PDP_product_primary_name_1}    Get Text    xpath://span[@class='product-name--title js-primary-title']
    Set Global Variable    ${ringSizer_product_primary_name}    ${PDP_product_primary_name_1}
    Scroll To Element     xpath://span[@class='product-name--subtitle js-secondary-title']
    ${PDP_product_secondary_name_1}    Get Text    xpath://span[@class='product-name--subtitle js-secondary-title']
    Set Global Variable    ${ringSizer_product_secondary_name}   ${PDP_product_secondary_name_1}
    Scroll To Element    xpath://div[@class='ring-sizing-price'][1]
    ${ringSizer_detail_1}  Get Text  xpath://div[@class='ring-sizing-price'][1]
    Set Global Variable    ${ringSizer_detail}   ${ringSizer_detail_1}
    Scroll To Element    xpath://div[@class='ring-sizing-price'][2]
    ${ringSizer_detail_2}  Get Text  xpath://div[@class='ring-sizing-price'][2]
    Set Global Variable    ${ringSizer_detail1}   ${ringSizer_detail_2}

Capture title of nth product on high-jewelry PLP
    [Arguments]  ${nth}
    Wait Until Page Contains Element  (//*[@class='pd-image' and contains(@alt,'Deco')])[${nth}]/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/preceding-sibling::*  10s
    Scroll To Element  (//*[@class='pd-image' and contains(@alt,'Deco')])[${nth}]/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/preceding-sibling::*
    ${hj_plp_productTitle}  Get Text  (//*[@class='pd-image' and contains(@alt,'Deco')])[${nth}]/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/preceding-sibling::*
    Set Test Variable  ${hj_plp_productTitle}

Capture title of nth product on high-jewelry women PLP
    [Arguments]  ${nth}
    Wait Until Page Contains Element  (//*[@class='pd-image' and contains(@src,'Product')])[${nth}]/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/following-sibling::*  10s
    Scroll To Element  (//*[@class='pd-image' and contains(@src,'Product')])[${nth}]/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/following-sibling::*
    ${hj_plp_productTitle}  Get Text  (//*[@class='pd-image' and contains(@src,'Product')])[${nth}]/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/parent::*/following-sibling::*
    Set Test Variable  ${hj_plp_productTitle}

Click on nth product on high-jewelry PLP
    [Arguments]  ${nth}
    Mouse Click  (//*[@class='pd-image' and contains(@alt,'Deco')])[${nth}]

Click on nth product on high-jewelry women PLP
    [Arguments]  ${nth}
    Mouse Click  (//*[@class='pd-image' and contains(@src,'Product')])[${nth}]

Verfiy the message below contact specialist button
    Element Should Contain  ${contactPSbutton_subTitle}   We’re here to help with style advice, a second opinion, or finding your perfect size.

Compare titles from PLP in high jewelry PDP
    sleep  5s
    ${PDP_product_1_primary_name}  Convert To Uppercase  ${PDP_product_1_primary_name}
    Should Contain   ${hj_plp_productTitle}  ${PDP_product_1_primary_name}
#    ${PDP_product_1_secondary_name}  Convert To Uppercase  ${PDP_product_1_secondary_name}
#    Run keyword And WaShould Contain   ${hj_plp_productTitle}  ${PDP_product_1_secondary_name}
    Element Should Contain  ${HJ_contactProductSpecialist}  CONTACT A PRODUCT SPECIALIST

Check if metal care is displayed in care section in high-jewelry
#   Wait Until Page Contains Element    xpath://button[@data-target='#detailsAndCare']  10s
#   Scroll Element Into View    //button[@data-target='#detailsAndCare']
   sleep  3s
#   Wait Until Page Contains Element    /button[@data-target='#detailsAndCare']  10s
#   Mouse Click    //button[@data-target='#detailsAndCare']
   Check and Click  //button[@data-target='#detailsAndCare']
   Scroll To Element  (//h6[@class='product-details-label'])[1]
   Element Should Contain    xpath:(//h6[@class='product-details-label'])[1]     Metal Care
#   Page Should Not Contain Element  xpath:(//h6[@class='product-details-label'])[2]  ##GemstoneCare

Click contact product specialist
    Mouse click  ${HJ_contactProductSpecialist}
    Wait Until Element Is Visible  ${HJ_productspecialistTitle}  5s
    Wait Until Page Contains Element  ${HJ_productspecialistTitle}  5s
    sleep  5s

Click contact diamond specialist
    Mouse click  ${contactDiamondSpecialist}
    Wait Until Element Is Visible  ${diamondSpecialistTitle}  5s
    Wait Until Page Contains Element  ${diamondSpecialistTitle}  5s
    sleep  5s

Expected elements in contact product specialist modal
    @{expectedElements}  Create List  ${HJ_productspecialistTitle}
    ...    ${HJ_contactPS_fnField}  ${HJ_contactPS_lnField}
    ...  ${HJ_contactPS_emailField}  ${HJ_contactPS_reenterEmailField}  ${HJ_contactPS_inquirySelect}
    ...  ${HJ_contactPS_productDetailsField}  ${HJ_contactPS_messageField}
    Wait Until Page Contains Multiple Elements  @{expectedElements}
    Element Should Contain  ${HJ_productspecialistTitle}  Contact a Product Specialist
    Run Keyword And Warn On Failure  Element Should Contain  ${HJ_contactPS_inquirySelect}  General Inquiry
    ${value}  Get Value   ${HJ_contactPS_productDetailsField}
    should contain  ${value}   ${PDP_product_1_primary_name}
    Element Should Contain  ${HJ_signUpCheckbox}  ${add_to_emailValue}


Expected elements in contact diamond specialist modal
    @{expectedElements}  Create List  ${diamondSpecialistTitle}
    ...    ${contactDS_fnField}  ${contactDS_lnField}
    ...  ${contactDS_emailField}  ${contactDS_reenterEmailField}  ${contactDS_inquirySelect}
    ...  ${contactDS_productDetailsField}  ${contactDS_messageField}
    Wait Until Page Contains Multiple Elements  @{expectedElements}
    Element Should Contain  ${diamondSpecialistTitle}  Contact a Diamond Specialist
    Element Should Contain  ${contactDS_inquirySelect}  Wedding/Bridal
    ${value}  Get Value   ${contactDS_productDetailsField}
    ${PDP_product_1_primary_name}  Replace String  ${PDP_product_1_primary_name}  ®  ${EMPTY}
    should contain  ${value}   ${PDP_product_1_primary_name}
    Element Should Contain  ${signUpCheckbox}  ${add_to_emailValue}


Fill and submit Contact a product specialist form
    Input text   ${HJ_contactPS_fnField}  Test
    Input text   ${HJ_contactPS_lnField}  user
    Input text   ${HJ_contactPS_emailField}  raeesdy@yopmail.com
    Input text   ${HJ_contactPS_reenterEmailField}  raeesdy@yopmail.com
    Input text   ${HJ_contactPS_messageField}  This is a test
    Scroll and Click by JS  ${HJ_contactPS_submit}
    Wait Until Page Contains  ${HJ_contactPs_submitSuccess}  10s
    Wait Until Page Contains Element  ${HJ_contactPs_continueShopping}  5s

Fill and submit Contact a diamond specialist form
    Input text   ${HJ_contactPS_fnField}  Test
    Input text   ${HJ_contactPS_lnField}  user
    Input text   ${HJ_contactPS_emailField}  raeesdy@yopmail.com
    Input text   ${HJ_contactPS_reenterEmailField}  raeesdy@yopmail.com
    Input text   ${HJ_contactPS_messageField}  This is a test
    Scroll and Click by JS  ${HJ_contactPS_submit}
    Wait Until Page Contains  ${contactDS_submitSuccess}  10s
    Wait Until Page Contains Element  ${HJ_contactPs_continueShopping}  5s

Click on nth product from wishlist and verify it's navigated to PDP
    [Arguments]  ${nth}
    ${nthItemName}  Return nth item name from wish list    ${nth}
    Mouse Click    (//*[contains(@class,'js-tile-image plp-carosel')])[${nth}]
    ##Comparing wishlist product name with pdp product name
    Wait Until Element Is Visible    //span[@class='product-name--title js-primary-title']  10s  error=PDP page not loaded from wishlist page
    ${PDP_product_1_primary_name}    Get Text    xpath://span[@class='product-name--title js-primary-title']
    Set Test Variable    ${PDP_product_1_primary_name}    ${PDP_product_1_primary_name}
    ${PDP_product_1_secondary_name}    Get Text    xpath://span[@class='product-name--subtitle js-secondary-title']
    Set Test Variable    ${PDP_product_1_secondary_name}    ${PDP_product_1_secondary_name}
    Should Contain  ${nthItemName}  ${PDP_product_1_primary_name}
#    Should Contain  ${nthItemName}  ${PDP_product_1_secondary_name}


Return nth item name from wish list
    [Arguments]  ${nth}
    Wait Until Element Is Visible    (//a[contains(@class, 'pdp-link')]//p)[${nth}]  5s
    ${nthItemName}  Get Text  (//a[contains(@class, 'pdp-link')]//p)[${nth}]
    RETURN  ${nthItemName}


