*** Variables ***
###Order Confirmation
${oc_create_acc_expected_err}                       Your password does not meet the required criteria
${oc_six_char_err}                                  Password must be at least 6 characters in length
${oc_capital_lowercase_err}                         Password must contain at least one upper case letter and a lower case letter
${oc_capital_one_number_err}                        Password must contains at least one number
${oc_capital_no_spaces_err}                         Password must not contain spaces
${oc_capital_special_char_err}                      Password must contain at least one special character (f.ex. !#$£€%)
${cart_coupon_err}                                  Enter Promo Code

###Shipping
${shipping_email_empty_err}                         Please enter a valid email address
${shipping_fn_empty_err}                            Please enter your first name.
${shipping_ln_empty_err}                            Please enter your last name.
${shipping_phone_empty_err}                         Please enter your telephone number.
${shipping_phone_invalid_err}                       Please enter a valid 10-digit telephone number.
${shipping_addr1_empty_err}                         Please enter your address.
${shipping_city_empty_err}                          Please enter your city.
${shipping_city_invalid_err}                        Please use at least 2 characters (you are currently using 1 character).
${shipping_state_empty_err}                         Please select a state.
${shipping_zip_empty_err}                           Please enter your ZIP code.
${shipping_zip_invalid_err}                         Please enter a valid 5 or 9-digit ZIP code.

###Payment
${payment_number_empty_err}                         Please enter a 16-digit gift card number.
${payment_pin_empty_err}                            Please enter a 4-digit PIN card number.
${payment_cc_nr_empty_err}                          Please enter your card number.
${payment_cc_name_empty_err}                        Please enter the name as it appears on the credit card.
${payment_cc_exp_m_empty_err}                       Please enter your credit card’s expiration month.
${payment_cc_exp_y_empty_err}                       Please enter your credit card’s expiration year.
${payment_cc_cvv_empty_err}                         Please enter your card’s 3- or 4-digit security code.
${pay_bill_fn_empty_err}                            Please enter your first name.
${pay_bill_ln_empty_err}                            Please enter your last name.
${pay_bill_addr_empty_err}                          Please enter your address.
${pay_bill_city_empty_err}                          Please enter your city.
${pay_bill_state_empty_err}                         Please select a state.
${pay_bill_zip_empty_err}                           Please enter your ZIP code.
${bill_city_invalid_err}                            Please lengthen this text to 2 characters or more (you are currently using 1 character).
${bill_zip_invalid_err}                             Please enter a valid 5 or 9-digit ZIP code.
${billing_error_message_text_err}                   The payment you submitted is not valid. Please re-enter payment information.
${pay_promo_empty_err}                              Please enter a valid promo code.
${pay_gift_card_err}                                Please verify your gift card number and PIN.

#LOGIN
${register_empty_first_name_err}                    Please enter your first name.
${register_empty_last_name_err}                     Please enter your last name.
${register_invalid_email_err}                       Please enter a valid email address
${register_mismatch_emails_err}                     Please enter the same value again.
${register_empty_pwd_err}                           Please enter a password
${register_missing_char_pwd_err}                    This field needs 6 to 255 characters
${register_not_match_pwd_err}                       Passwords do not match
${register_invalid_pwd_err}                         Sorry, the provided password does not match the required constraints.
${invalid_login_error_message}                      Invalid login or password. Remember that password is case-sensitive. Please try again.


#My Account
${myA_add_addr_fn_err}                              Please enter your first name.
${myA_add_addr_ln_err}                              Please enter your last name.
${myA_add_addr_addr_err}                            Please enter your address.
${myA_add_addr_city_err}                            Please enter your city.
${myA_add_addr_state_err}                           Please select a state.
${myA_add_addr_zip_err}                             Please enter your ZIP code.
${myA_add_addr_tel_err}                             Please enter your telephone number.
${myA_card_owner_err}                               Please fill out this field.
${myA_card_number_err}                              Please fill out this field.
${myA_card_csv_err}                                 Please fill out this field.
${myA_card_fn_err}                                  Please enter your first name.
${myA_card_ln_err}                                  Please enter your last name.
${myA_card_addr_err}                                Please enter your address.
${myA_card_city_err}                                Please enter your city.
${myA_card_zip_err}                                 Please enter your ZIP code.
${myA_card_tel_err}                                 Please enter your telephone number.
${myA_card_state_err}                               Please select a state.