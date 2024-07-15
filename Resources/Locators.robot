*** Variables ***
# Checkout
${checkout_signin_l}                         css:.express-checkout div+.btn-primary
${checkout_email_l}                          css:#email
${checkout_pwd_l}                            css:#password
${checkout_signin_submit_l}                  css:.submit-customer-login
${signin_on_checkout}                        xpath:(//button[contains(text(),'Sign In')])[1]
${login_on_checkout}                         xpath:(//button[contains(text(),'Sign In')])[2]
${checkout_signin_email_l}                   css:.shipping-email-text
${checkout_info_modal_nr_l}                  css:.checkout-right-container .footer-item
${checkout_info_modal_show_l}                css:div#checkoutfooterModal.show
${checkout_info_modal_title_l}               css:div#checkoutfooterModal.show h4
${checkout_info_modal_close_l}               css:.show button.close svg
${checkout_coupon_applied_l}                 css:.d-none .coupon-applied-block
${checkout_summary_subtotal_l}               css:.d-none .sub-total
${checkout_summary_product_p_l}              css:.d-none .line-item-total-price-amount
${checkout_summary_tax_total_l}              css:.d-none .tax-total
${checkout_summary_descript_l}               css:.d-none .line-product-description
${checkout_summary_size_l}                   xpath://*[@class="d-none d-lg-block"]//p[contains(.,'Size')]
${checkout_summary_qty_l}                    xpath://*[@class="d-none d-lg-block"]//p[contains(.,'Qty')]

# Get The First Look
${gtfl}                                      css:.subscribe-email-heading
${gtfl_close}                                css:#emailDialogSignUp .icon

# Cookies
${cookies_accept}                            //*[contains(@id,'accept-btn')]
${cookies_accept_xp}                         xpath://div[@class='privacy_prompt']//div[@class='close_btn_thick']
#${cookies_accept}                            css:.consent-tracking-content .affirm

#Payment
${card_number}                               css:#cardNumber
${name_field}                                css:#cardOwner
${expiration_month_label}                    css:.selectric-expirationMonth .label
${expiration_month}                          css:.selectric-expirationMonth li[data-index="3"]
${expiration_year_label}                     css:.selectric-expirationYear .label
${expiration_year}                           css:.selectric-expirationYear li[data-index="3"]
${security_code}                             css:#securityCode
${cardNumber_field}                          id=cardNum
${cardexpiry_MonthSelect}                    id=cardExpiryMonth
${cardexpiry_yearSelect}                     id=cardExpiryYear
${card_cvv}                                  id=cvdNumber

${payment_section_l}                         css:.card #paymentSection
${payment_submit_cc_l}                       css:#showSubmitPayment .js-cc-label
${payment_submit_paypal_l}                   css:#payPalOption .btn
${payment_submit_zero_order_l}               css:#showSubmitPayment .js-gc-fully-paid-cta
${payment_preselected_cc_l}                  //*[@id='creditCardLink']//*[contains(@class,'form-check')]
${payment_hide_paypal_l}                     //*[@id='creditCardLink']//*[@id='payPalLink']
${payment_hide_affirm_l}                     //*[@id='creditCardLink']//*[@id='affirmLink']
${payment_add_new_card_l}                    css:.billing-add-payment
${payment_ShipInfo_email_l}                  css:.summary-email
${payment_ShipInfo_fn_l}                     css:.shipping-wrapper .firstName
${payment_ShipInfo_ln_l}                     css:.shipping-wrapper .lastName
${payment_ShipInfo_addr1_l}                  css:.shipping-wrapper .address1
${payment_ShipInfo_addr2_l}                  css:.shipping-wrapper .address2
${payment_ShipInfo_zip_l}                    css:.shipping-wrapper .postalCode
${payment_ShipInfo_phone_l}                  css:.shipping-wrapper .shipping-phone
${payment_ShipInfo_method_l}                 css:.shipping-wrapper .shipping-method-title
${payment_ShipInfo_edit_l}                   css:.shipping-summary .back-to-shipping-address
${payment_nr_empty_err_l}                    css:#giftCertID+label+div
${payment_pin_empty_err_l}                   css:#giftCertPin+label+div
${payment_cc_nr_empty_err_l}                 css:#cardNumber+label+div
${payment_cc_owner_empty_err_l}              css:#cardOwner+label+div
${payment_cc_exp_m_empty_err_l}              css:[class*='expirationMonth'] .invalid-feedback
${payment_cc_exp_y_empty_err_l}              css:[class*='expirationYear'] .invalid-feedback
${payment_cc_cvv_empty_err_l}                css:#securityCode+label+div
${pay_bill_fn_empty_err_l}                   css:#billingFirstName+label+div
${pay_bill_ln_empty_err_l}                   css:#billingLastName+label+div
${pay_bill_addr_empty_err_l}                 css:#billingAddressOne+label+div
${pay_bill_city_empty_err_l}                 css:#billingAddressCity+label+div
${pay_bill_state_empty_err_l}                css:[class*='billing_addressFields_state'] .invalid-feedback
${pay_bill_zip_empty_err_l}                  css:#billingZipCode+label+div
${bill_city_invalid_err_l}                   css:#billingAddressCity+label+div
${bill_zip_invalid_err_l}                    css:#billingZipCode+label+div
${billing_city}                              css:#billingAddressCity
${billing_zip}                               css:#billingZipCode
${billing_error_message_text}                css:#paymentSection .error-message-text
${payment_gcn_l}                             css:#giftCertID
${payment_pin_l}                             css:#giftCertPin
${pay_promo_empty_err_l}                     css:.d-none.d-lg-block .promo-code-error
${pay_gift_card_area_l}                      css:a[href="#giftCardBlockInner"]
${pay_gift_card_expanded_l}                  css:div.show#giftCardBlockInner
${pay_gift_card_apply_l}                     css:#add-gift-card-btn
${pay_gift_card_success_l}                   css:.gift-payment-accordion-text
${pay_gift_card_err_l}                       css:.giftcard-error.d-none
${pay_gift_card_remove_l}                    css:.remove-giftcard-paymentinstrument
${pay_add_promo_code_l}                      css:.d-none.d-lg-block #add-promo-code-btn
${pay_promo_code_title_l}                    css:#summaryCodeBlockInner .summary-accordion-promo-title
${pay_promo_code_input_l}                    css:.d-none.d-lg-block input#promoCode
${billing_fn_l}                              css:#billingFirstName
${billing_same_as_ship_l}                    xpath://label[@for='useDefaultShipping']

##Billing Page
${billing_email}                            css:.billing-address-block .email
${billing_fn}                               css:#billingFirstName
${billing_ln}                               css:#billingLastName
${billing_phone}                            css:.billing-address-block .phone
${billing_address_one}                      css:#billingAddressOne	
${billing_address_two}                      css:#billingAddressTwo
${billing_city}                             css:#billingAddressCity
${billing_state}                            css:.#selectric-billingState
${billing_state_lbl}                        css:.billing-address-block .selectric-shippingState .label
${billing_zip}                              css:#billingZipCode

###Shipping Page
${shipping_stage}                            css:[data-checkout-stage="shipping"]
${shipping_email}                            css:#email-guest-subscribe
${shipping_email_entered_l}                  css:#email-guest-subscribe.text-entered
${shipping_fn}                               css:#shippingFirstNamedefault
${shipping_fn_entered_l}                     css:#shippingFirstNamedefault.text-entered
${shipping_ln}                               css:#shippingLastNamedefault
${shipping_ln_entered_l}                     css:#shippingLastNamedefault.text-entered
${shipping_phone}                            css:#shippingPhoneNumberdefault
${shipping_phone_entered_l}                  css:#shippingPhoneNumberdefault.text-entered
${shipping_address_one}                      css:#shippingAddressOnedefault
${shipping_address_one_entered_l}            css:#shippingAddressOnedefault.text-entered
${shipping_address_two}                      css:input.shippingAddressTwo
${shipping_city}                             css:#shippingAddressCitydefault
${shipping_city_entered_l}                   css:#shippingAddressCitydefault.text-entered
#${shipping_state}                           css:#shippingStatedefault
${shipping_state}                            css:.selectric-shippingState
${shipping_state_lbl}                        css:.shipping-address-block .selectric-shippingState .label
${shipping_state_selected_l}                 css:.dwfrm_shipping_shippingAddress_addressFields_states_stateCode .label
${shipping_zip}                              css:#shippingZipCodedefault
${shipping_zip_entered_l}                    css:#shippingZipCodedefault.text-entered
${submit_shipping_l}                         css:[value='submit-shipping']
${shipping_show_verify_l}                    //*[@id='showVerifiedAddressesModal']//*[contains(@class,'modal-title')]
${shipping_address_zero_l}                   css:label[for="address-0"]
${shipping_address_one_l}                    css:#address-1
${shipping_save_selected_add}                css:#saveSelectedAddress
${shipping_2_day_del_l}                      xpath://*[@id="dwfrm_shipping"]//span[contains(.,'2-day')]/span
${shipping_overnight_del_l}                  xpath://*[@id="dwfrm_shipping"]//span[contains(.,'Overnight')]/span
${shipping_standard_del_l}                   xpath://*[@id="dwfrm_shipping"]//span[contains(.,'Standard')]/span
${shipping_usps_del_l}                       xpath://*[@id="dwfrm_shipping"]//span[contains(.,'USPS')]/span
${shipping_3_day_del_l}                      xpath://*[@id="dwfrm_shipping"]//span[contains(.,'3 to 5 days')]/span
${shipping_selected_shipping_l}              css:.shipping-method-list .selected
${shipping_sale_shipping_l}                  css:.selected .sale-price
${shipping_selected_del_l}                   css:.selected [checked="checked"]+label .display-name
${shipping_email_empty_err_l}                css:#shippingEmailInvalidMessage
${shipping_fn_empty_err_l}                   css:#defaultFirstName
${shipping_ln_empty_err_l}                   css:#defaultLastName
${shipping_phone_empty_err_l}                css:#defaultTelephoneNumber
${shipping_addr1_empty_err_l}                css:#defaultAddressLine1
${shipping_city_empty_err_l}                 css:#defaultCity
${shipping_state_empty_err_l}                css:#defaultState
${shipping_zip_empty_err_l}                  css:#defaultZipCode
${shipping_back_to_cart_l}                   css:.d-none .continue-shopping-link
${dqe_enabled}                               css:.pac-container .pac-item-query
${dqe_enabled_lbl}                           css:.pac-container .pac-item-query span
${dqe_enabled_list}                          css:.pac-container .pac-item
${dqe_disabled}                              css:.pac-container[style*="display: none"]

###Billing
${billing_same_as_shipping}                  css:#useDefaultShipping

#Gift Message Section
${gift_msg_l}                              css:a#isGiftOrder
${gift_msg_show_l}                         css:div.show#giftMessageCollapse
${giftRecipient_l}                         css:#giftRecipientOrder
${giftSender_l}                            css:#giftSendersOrder
${giftMessage_l}                           css:#giftMessageOrder
${gift_preview_l}                          css:#previewCard
${gift_preview_show_l}                     css:.js-gift-form-preview.d-block
${gift_preview_rec_l}                      css:.gift-recipient-preview
${gift_preview_sen_l}                      css:.gift-senders-preview
${gift_preview_txt_l}                      css:.gift-message-preview
${gifting_image_l}                      css:img[alt="Gifting image"]

###Order Confirmation
${OrderConfirmation_Page}       css:h1.order-confirmation-title
${confirm_order_number}         css:.pt-lg-7 .order-confirmation-section .col-12:first-child span+span
${confirm_email}                css:.pb-7 span.text-underline
${confirm_shipping}             css:.shipping-method-title
${confirm_first_name}           css:.shipping-wrapper .firstName
${confirm_last_name}            css:.shipping-wrapper .lastName
${confirm_address1}             css:.shipping-wrapper p.address1
${confirm_address2}             css:.shipping-wrapper p.address2
${confirm_postal}               css:.shipping-wrapper .postalCode
${confirm_phone}                css:.shipping-wrapper .shipping-phone
${confirm_order_total_top}      css:.grand-total-sum
${oc_six_chars_l}               css:.passwordList .six-characters
${oc_capital_lowercase_l}       css:.passwordList .capital-lowercase
${oc_one_number_l}              css:.passwordList .one-number
${oc_no_space_l}                css:.passwordList .no-spaces
${oc_special_char_l}            css:.passwordList .special-character
${oc_create_acc_title_l}        css:.checkout-right-container p
${oc_create_acc_pwd_l}          css:#newPassword
${oc_create_acc_submit_l}       css:.password-submit
${create_acc_err_l}             css:#newPassword+label+i+div

###PLP
${filters_showBtn}              //button[contains(@class,'toggle-filters btn') and contains(@aria-label,'filters')]
${filters_hideBtn}              //button[contains(@class,'toggle-filters btn') and contains(@aria-label,'hide')]
${filters_type}                 //*[contains(@class,'filters-drawer')]//a[contains(@href,'accordion-type') and contains(@class,'refinement-btn')]
${filters_price}                //*[contains(@class,'filters-drawer')]//a[contains(@href,'accordion-price') and contains(@class,'refinement-btn')]
${filters_material}             //*[contains(@class,'filters-drawer')]//a[contains(@href,'accordion-material') and contains(@class,'refinement-btn')]
${filters_gemColor}             //*[contains(@class,'filters-drawer')]//a[contains(@href,'accordion-gemstone-color') and contains(@class,'refinement-btn')]
${filters_gemType}              //*[contains(@class,'filters-drawer')]//a[contains(@href,'accordion-gemstone-type') and contains(@class,'refinement-btn')]
${filters_collection}           //*[contains(@class,'filters-drawer')]//a[contains(@href,'accordion-collection') and contains(@class,'refinement-btn')]
${filters_size}                 //*[contains(@class,'filters-drawer')]//a[contains(@href,'accordion-size') and contains(@class,'refinement-btn')]
${filters_resultsCountGrey}     //*[@class='result-count']
${plp_itemsList_l}              //*[contains(@class,'js-tile-image plp-carosel')]

${header_appliedFilter_removeBtn}      //button[contains(@class,'applied-filter')]//span[contains(@class,'remove')]
${header_appliedFilter_clearAllBtn}    //*[@class='header-clear-filters']
###PDP
${pdp_product_name_l}                      //*[contains(@class,'product-name--title')]
${pdp_product_subtitle_l}                  //*[contains(@class,'product-name--subtitle')]
${pdp_selected_size_l}                     css:.selected[value*='size=']
${pdp_add_to_cart_l}                       css:.add-to-cart
${pdp_notify_me_l}                         css:.show#notifyMeModal .btn
${pdp_notify_me_btn_l}                     css:[data-product-type="variant"] .add-to-cart
${pdp_notify_me_title_l}                   css:.show#notifyMeModal h4
${pdp_notify_me_msg_l}                     css:.notify-me-result-msg
${pdp_notify_me_fn_l}                      css:.show#notifyMeModal #firstName
${pdp_notify_me_ln_l}                      css:.show#notifyMeModal #lastName
${pdp_notify_me_mail_l}                    css:.show#notifyMeModal #email
${pdp_notify_me_mail_fill_l}               css:.show#notifyMeModal #email.text-entered
${pdp_customer_care_l}                     css:.customer-care-btn
${pdp_customer_care_title_l}               css:.show#customerCareModal h2
${pdp_customer_care_close_l}               css:.show#customerCareModal .close
${pdp_size_guide_l}                        css:.js-size-chart-link
${pdp_size_guide_close_l}                  css:.show#sizeChartModal1 .close
${pdp_size_guide_title_l}                  css:.show#sizeChartModal1 h2
${pdp_sizeguide_toggleOffChecked}          //div[contains(@class,'toggle-off-checked')]
${pdp_sizeguide_toggleOnChecked}          //div[contains(@class,'toggle-on-checked')]
${pdp_complimentary_links_l}               css:.complimentary-summary-links-wrapper .footer-item-links
${pdp_designer_note_l}                     css:.description-and-detail [aria-expanded="true"]
${pdp_care_l}                              css:[data-target="#detailsAndCare"]
${pdp_gifting_l}                           css:[data-target="#gifting"]
${pdp_variant_l}                           css:.attribute-variants-pdp
${pdp_variant_title_l}                     css:.attribute-variants-pdp [data-secondarytitle]
${pdp_price_range_l}                       css:.prices .price .range
${pdp_price_value_l}                       css:.prices .price .value
${pdp_underlay_l}                          css:div.underlay
${pdp_minicart_l}                          css:.minicart-body .item-image
${pdp_product_show_l}                      css:[data-action="Product-Show"]
${pdp_wish_icon_l}                         css:.add-to-wish-list
${pdp_ymal_title_l}                        css:h2.ymal-title
${pdp_ymal_carousel_l}                     css:#youMayAlsoLike .slick-track .slick-active
${pdp_emftc_title_l}                       css:h2.ymal-title-collection
${pdp_emftc_carousel_l}                    css:#explore-more-collection .slick-active
${pdp_rv_carousel_l}                       //*[contains(text(),'Recently Viewed')]/following-sibling::div/*/*[contains(@class,'slick-track')]
${pdp_trend_now_l}                         css:#bloomReachRecomendations-recentlyViewed h3
${pdp_trend_now_carousel_l}                css:#bloomReachRecomendations-recentlyViewed .slick-active
${pdp_selected_store_l}                    css:.pickup-in-store-btn-modal.text-underline
${pdp_pickup_store_list_l}                 css:.store-result-item.mx-0
${pdp_pickup_store_close_l}                css:#bopisModal .close
${pdp_pickup_store_btn_l}                  css:.pickup-in-store-btn
${pdp_pickup_store_zip_l}                  css:#bopisModal #zipcode
${pdp_pickup_store_dist_l}                 css:#bopisModal .distance span
${pdp_pickup_store_drop_l}                 css:.selectric-open .last
${pdp_pickup_store_search_l}               css:#bopisModal .btn-search
${pdp_pickup_search_first_res_l}           css:#bopisModal #storesList .store-result-item:nth-child(1) button
${pdp_open_image_l}                        css:.pswp
${pdp_total_image_l}                       css:.pdp-img-container
${pdp_img_next_arrow_l}                    css:.pswp .pswp__button--arrow--next svg
${pdp_img_counter_l}                       css:.pswp .pswp__counter
${pdp_img_zoom_l}                          css:.pswp .pswp__button--zoom svg
${pdp_img_zoom_in_l}                       css:.pswp--zoomed-in
${pdp_img_close_l}                         css:.pswp .pswp__button--close svg
${pdp_badge_l}                             css:.primary-images p.js-product-badge-text

###Cart
${minicart_icon_l}                           css:.d-none .minicart-link
${minicart_view_bag_l}                       css:.view-cart-button a
${minicart_close_l}                          //button[contains(@class,'close-mini-cart')]
${minicart_empty_close_l}                    css:.empty-minicart-header .close svg
${minicart_title_l}                          css:.show .minicart-title
${minicart_quantityUp}                      //button[contains(@aria-label,'Add quantity minicart')]
${minicart_quantityDown}                    //button[contains(@aria-label,'Remove quantity minicart')]
${minicart_prod_img_l}                       css:.show .product-image
${minicart_view_cart_l}                      css:.show .btn-view-cart
${minicart_checkout_btn_l}                   css:.show .checkout-btn
${minicart_nr_of_items_l}                    css:.d-none .minicart-quantity
${minicart_removeProduct}                    //button[contains(@data-action,'RemoveProduct')]
${cart_checkout_l}                           css:#checkout-form a[href*="checkout"]
${cart_coupon_input_l}                       css:#couponCode
${cart_coupon_submit_l}                      css:.promo-code-btn
${cart_coupon_err_l}                         css:#couponCode+label
${cart_page_data_action_l}                   css:[data-action="Cart-Show"]
${cart_page_title_l}                         css:.page-title
${cart_plus_qty_l}                           css:.d-none .cart-quantity-form .qty-add
${cart_qty_input_l}                          css:.d-none .cart-quantity-form .quantity
${cart_success_msg_l}                        css:.js-status-text a
${cart_rem_prod_one_l}                       css:.card:nth-child(1) .d-none .remove-product
${cart_wish_prod_one_l}                      css:.card:nth-child(1) .d-none a[href*="Wishlist-AddProduct"]
${cart_size_prod_one_l}                      css:.card:nth-child(1) .line-item-attributes span+span
${cart_quick_edit_l}                         css:.card [data-event-value="Quick Edit"]
${cart_quick_edit_show_l}                    css:#editProductModal h1
${cart_grand_total_l}                        css:.totals #grandTotal

###Minicart
${minicart_checkout_l}                         css:a[href*='checkout']
${minicart_modal}                              css:.popover-bottom
${minicart_price_line_l}                       css:.show .line-item-total-price-amount
${minicart_subtotal_price_l}                   css:.show .sub-total

###Affirm
${affirmLink_pdp}                            //a[@class='affirm-modal-trigger' and contains(text(),'Learn more')]
${affirm_link_l}                             css:#affirmLink
${affirm_radio}                              id=affirmOptionsRadio
${affirm_options_l}                          css:div.show#affirmOptions
${affirm_show_submit_l}                      css:#showSubmitPayment
${affirm_mobile_l}                           css:[aria-label*='Mobile number']
${affirm_phone_pin_l}                        css:input.focusable-form-field[aria-label='PIN']
${affirm_sign_in_submit_l}                   css:form[data-testid='sign-in-form'] button[type='submit']
${affirm_choose_pay_plan_l}                  xpath://h1[contains(.,'Choose a payment plan')]
${affirm_choose_this_plan_l}                 css:[aria-label='Choose this plan']
${affirm_frame_one_l}                        css:#checkout-application
${affirm_next_l}                             css:#btnNext
${affirm_login_l}                            css:#btnLogin
${affirm_last4_ssn_l}                        css:[aria-label*='Last 4 of Social']
${affirm_verify_l}                           xpath://button[contains(.,'Verify')]
${affirm_pof_submit_l}                       //*[contains(@data-testid,'submit-button')]
${affirm_review_pay_l}                       xpath://span/span[contains(.,'I have reviewed and agree to the ')]
${affirm_review_PADagreementCheck}          //span/span[contains(.,'By continuing, you agree to the')]
${affirm_paymentMethodSelector}              //*[contains(@data-testid,'right-icon')]
${affirm_paymentMethodSelector_addDebitCard}  id=debit
${affirm_paymentMethodSelector_addBankDetails}  id=pad
${affirm_paymentSelector_preAddedBankAcc}    //span[contains(text(),'Bank account')]
${affirm_ConfirmationPage_nameField}         //*[contains(@data-testid,'full-name')]
${affirm_confirmationPage_cardNumField}      //*[contains(@data-testid,'card-number')]
${affirm_confirmationPage_cardExpiryField}   //*[contains(@data-testid,'card-expiration')]
${affirm_confirmationPage_cvcField}          //*[contains(@data-testid,'card-cvc')]
${affirm_confirmationPage_postalCodeField}   //*[contains(@data-testid,'zip-field')]

${affirm_confirmationPage_transitNumField}   //*[contains(@data-testid,'transit')]
${affirm_confirmationPage_bankNumField}      //*[contains(@data-testid,'bank')]
${affirm_confirmationPage_accountNumField}   //*[contains(@data-testid,'account')]

${affirm_fnameField}                         name=fname
${affirm_lnameField}                         name=lname
${affirm_suffixSelector}                     //*[contains(@data-testid,'right-icon')]
${affirm_emailField}                         //*[contains(@data-testid,'email')]
${affirm_dobField}                           //*[contains(@data-testid,'dob')]
${affirm_consentCheck1}                      (//*[contains(@data-label,'OFF')])[2]
${affirm_consentCheck2}                      (//*[contains(@data-label,'OFF')])[3]
${affirm_registerSubmit}                     //*[contains(@data-testid,'submit')]
###PayPal
${paypal_link_l}                             css:#payPalLink
${paypal_option_l}                           css:div.show#payPalOption
${paypal_content_l}                          css:div#paypal-content
${paypal_email_l}                            css:#email
${paypal_pwd_l}                              css:#password
${paypal_consent_l}                          //button[contains(text(),'Continue')]
${paypal_iframe_l}                           css:[id^="jsx-iframe"]
${paypal_idntf_btn_l}                        css:#cart-paypal-button-container [id^="jsx-iframe"]
#${paypal_btn_container_l}                    css:div.paypal-button-label-container
${paypal_btn_container_l}                    id=cart-paypal-button-container

##klarna
${klarna_phoneVerify_continue}                //button[@id='onContinue']
${klarna_otpField}                           //*[@id='otp_field']
${klarna_choosePlan_continue}                //button[contains(@data-testid,'select-payment')]
${klarna_confirm_paywithklarnaBtn}           //button[@id='buy_button']


###Adyen-amex
${Adyen_passwordField}                       //*[@class='input-field']
${Adyen_submitBtn}                           id=buttonSubmit
${Adyen_password}                            password

###My Account
${my_acc_order_history_l}                    css:a.account-nav-item-link[href="/orders"]
${myacc_orderHistory_orderNumColumn}         (//*[contains(@class,'orderCard')])[1]
${myacc_orderHistory_resrvdOnColumn}         (//*[contains(@class,'orderCard')])[2]
${myacc_orderHistory_orderStatusColumn}      (//*[contains(@class,'orderCard')])[3]
${my_acc_email_lbl_l}                        css:.email-address .email-title
${my_acc_email_elm_l}                        css:.email-address
${myA_add_addr_fn_l}                         css:.show#addAddress #firstNameModal
${myA_add_addr_fn_err_l}                     css:.show#addAddress #firstNameModal+label+div
${myA_add_addr_ln_l}                         css:.show#addAddress #lastNameModal
${myA_add_addr_ln_err_l}                     css:.show#addAddress #lastNameModal+label+div
${myA_add_addr_addr_l}                       css:.show#addAddress #address1
${myA_add_addr_addr_err_l}                   css:.show#addAddress #address1+label+div
${myA_add_addr_city_l}                       css:.show#addAddress #cityPopup
${myA_add_addr_city_err_l}                   css:.show#addAddress #cityPopup+label+div
${myA_add_addr_zip_l}                        css:.show#addAddress #zipCode
${myA_add_addr_zip_err_l}                    css:.show#addAddress #zipCode+label+div
${myA_add_addr_tel_l}                        css:.show#addAddress #phone
${myA_add_addr_tel_err_l}                    css:.show#addAddress #phone+label+i+div
${myA_add_addr_state_l}                      css:.show#addAddress .row:nth-child(5) .selectric-custom-select .label
${myA_add_addr_state_err_l}                  css:.selectric-invalid+.invalid-feedback
${myA_add_card_name_l}                       css:.show#addPayment #cardOwner
${myA_add_card_nr_l}                         css:.show#addPayment #cardNumber
${myA_add_card_fn_l}                         css:.show#addPayment #firstNameModal
${myA_add_card_ln_l}                         css:.show#addPayment #lastNameModal
${myA_add_card_csv_l}                        css:.show#addPayment #securityCode
${myA_add_card_adr_l}                        css:.show#addPayment #address1
${myA_add_card_city_l}                       css:.show#addPayment #cityPopup
${myA_add_card_zip_l}                        css:.show#addPayment #zipCode
${myA_add_card_tel_l}                        css:.show#addPayment #phone
${myA_add_card_state_l}                      css:.row:nth-child(4) .selectric-custom-select
${myA_new_addr_fn_l}                         css:.show#addAddress #firstNameModal
${myA_new_addr_first_row_l}                  css:.address-item-detail.selected div:nth-child(1)
${myA_new_addr_second_row_l}                 css:.address-item-detail.selected div:nth-child(2)
${myA_new_addr_third_row_l}                  css:.address-item-detail.selected div:nth-child(4)
${myA_new_addr_fourth_row_l}                 css:.address-item-detail.selected div:nth-child(5)
${myA_order_details_cont_as_l}               css:.order-list-data-description .content-asset
${myA_new_card_onlyCardDetails}              (//div[contains(@class,'card-info')])[1]
${myA_new_card_first_row_l}                  css:.dashboard-info+div+div+div
${myA_new_card_row_info_l}                   css:.dashboard-info
${myA_new_card_next_row_l}                   css:.dashboard-info+div
${myA_new_card_city_zip_l}                   css:.dashboard-info+div+div
${myA_add_address_cta_l}                     css:a.add-address
${myA_add_addr_save_cta_l}                   css:.show#addAddress .btn-save
${myA_add_show_address_cta_l}                css:.show#addAddress
${my_account_page_l}                         css:[data-action="Account-Show"]
${myA_first_addr_edit_l}                     css:.card-item-address .edit-address
${myA_first_addr_remove_l}                   css:.card-item-address .remove-address
${myA_first_addr_remove_conf_l}              css:.show#deleteAddressModal .delete-confirmation-btn
${myA_edit_addr_save_l}                      css:.show#addAddress .btn-save
${myA_add_payment_l}                         css:a.add-payment
${myA_paym_make_def_l}                       css:.js-set-default-option
${myA_paym_make_def_select_l}                css:.payment-instrument-info.selected
${myA_remove_payment_l}                      css:.remove-payment
${myA_add_payment_save_l}                    css:.show#addPayment .save-payment
${myA_add_payment_cancel_l}                  css:.show#addPayment .cancel-btn
${myA_orders_tab_l}                          css:.account-nav-item [href="/orders"]
${myA_orders_page_l}                         css:[data-action="Order-History"]
${myA_delete_paym_conf_l}                    css:.show#deletePaymentModal .delete-confirmation-btn
${myA_card_owner_err_l}                      css:.show#addPayment #cardOwner+label+.invalid-feedback
${myA_card_number_err_l}                     css:.show#addPayment #cardNumber+label+.invalid-feedback
${myA_card_csv_err_l}                        css:.show#addPayment #securityCode+label+i+.invalid-feedback
${myA_card_fn_err_l}                         css:.show#addPayment #firstNameModal+label+.invalid-feedback
${myA_card_ln_err_l}                         css:.show#addPayment #lastNameModal+label+.invalid-feedback
${myA_card_addr_err_l}                       css:.show#addPayment #address1+label+.invalid-feedback
${myA_card_city_err_l}                       css:.show#addPayment #cityPopup+label+.invalid-feedback
${myA_card_zip_err_l}                        css:.show#addPayment #zipCode+label+.invalid-feedback
${myA_card_tel_err_l}                        css:.show#addPayment #phone+label+i+.invalid-feedback
${myA_card_state_err_l}                      xpath:(//div[@class='invalid-feedback'])[31]

#Email Preferences
${EmailPrefFrame}                           //iframe[contains(@src,'preferences')]
${EmailPref_tab}                             //*[contains(@href,'PreferenceCenter')]
${EmailPref_Title}                          //*[contains(@class,'col')]//h1[contains(text(),'Email Preferences')]
${EmailPref_currentStatus}                  //*[contains(@class,'col')]//h1[contains(text(),'Email Preferences')]/following-sibling::*
${EmailPref_updateSuccessMsg}               Thank you! Your preferences have been updated.
${EmailPref_exploreDyBtn}                   //*[contains(@href,'davidyurman.com') and contains(@class,'btn')]
${EmailPref_backBtn}                        //*[contains(@class,'BackButton')]
${EmailPref_updatePrefDescription}          Update your preferences below regarding country, language, and the email content you wish to receive.
${EmailPref_countrySelect}                  //*[text()='Country:']/following-sibling::*//select
${EmailPref_langSelect}                     //*[text()='Preferred Language:']/following-sibling::*
${EmailPref_allUpdatesRadio}                //*[@for='OptIn']
${EmailPref_emailPromoRadio}                //*[@for='Optin_Marketing']
${EmailPref_BAradio}                        //*[@for='Optin_BA']
${EmailPref_unsubAllRadio}                  //*[@for='OptOut']
${EmailPref_saveBtn}                        //*[@value='Submit']


#StoreLocator
${store_location}                           css:#store-postal-code
${store_search_button}                      css:.btn-storelocator-search
${store_phone_number}                       xpath://*[@class="store-details"]//address/span/a
${store_address}                            xpath://*[@class="store-details"]//address
${store_img}                                //*[@class="store-details"]//img
${store_img_src}                            xpath://*[@class='store-name']
${store_titles_list}                        //*[contains(@class,'store-name')]
${store_form}                               css:.store-locator-forms
${authorized_address}                       xpath://address[@class="store-text"]
${checkbox_boutique}                        css:#boutique
${checkbox_retailer}                        css:[for=retailer]
${logo_home}                                (//*[@class='logo-home-img'])[1]
${distance_dropdown_button}                 css:.selectric
${service_ul}                               xpath://*[contains(@class,'col')]//*[contains(text(),'Available Services')]
${view_store_button}                        xpath:(//a[contains(@class,'btn-primary')])[1]
${view_store_name}                          css:.store-name
${view_store_address}                       xpath://*[@class="store-locator-details store-bottom"]//address 
${view_store_hours}                         xpath://*[@class="store-locator-details store-bottom"]//*[@class="store-info-block store-hours store-text store-open-hours-state"]//table
${map_pin_position}                         xpath=//div[@title="David Yurman - Glendale"]
${map_pin_dialog}                           xpath=//div[@role="dialog"]
${get_direction_button}                     xpath=//*[@id="269026"]//a[@class="js-get-directions btn btn-outline-primary"]


#Homepage

${home_minicart_l}                          css:.d-none .minicart-quantity-outer
${home_mpopover_show_l}                     css:.popover.show
${home_empty_minicart_l}                    css:.empty-card-title-text
${home_minicart_qty_outer_l}                css:.d-none .minicart-quantity-outer
${home_cart_show_l}                         css:[data-action="Cart-Show"]
${home_login_show_l}                        css:[data-action='Login-Show']
${home_login_icon_l}                        css:.icon-login
${home_choose_country_l}                    css:footer #js-choosecountry
${home_csc_popup_l}                         xpath://a[text()='Choose Another Country ']
${home_csc_popup_close_l}                   xpath://*[contains(@class,'close-choose-country')]
${home_fav_uns_l}                           css:.icon-favorite-unselected
${home_show_wishlist_l}                     css:[data-action='Wishlist-Show']
${home_wishlist_count_l}                    css:.js-wishlist-count
${home_wishlist_empty_l}                    css:#empty-wishlist
${home_wishlist_first_item_l}               (//span[contains(@class,'primary-title')])[1]
${home_subscribe_submit_l}                  css:#btnSubscribeEmail svg
${home_subscribe_send_l}                    css:.icon-arrow-circle-black
${home_subscribe_input_l}                   css:#hpEmailSignUp
${home_suport_col_l}                        css:div:nth-child(1).footer-item .menu-footer li a
${home_legal_col_l}                         css:div:nth-child(2).footer-item .menu-footer li a
${home_aboutus_col_l}                       css:div:nth-child(3).footer-item .menu-footer li a
${cart_wishlist_list_l}                     css:.product-info .item-name
${cart_wishlist_qv_l}                       css:#quickViewModal .product-name--title
${instagram_icon_l}                         css:a.instagram
${youtube_icon_l}                           css:a.youtube
${facebook_icon_l}                          css:a.facebook
${pinterest_icon_l}                         css:a.pinterest
${twitter_icon_l}                           css:a.twitter
${wechat_icon_l}                            css:a.weChat
${tiktok_icon_l}                            css:a.tiktok

#Payment Gift Card
${gift_card_footer}                         xpath=//a[@title="Gift Cards"]
${virtual_gift_card_img_initial_page}       xpath=//img[@alt="Send a digital gift card."]
${physical_gift_card_img_initial_page}      xpath=//img[@alt="Shop physical gift cards."]
${check_balance_vgc_pdp}                    css=#gc-check-balance-reset
${check_balance_modal_gc_number}            css=#giftCertID
${check_balance_modal_gc_pin}               css=#giftCertPin
${check_balance_modal_gc_button}            css=#balanceCheckbtn
${check_balance_modal_gc_balance}           css=#gcBalanceAmount
${payment_gift_card_apply_button}           css=#add-gift-card-btn 
${payment_gift_card_expand_button}          xpath=//a[@href="#giftCardBlockInner"]
${order_confirmation_gift_card_value}        xpath=//div[@class="js-gift-card-payments-summary"]//p[@class="text-right"] 
${order_confirmation_gift_card_text}        xpath=//div[@class="js-gift-card-payments-summary"]//p[@class="order-receipt-label"]

# GIFT CARD 
${gift_card_pdp_fn}                             css:#recipientFirstName
${gift_card_pdp_ln}                             css:#recipientLastName
${gift_card_pdp_email}                          css:#recipientEmailAddress
${gift_card_pdp_sender}                         css:#senderName
${gift_card_checkout_details}                   css:.virtual-gift-text
${gift_card_message}                            xpath://textarea[@id='giftMessageOrder']
${giftcard_chatButton}                          id=chatButton

###Checkout BOPIS
${guest_bopis_email}                            css:#guest-subscribe-store-pickup
${guest_bopis_fn}                               css:.pickupFirstName 
${guest_bopis_ln}                               css:.pickupLastName
${guest_bopis_phone}                            css:.pickupPhoneNumber

###PDP BOPIS
${bopis_modal}                                  css:#pickupInStore 
${store_pickup_button}                          css:.pickup-in-store-btn-modal
${address_pickup_button}                        css:.address-pickup-btn

${bopis_title}                                      css:.in-store-pickup-title-summary
${bopis_shipping_title}                             css:.store-info-container .shipping-info-title-text
#${bopis_store_name}                                 css:.store-text .mb-0
${bopis_store_address1}                             css:.store-text
${bopis_store_phone}                                css:.store-text .storelocator-phone

${store_locator_zipcode}                        css:#zipcode
${store_locator_distance_btn}                   css:.distance .button
${store_locator_distance_list}                  css:.distance .selectric-scroll .last
${store_locator_search_btn}                     css:.btn-search
${store_locator_available_store}                css:#storesList .store-result-item .pickup-in-store


#Billing 
${billing_address_checkout}                     css:.billing-summary-wrapper .address-summary
${billing_payment_method_checkout}              css:.billing-summary-wrapper .payment-summary-bottom

#Login
${sign_in_icon}                                 css:.icon-login
${register_login_button}                        css:.login-box a[href*="register"]
${register_create_account_button}               css:#btnRegistrationSubmit
${register_firstname_field}                     css:#registration-form-fname
${register_lastname_field}                      css:#registration-form-lname
${register_email_field}                         css:#registration-form-email
${register_confirm_email_field}                 css:#registration-form-email-confirm
${register_password_field}                      css:#registration-form-password
${register_confirm_password_field}              css:#registration-form-password-confirm
${login_button}                                 css:#btnLoginSubmit 
${login_username_field}                         css:#login-form-email
${login_password_field}                         css:#login-form-password
${account_container}                            css:.account-container-nav
${register_box}                                 css:.register-box
${login_heading}                                css:.login-page-heading

${logged_user_firstname_field}                  css:.card-body #firstName
${logged_user_lastname_field}                   css:.card-body #lastName
${logged_user_email_field}                      css:#loginInfoContainer

#Register
${register_firstname_err}                       css:#form-fname-error
${register_lastname_err}                        css:#form-lname-error
${register_email_err}                           css:#form-email-error
${register_confirm_email_err}                   css:#form-email-confirm-error
${register_password_err}                        css:#form-password-error
${register_confirm_password_err}                css:#form-password-confirm-error
${change_pass_link}                             css:.change-pass > a
${current_password_locator}                     css:#changePasswordContainer #currentPassword
${new_password_locator}                         css:#newPassword
${confirm_password_locator}                     css:#newPasswordConfirm
${submit_button}                                css:.password-submit
${header_icon_account}                          css:.header-icon-account > span
${logout_link}                                  css:.popover a[href*='Logout']
${login_error_message}                          css:.alert-danger
${change_email_link}                            css:.change-email > a
${new_email_locator}                            css:#newEmail
${password_locator}                             css:#changeEmailContainer #currentPassword
${save_email_button}                            css:#btnUpdateEmailSubmit
${change_email_success_message}                 css:.change-email-success-message
${password_check_personal_info_chars}           css:.six-characters
${password_check_personal_info_uppercase}       css:.capital-lowercase
${password_check_personal_info_lowercase}       css:.capital-lowercase
${password_check_personal_info_number}          css:.one-number
${password_check_personal_info_space}           css:.no-spaces
${password_check_personal_info_email}           css:.no-email
${password_check_personal_info_specialchar}     css:.special-character
${first_name_personal_info_locator}             css:#dwfrm_profile #firstName
${last_name_personal_info_locator}              css:#dwfrm_profile #lastName
${birthday_personal_info_locator}               css:#dwfrm_profile #birthday
${anniversary_personal_info_locator}            css:#dwfrm_profile #anniversary
${save_personal_info_button}                    css:#dwfrm_profile .btn-save
${invalid_feedback}                             css:.invalid-feedback
${page_title_personal_info}                     css:.page-title

#STATIC PAGES
${about_us_footer}                                      xpath=//a[contains(text(), 'About Us')]
${about_us_title_locator}                               css:.experience-layouts-container .pd-text.d-none
${about_us_subtitle_locator}                            css:.hero-heading .d-none
${static_page_accordion}                                css:.accordion-button
${static_page_text_visible_locator}                     css:.collapse.show
${contact_customer_care_info_title_locator}             css:.d-none .cs-care-title
${contact_customer_care_info_subtitle_locator}          css:.d-none .cs-care-option
${footer_support_ccc}                                   (//*[@class='menu-footer'])[1]/parent::*/*/*/*[contains(@href,'customer-care.html')]
${footer_support_ccc_phoneInfo}                         (//*[contains(@class,'care-subtitle')])[1]
${footer_support_ccc_email}                             (//*[contains(@class,'care-subtitle')])[2]
${footer_support_ccc_bookAppointment}                   (//*[contains(@class,'care-subtitle')])[3]
${footer_support_returns}                               //*[@class='menu-footer']//a[contains(@href,'returns-exchanges.html')]
${footer_support_returns_returnPolicyDropdown}          //*[@id='headingOne']
${footer_support_returns_returnPolicyDropdown_1stRow}   (//*[@class='content']//p)[1]
##Header
${logo_home}                                           xpath:(//a[@title='David Yurman Home'])[1]

##registration page locators
${new_customer_heading}              xpath://h2[contains(text(),'New Customer')]
${register_button_regPage}           xpath://button[@id='btnRegistrationSubmit']
${first_name_textField_reg}              xpath://input[@id='registration-form-fname']
${last_name_textField_reg}               xpath://input[@id='registration-form-lname']
${email_textField_reg}                   xpath://input[@id='registration-form-email']
${retype_email_textField_reg}            xpath://input[@id='registration-form-email-confirm']
${password_textField_reg}                xpath://input[@id='registration-form-password']
${retype_password_textField_reg}         xpath://input[@id='registration-form-password-confirm']
${first_name_placeHolder_reg}            xpath://label[@for='registration-form-fname']
${last_name_placeHolder_reg}             xpath://label[@for='registration-form-lname']
${email_placeHolder_reg}                 xpath://label[@for='registration-form-email']
${retype_email_placeHolder_reg}          xpath://label[@for='registration-form-email-confirm']
${password_placeHolder_reg}              xpath://label[@for='registration-form-password']
${retype_password_placeHolder_reg}       xpath://label[@for='registration-form-password-confirm']
${registration_form_indicator_reg}       xpath://div[contains(@class,'form-indicator')]
${password_requirements_button_reg}      xpath://a[@role='button' and @data-toggle='collapse' and contains(text(),' Password Requirements')]
${password_requirements_subHeading_reg}  xpath://div[@class='content-asset']/p[contains(text(),'Please ensure your password:')]
${password_requirement_1_reg}            xpath://li[@class='six-characters']
${password_requirement_2_reg}            xpath://li[@class='capital-lowercase']
${password_requirement_3_reg}            xpath://li[@class='one-number']
${password_requirement_4_reg}            xpath://li[@class='no-spaces']
${password_requirement_5_reg}            xpath://li[@class='no-email']
${password_requirement_6_reg}            xpath://li[@class='special-character']
${add_to_email_reg}                      xpath://label[@for='add-to-email-list']
${first_name_validation_reg}             xpath://div[@id='form-fname-error']
${last_name_validation_reg}              xpath://div[@id='form-lname-error']
${email_validation_reg}                  xpath://div[@id='form-email-error']
${retype_email_validation_reg}           xpath://div[@id='form-email-confirm-error']
${password_validation_reg}               xpath://div[@id='form-password-error']
${retype_password_validation_reg}        xpath://div[@id='form-password-confirm-error']

###Password requirements checked and unchecked
#${minimum_length_requirement_checked}         xpath://ul[@class='passwordList passwordSuccess']/li[@class='six-characters checked']
#${minimum_length_requirement_unchecked}       xpath://ul[@class='passwordList passwordSuccess']/li[@class='six-characters']
#${capital_lowercase_requirement_checked}     xpath://ul[@class='passwordList passwordSuccess']/li[@class='capital-lowercase checked']
#${capital_lowercase_requirement_unchecked}   xpath://ul[@class='passwordList passwordSuccess']/li[@class='capital-lowercase']
#${one_number_requirement_checked}            xpath://ul[@class='passwordList passwordSuccess']/li[@class='one-number checked']
#${one_number_requirement_unchecked}          xpath://ul[@class='passwordList passwordSuccess']/li[@class='one-number']
#${no_spaces_requirement_checked}             xpath://ul[@class='passwordList passwordSuccess']/li[@class='no-spaces checked']
#${no_spaces_requirement_unchecked}           xpath://ul[@class='passwordList passwordSuccess']/li[@class='no-spaces']
#${no_email_requirement_checked}              xpath://ul[@class='passwordList passwordSuccess']/li[@class='no-email checked']
#${no_email_requirement_unchecked}            xpath://ul[@class='passwordList passwordSuccess']/li[@class='no-email']
#${special_character_requirement_checked}     xpath://ul[@class='passwordList passwordSuccess']/li[@class='special-character checked']
#${special_character_requirement_unchecked}   xpath://ul[@class='passwordList passwordSuccess']/li[@class='special-character']

##registration page text/messages
${first_name_placeHolderValue}           First Name
${last_name_placeHolderValue}            Last Name
${email_placeHolderValue}                Email
${retype_email_placeHolderValue}         Retype Email Address
${password_placeHolderValue}             Password
${retype_password_placeHolderValue}      Retype Password
${registration_form_indicatorValue}      * Indicates required fields
${password_requirement_1_value}          Is at least six characters in length
${password_requirement_2_value}          Contains at least one capital letter and one lowercase letter
${password_requirement_3_value}          Contains at least one number
${password_requirement_4_value}          Does not contain spaces
${password_requirement_5_value}          Does not contain your email address
${password_requirement_6_value}          Contains at least one special character (f.ex. !#$£€%)
${add_to_emailValue}                     Sign up to receive email updates from David Yurman about the latest collections and news. You can unsubscribe at any time at no cost. See our Privacy Policy for details.
${first_name_validationValue}            Please enter your first name.
${last_name_validationValue}             Please enter your last name.
${email_validationValue}                 Please enter a valid email address
${retype_email_validationValue}          Please enter a valid email address
${password_validationValue}              Please enter a password
${retype_password_validationValue}       Please enter a password
${already_existing_user_validation}      User with that email address already exists.
${email_mismatch_validation}             Please enter the same value again.
${password_requirement_doesnt_match}     Sorry, the provided password does not match the required constraints.
${password_requirement_minimum_length}   This field needs 6 to 255 characters


##Login OR Registration page
##Login Section
${account_registration_header}             xpath://h1[contains(text(),'Account Registration')]
${registered_customer_subHeading}          xpath://h2[contains(text(),'Registered Customers')]
${registered_customer_messageElement}      xpath://h2[contains(text(),'Registered Customers')]//following-sibling::p
${login_form_email_textField}              xpath://input[@id='login-form-email']
${login_form_email_placeHolderElement}     xpath://label[@for='login-form-email']
${login_form_password_textField}           xpath://input[@id='login-form-password']
${login_form_password_placeHolderElement}  xpath://label[@for='login-form-password']
${login_email_toolTip}                     xpath://i[@class='tooltip-icon']
${forgot_password_link}                    xpath:(//u[contains(text(),'Forgot Your Password?')])[2]
${login_button}                            xpath://button[@id='btnLoginSubmit']
${login_form_email_error}                  xpath://div[@id='form-email-error']
${login_form_password_error}               xpath://div[@id='form-password-error']

##Register section
${new_customer_heading}         xpath://h2[contains(text(),'New Customer')]
${new_customer_messageElement}  xpath://h2[contains(text(),'New Customer')]//following-sibling::p
${faster_check_out}             xpath:(//div[@class='content-asset'])[1]/ul/li[1]
${access_order}                 xpath:(//div[@class='content-asset'])[1]/ul/li[2]
${view_online}                  xpath:(//div[@class='content-asset'])[1]/ul/li[3]
${add_items}                    xpath:(//div[@class='content-asset'])[1]/ul/li[4]

##Text/Messages - New Customer section
${new_customer_messageText}   Register with David Yurman for the following benefits:
${faster_check_out_message}   Faster checkout
${access_order_message}       Access your order status
${view_online_message}        View online order history
${add_items_message}          Add items to your wish list and share


##My Account Page page
${my_account_title}             xpath://h1[contains(text(),'Account Registration')]
${register_button}              xpath://a[text()='Register']
${address_book_header}          xpath://h2[text()='Address Book']
${add_address_button}           xpath://a[@aria-label='Add a New Address']


##registration page locators
${new_customer_heading}              xpath://h2[contains(text(),'New Customer')]
${register_button_regPage}           xpath://button[@id='btnRegistrationSubmit']
${first_name_textField}              xpath://input[@id='registration-form-fname']
${last_name_textField}               xpath://input[@id='registration-form-lname']
${email_textField}                   xpath://input[@id='registration-form-email']
${retype_email_textField}            xpath://input[@id='registration-form-email-confirm']
${password_textField}                xpath://input[@id='registration-form-password']
${retype_password_textField}         xpath://input[@id='registration-form-password-confirm']
${first_name_placeHolder}            xpath://label[@for='registration-form-fname']
${last_name_placeHolder}             xpath://label[@for='registration-form-lname']
${email_placeHolder}                 xpath://label[@for='registration-form-email']
${retype_email_placeHolder}          xpath://label[@for='registration-form-email-confirm']
${password_placeHolder}              xpath://label[@for='registration-form-password']
${retype_password_placeHolder}       xpath://label[@for='registration-form-password-confirm']
${registration_form_indicator}       xpath://div[contains(@class,'form-indicator')]
${password_requirements_button}      xpath://a[@role='button' and @data-toggle='collapse' and contains(text(),' Password Requirements')]
${password_requirements_subHeading}  xpath://div[@class='content-asset']/p[contains(text(),'Please ensure your password:')]
${password_requirement_1}            xpath://li[@class='six-characters']
${password_requirement_2}            xpath://li[@class='capital-lowercase']
${password_requirement_3}            xpath://li[@class='one-number']
${password_requirement_4}            xpath://li[@class='no-spaces']
${password_requirement_5}            xpath://li[@class='no-email']
${password_requirement_6}            xpath://li[@class='special-character']
${add_to_email}                      xpath://label[@for='add-to-email-list']
${first_name_validation}             xpath://div[@id='form-fname-error']
${last_name_validation}              xpath://div[@id='form-lname-error']
${email_validation}                  xpath://div[@id='form-email-error']
${retype_email_validation}           xpath://div[@id='form-email-confirm-error']
${password_validation}               xpath://div[@id='form-password-error']
${retype_password_validation}        xpath://div[@id='form-password-confirm-error']

##Password requirements checked and unchecked
${minimum_length_requirement_checked}         xpath://ul[contains(@class,'passwordList')]/li[@class='six-characters checked']
${minimum_length_requirement_unchecked}       xpath://ul[contains(@class,'passwordList')]/li[@class='six-characters']
${capital_lowercase_requirement_checked}     xpath://ul[contains(@class,'passwordList')]/li[@class='capital-lowercase checked']
${capital_lowercase_requirement_unchecked}   xpath://ul[contains(@class,'passwordList')]/li[@class='capital-lowercase']
${one_number_requirement_checked}            xpath://ul[contains(@class,'passwordList')]/li[@class='one-number checked']
${one_number_requirement_unchecked}          xpath://ul[contains(@class,'passwordList')]/li[@class='one-number']
${no_spaces_requirement_checked}             xpath://ul[contains(@class,'passwordList')]/li[@class='no-spaces checked']
${no_spaces_requirement_unchecked}           xpath://ul[contains(@class,'passwordList')]/li[@class='no-spaces']
${no_email_requirement_checked}              xpath://ul[contains(@class,'passwordList')]/li[@class='no-email checked']
${no_email_requirement_unchecked}            xpath://ul[contains(@class,'passwordList')]/li[@class='no-email']
${special_character_requirement_checked}     xpath://ul[contains(@class,'passwordList')]/li[@class='special-character checked']
${special_character_requirement_unchecked}   xpath://ul[contains(@class,'passwordList')]/li[@class='special-character']


${shipping_method_message_l}                 xpath://input[@type='radio' and contains(@id,'shippingMethod') and @checked]//parent::div//span[@class='text-muted arrival-time']


#SEARCH
${search_resultcount} =  //*[contains(@class,'heading--count')]
${search_topResultsList}           //span[text()='Top results']//ancestor::div[contains(@class,'product-view-all-wrapper')]//following-sibling::div/span//div[@class='product-info']//span[contains(@class,'srp-product-name--title')]

#Minicart
${continue_checkout_minicart}      //*[contains(@class,'minicart-footer')]//*[contains(@class,'cart-action-checkout')]

#Checkout
${checkout_page_title}             xpath://h1[@class='checkout-page-title global-page-title freight-big-pro-font mb-0']

##eps
${Eps_login_emailField}             id=login-form-email
${Eps_login_passField}              id=login-form-password
${Eps_login_email}                  imaz.rayees@davidyurman.com
${Eps_login_password}               Yurman24!
${Eps_loginBtn}                     id=btnLoginSubmit

##privacypolicy
${privacyPolicy_accRegistration}     (//*[contains(@class,'email-message-link')])[1]
${privacyPolicy_contactForm}         (//*[contains(@class,'email-message-link')])[1]
${privacyPolicy_emailFooter}         (//*[contains(@class,'email-message-link')])[3]
${privacyPolicy_wishlist}            (//*[contains(@class,'email-message-link')])[4]

##high-jewelry
${HJ_contactProductSpecialist}        //*[contains(@class,'contact-specialistbutton')]
${contactPSbutton_subTitle}           //*[contains(@class,'customer-care-copy')]
${HJ_productspecialistTitle}          //*[contains(@class,'specialist-title')]
${HJ_contactPS_fnField}               //input[contains(@name,'contactSpecialist_firstName')]
${HJ_contactPS_lnField}               //input[contains(@name,'contactSpecialist_lastName')]
${HJ_contactPS_emailField}            (//input[contains(@name,'contactSpecialist_email')])[1]
${HJ_contactPS_reenterEmailField}     (//input[contains(@name,'contactSpecialist_email')])[2]
${HJ_contactPS_inquirySelect}         //*[@class='selectric']
${HJ_contactPS_productDetailsField}   //input[contains(@name,'contactSpecialist_productName')]
${HJ_contactPS_messageField}          //*[contains(@name,'contactSpecialist_message')]
${HJ_signUpCheckbox}                  (//*[@class='notify-me-checkbox'])[3]
${HJ_contactPS_submit}                id=prodSpecFormSubmit
${HJ_contactPs_submitSuccess}         Thank you for contacting our Product Specialist.
${HJ_contactPs_continueShopping}      name=continue


##wedding
${contactDiamondSpecialist}        //*[contains(@class,'contact-specialistbutton')]
${diamondSpecialistTitle}          //*[contains(@class,'specialist-title')]
${contactDS_fnField}               //input[contains(@name,'contactSpecialist_firstName')]
${contactDS_lnField}               //input[contains(@name,'contactSpecialist_lastName')]
${contactDS_emailField}            (//input[contains(@name,'contactSpecialist_email')])[1]
${contactDS_reenterEmailField}     (//input[contains(@name,'contactSpecialist_email')])[2]
${contactDS_inquirySelect}         //*[@class='selectric']
${contactDS_productDetailsField}   //input[contains(@name,'contactSpecialist_productName')]
${contactDS_messageField}          //*[contains(@name,'contactSpecialist_message')]
${signUpCheckbox}                  (//*[@class='notify-me-checkbox'])[3]
${contactDS_submit}                id=prodSpecFormSubmit
${contactDS_submitSuccess}         Thank you for contacting our Diamond Specialist.
${contactDS_continueShopping}      name=continue