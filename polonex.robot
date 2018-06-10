*** Settings ***
Library     String
Library     DateTime
Library     Selenium2Library
Library     Collections
Library     polonex_helper.py


*** Variables ***
${self}                                              polonex
${TESTDOMAIN}                                        'http://test.polonex.in.ua'
${sign_in}                                           id=loginbtn
${login_email}                                       id=loginform-username
${login_pass}                                        id=loginform-password
${prozorropage}                                      id=prozorropagebtn2
${locator.title}                                     id=auction_title
${locator.dgfID}                                     id=info_dgfID
${locator.tenderAttempts}                            id=info_tenderAttempts
${locator.procurementMethodType}                     id=info_procurementMethodType
${locator.eligibilityCriteria}                       id=eligibilityCriteria_marker
${locator.status}                                    id=auction_status_name
${locator.description}                               id=info_description
${locator.minNumberOfQualifiedBids}                  id=info_minNumberOfQualifiedBids
${locator.minimalStep.amount}                        xpath=//td[contains(@id, 'info_minimalStep')]/span[contains(@class, 'amount')]
${locator.value.amount}                              xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'amount')]
${locator.guarantee.amount}                          xpath=//td[contains(@id, 'info_guarantee')]/span[contains(@class, 'amount')]
${locator.value.currency}                            xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'currency')]
${locator.value.valueAddedTaxIncluded}               xpath=//td[contains(@id, 'info_value')]/span[contains(@class, 'tax')]
${locator.tenderId}                                  id=info_auctionID
${locator.procuringEntity.name}                      id=org_name
${locator.enquiryPeriod.startDate}                   id=enquiryPeriodDatastartDate
${locator.enquiryPeriod.endDate}                     id=enquiryPeriodDataendDate
${locator.tenderPeriod.startDate}                    id=tenderPeriodDatastartDate
${locator.tenderPeriod.endDate}                      id=tenderPeriodDataendDate

${locator.auctionPeriod.startDate}                   id=auctionPeriodDatastartDate
${locator.auctionPeriod.endDate}                     id=auctionPeriodDataendDate

${locator.proposition.value.amount}                  xpath=//div[contains(@class, 'userbidinfo')]/span[contains(@id, 'userbidamount')]


${locator.items[0].quantity}                         id=items[0]_quantity
${locator.items[0].description}                      id=items[0]_description
${locator.items[1].description}                      id=items[1]_description
${locator.items[2].description}                      id=items[2]_description
${locator.items[3].description}                      id=items[3]_description
${locator.items[0].unit.code}                        id=items[0]_unit_code
${locator.items[0].unit.name}                        id=items[0]_unit_name
${locator.items[0].deliveryAddress.postalCode}       id=item[0]deliveryAddress_postalCode
${locator.items[0].deliveryAddress.countryName}      id=item[0]deliveryAddress_countryName
${locator.items[0].deliveryAddress.region}           id=item[0]deliveryAddress_region
${locator.items[0].deliveryAddress.locality}         id=item[0]deliveryAddress_locality
${locator.items[0].deliveryAddress.streetAddress}    id=item[0]deliveryAddress_streetAddress
${locator.items[0].deliveryLocation.latitude}        id=items[0]_deliveryLocation_latitude
${locator.items[0].deliveryLocation.longitude}       id=items[0]_deliveryLocation_longitude
${locator.items[0].classification.scheme}            id=classification_scheme
${locator.items[0].classification.id}                id=classification_id
${locator.items[0].classification.description}       id=classification_description
${locator.items[0].contractPeriod}                   id=items[0]_contractPeriod

${locator.questions[0].title}                        id=q[0]title
${locator.questions[0].description}                  id=q[0]description
${locator.questions[0].date}                         id=q[0]date
${locator.questions[0].answer}                       id=q[0]answer

${locator.cancellations[0].status}                   id=cancell_status
${locator.cancellations[0].reason}                   id=cancell_reason

${locator.cancelldoc.title}                          xpath=//div[contains(@class, 'fg_modal_title')]
${locator.cancelldoc.description}                    xpath=//div[contains(@class, 'fg_modal_description')]

###for assets

${assetlocator.title}                                    id=auction_title
${assetlocator.status}                                   id=info_status
${assetlocator.id}                                       id=info_id
${assetlocator.assetID}                                  id=info_assetID
${assetlocator.date}                                     id=info_date
${assetlocator.dateModified}                             id=info_dateModified
${assetlocator.rectificationPeriod}                      id=info_rectificationPeriod
${assetlocator.description}                              id=info_description
${assetlocator.decisions[0].title}                       id=decisions[0]_title
${assetlocator.decisions[0].decisionDate}                id=decisions[0]_decisionDate
${assetlocator.decisions[0].decisionID}                  id=decisions[0]_decisionID
${assetlocator.rectificationPeriod.endDate}              xpath=//td[contains(@id, 'info_rectificationPeriod')]/span[contains(@class, 'endDate')]
${assetlocator.assetHolder.name}                         id=assetHolder_name
${assetlocator.assetHolder.identifier.scheme}            xpath=//span[contains(@class, 'assetHolder_org_ident_scheme')]
${assetlocator.assetHolder.identifier.id}                xpath=//span[contains(@class, 'assetHolder_org_ident_id')]
${assetlocator.assetHolder.identifier.legalName}         xpath=//span[contains(@class, 'assetHolder_org_ident_legalName')]
${assetlocator.assetHolder.contactPoint.name}            xpath=//div[contains(@class, 'assetHolder_contactPoint_name')]
${assetlocator.assetHolder.contactPoint.telephone}       xpath=//div[contains(@class, 'assetHolder_contactPoint_telephone')]
${assetlocator.assetHolder.contactPoint.email}           xpath=//div[contains(@class, 'assetHolder_contactPoint_email')]
${assetlocator.assetCustodian.name}                      id=assetCustodian_name_fortest
${assetlocator.assetCustodian.identifier.scheme}         xpath=//span[contains(@class, 'assetCustodian_org_ident_scheme')]
${assetlocator.assetCustodian.identifier.id}             xpath=//span[contains(@class, 'assetCustodian_org_ident_id')]
${assetlocator.assetCustodian.identifier.legalName}      xpath=//td[contains(@id, 'assetCustodian_name')]
${assetlocator.assetCustodian.contactPoint.name}         xpath=//div[contains(@class, 'assetCustodian_contactPoint_name')]
${assetlocator.assetCustodian.contactPoint.telephone}    xpath=//div[contains(@class, 'assetCustodian_contactPoint_telephone')]
${assetlocator.assetCustodian.contactPoint.email}        xpath=//div[contains(@class, 'assetCustodian_contactPoint_email')]
${assetlocator.items[0].unit.name}                       id=items[0]_unit
${assetlocator.items[0].registrationDetails.status}      id=items[0]_registrationDetails_status
${assetlocator.items[0].classification.scheme}           xpath=//span[contains(@class, 'item[0]classification_scheme')]
${assetlocator.items[0].classification.id}               xpath=//span[contains(@class, 'item[0]classification_id')]

${assetlocator.documents[0].documentType}                id=doclist_0

${assetitemlocator.id}           id=items[0]_id
${assetitemlocator.description}  id=items[0]_description
${assetitemlocator.address}      id=items[0]_address
${assetitemlocator.quantity}     id=items[0]_quantity
${assetitemlocator.unit}         id=items[0]_unit

${lotlocator.status}                                           id=info_status
${lotlocator.id}                                               id=info_id
${lotlocator.lotID}                                            id=info_lotID
${lotlocator.title}                                            id=info_title
${lotlocator.description}                                      id=info_description
${lotlocator.assets}                                           id=info_assets
${lotlocator.auctions}                                         id=info_auctions
${lotlocator.lotHolder.name}                                   id=lotHolder_name
${lotlocator.org.name}                                         id=org_name
${lotlocator.decisions[0].title}                               id=decisions[0]_title
${lotlocator.decisions[0].decisionDate}                        id=decisions[0]_decisionDate
${lotlocator.decisions[0].decisionID}                          id=decisions[0]_decisionID
${lotlocator.decisions[1].title}                               id=decisions[1]_title
${lotlocator.decisions[1].decisionDate}                        id=decisions[1]_decisionDate
${lotlocator.decisions[1].decisionID}                          id=decisions[1]_decisionID
${lotlocator.auctions[0].auctionID}                            id=auctions[0]_auctionID
${lotlocator.auctions[0].status}                               id=auctions[0]_status
${lotlocator.auctions[0].tenderAttempts}                       id=auctions[0]_tenderAttempts
${lotlocator.auctions[0].procurementMethodType}                id=auctions[0]_procurementMethodType
${lotlocator.auctions[0].auctionPeriod}                        id=auctions[0]_auctionPeriod
${lotlocator.auctions[0].tenderingDuration}                    id=auctions[0]_tenderingDuration
${lotlocator.auctions[0].value.amount}                         id=auctions[0]_value
${lotlocator.auctions[0].minimalStep.amount}                   id=auctions[0]_minimalStep
${lotlocator.auctions[0].guarantee.amount}                     id=auctions[0]_guarantee
${lotlocator.auctions[0].registrationFee.amount}               id=auctions[0]_registrationFee
${lotlocator.auctions[0].dutchSteps}                           id=auctions[0]_dutchSteps
${lotlocator.auctions[1].auctionID}                            id=auctions[1]_auctionID
${lotlocator.auctions[1].status}                               id=auctions[1]_status
${lotlocator.auctions[1].tenderAttempts}                       id=auctions[1]_tenderAttempts
${lotlocator.auctions[1].procurementMethodType}                id=auctions[1]_procurementMethodType
${lotlocator.auctions[1].auctionPeriod}                        id=auctions[1]_auctionPeriod
${lotlocator.auctions[1].tenderingDuration}                    id=auctions[1]_tenderingDuration
${lotlocator.auctions[1].value.amount}                         id=auctions[1]_value
${lotlocator.auctions[1].minimalStep.amount}                   id=auctions[1]_minimalStep
${lotlocator.auctions[1].guarantee.amount}                     id=auctions[1]_guarantee
${lotlocator.auctions[1].registrationFee.amount}               id=auctions[1]_registrationFee
${lotlocator.auctions[1].dutchSteps}                           id=auctions[1]_dutchSteps
${lotlocator.auctions[2].auctionID}                            id=auctions[2]_auctionID
${lotlocator.auctions[2].status}                               id=auctions[2]_status
${lotlocator.auctions[2].tenderAttempts}                       id=auctions[2]_tenderAttempts
${lotlocator.auctions[2].procurementMethodType}                id=auctions[2]_procurementMethodType
${lotlocator.auctions[2].auctionPeriod}                        id=auctions[2]_auctionPeriod
${lotlocator.auctions[2].tenderingDuration}                    id=auctions[2]_tenderingDuration
${lotlocator.auctions[2].value.amount}                         id=auctions[2]_value
${lotlocator.auctions[2].minimalStep.amount}                   id=auctions[2]_minimalStep
${lotlocator.auctions[2].guarantee.amount}                     id=auctions[2]_guarantee
${lotlocator.auctions[2].registrationFee.amount}               id=auctions[2]_registrationFee
${lotlocator.auctions[2].dutchSteps}                           id=auctions[2]_dutchSteps
${lotlocator.items[0].id}                                      id=items[0]_id
${lotlocator.items[0].description}                             id=items[0]_description
${lotlocator.items[0].classification}                          id=items[0]_classification
${lotlocator.items[0].address}                                 id=items[0]_address
${lotlocator.items[0].quantity}                                id=items[0]_quantity
${lotlocator.items[0].unit}                                    id=items[0]_unit
${lotlocator.items[0].registrationDetails.status}              id=items[0]_registrationDetails_status
${lotlocator.items[0].registrationDetails.registrationID}      id=items[0]_registrationDetails_registrationID
${lotlocator.items[0].registrationDetails.registrationDate}    id=items[0]_registrationDetails_registrationDate
${lotlocator.items[1].description}                             id=items[1]_description
${lotlocator.items[1].classification}                          id=items[1]_classification
${lotlocator.items[1].address}                                 id=items[1]_address
${lotlocator.items[1].quantity}                                id=items[1]_quantity
${lotlocator.items[1].unit}                                    id=items[1]_unit
${lotlocator.items[1].registrationDetails.status}              id=items[1]_registrationDetails_status
${lotlocator.items[1].registrationDetails.registrationID}      id=items[1]_registrationDetails_registrationID
${lotlocator.items[1].registrationDetails.registrationDate}    id=items[1]_registrationDetails_registrationDate
${lotlocator.lotHolder.identifier.scheme}                      xpath=//span[contains(@class, 'lotHolder_org_ident_scheme')]
${lotlocator.lotHolder.identifier.id}                          xpath=//span[contains(@class, 'lotHolder_org_ident_id')]
${lotlocator.lotHolder.identifier.legalName}                   xpath=//span[contains(@class, 'lotHolder_org_ident_legalName')]
${lotlocator.lotHolder.identifier.uri}                         xpath=//span[contains(@class, 'lotHolder_org_ident_uri')]
${lotlocator.lotHolder.address.streetAddress}                  xpath=//div[contains(@class, 'lotHolder_address_streetAddress')]
${lotlocator.lotHolder.address.locality}                       xpath=//div[contains(@class, 'lotHolder_address_locality')]
${lotlocator.lotHolder.address.region}                         xpath=//div[contains(@class, 'lotHolder_address_region')]
${lotlocator.lotHolder.address.postalCode}                     xpath=//div[contains(@class, 'lotHolder_address_postalCode')]
${lotlocator.lotHolder.address.countryName}                    xpath=//div[contains(@class, 'lotHolder_address_countryName')]
${lotlocator.lotHolder.contactPoint.name}                      xpath=//div[contains(@class, 'lotHolder_contactPoint_name')]
${lotlocator.lotHolder.contactPoint.email}                     xpath=//div[contains(@class, 'lotHolder_contactPoint_email')]
${lotlocator.lotHolder.contactPoint.telephone}                 xpath=//div[contains(@class, 'lotHolder_contactPoint_telephone')]
${lotlocator.lotCustodian.identifier.scheme}                   xpath=//span[contains(@class, 'lotCustodian_org_ident_scheme')]
${lotlocator.lotCustodian.identifier.id}                       xpath=//span[contains(@class, 'lotCustodian_org_ident_id')]
${lotlocator.lotCustodian.identifier.legalName}                xpath=//span[contains(@class, 'lotCustodian_org_ident_legalName')]
${lotlocator.lotCustodian.address.streetAddress}               xpath=//div[contains(@class, 'lotCustodian_address_streetAddress')]
${lotlocator.lotCustodian.address.locality}                    xpath=//div[contains(@class, 'lotCustodian_address_locality')]
${lotlocator.lotCustodian.address.region}                      xpath=//div[contains(@class, 'lotCustodian_address_region')]
${lotlocator.lotCustodian.address.postalCode}                  xpath=//div[contains(@class, 'lotCustodian_address_postalCode')]
${lotlocator.lotCustodian.address.countryName}                 xpath=//div[contains(@class, 'lotCustodian_address_countryName')]
${lotlocator.lotCustodian.contactPoint.name}                   xpath=//div[contains(@class, 'lotCustodian_contactPoint_name')]
${lotlocator.lotCustodian.contactPoint.email}                  xpath=//div[contains(@class, 'lotCustodian_contactPoint_email')]
${lotlocator.lotCustodian.contactPoint.telephone}              xpath=//div[contains(@class, 'lotCustodian_contactPoint_telephone')]
${lotlocator.date}                                             id=info_date
${lotlocator.rectificationPeriod.endDate}                      xpath=//td[contains(@id, 'info_rectificationPeriod')]/span[contains(@class, 'endDate')]
${lotlocator.assets[0]}                                        xpath=//td[contains(@id, 'info_assets')]/a
${lotlocator.auctions[0].auctionPeriod.startDate}              xpath=//td[contains(@id, 'auctions[0]_auctionPeriod')]/span[contains(@class, 'startDate')]
${lotlocator.dateModified}                                     id=info_dateModified


${lotlocator.items[0].classification.scheme}                   xpath=//span[contains(@class, 'item[0]classification_scheme')]
${lotlocator.items[0].classification.id}                       xpath=//span[contains(@class, 'item[0]classification_id')]
${lotlocator.items[0].unit.name}                               id=items[0]_unit



*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]     ${username}
  [Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо
  ${alias}=   Catenate   SEPARATOR=   role_  ${username}
  Set Global Variable   ${BROWSER_ALIAS}   ${alias}
  Open Browser  ${USERS.users['${username}'].homepage}  ${USERS.users['${username}'].browser}  alias=${BROWSER_ALIAS}
  Set Window Size       @{USERS.users['${username}'].size}
  Set Window Position   @{USERS.users['${username}'].position}
  Run Keyword If   '${username}' != 'polonex_viewer'   Login   ${username}

Login
  [Arguments]  @{ARGUMENTS}
  Click Element        xpath=//li[contains(@id, 'lbtn-mobile')]/a
  Sleep   2
  Clear Element Text   id=loginform-username
  Input text      ${login_email}      ${USERS.users['${ARGUMENTS[0]}'].login}
  Input text      ${login_pass}       ${USERS.users['${ARGUMENTS[0]}'].password}
  Click Button    name=login-button
  Sleep   2
  Click Element   ${prozorropage}

Підготувати дані для оголошення тендера
  [Documentation]  Це слово використовується в майданчиків, тому потрібно, щоб воно було і тут
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  [return]  ${tender_data}

Створити тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tender_data

    ${procurementmethodtype}=                Get From Dictionary         ${ARGUMENTS[1].data}                   procurementMethodType
    ${title}=                                Get From Dictionary         ${ARGUMENTS[1].data}                   title
    ${dgfID}=                                Get From Dictionary         ${ARGUMENTS[1].data}                   dgfID

    ${minNumberOfQualifiedBids}=             Get From Dictionary         ${ARGUMENTS[1].data}                   minNumberOfQualifiedBids

    ${tenderAttempts}=                       Get From Dictionary         ${ARGUMENTS[1].data}                   tenderAttempts
    ${description}=                          Get From Dictionary         ${ARGUMENTS[1].data}                   description
    ${auctionperiod_startdate}=              Get From Dictionary         ${ARGUMENTS[1].data.auctionPeriod}     startDate
    ${minimalstep_amount}=                   Get From Dictionary         ${ARGUMENTS[1].data.minimalStep}       amount
    ${minimalstep_currency}=                 Get From Dictionary         ${ARGUMENTS[1].data.minimalStep}       currency
    ${value_amount}=                         Get From Dictionary         ${ARGUMENTS[1].data.value}             amount
    ${value_currency}=                       Get From Dictionary         ${ARGUMENTS[1].data.value}             currency
    ${value_valueaddedtaxincluded}=          Convert To String           ${ARGUMENTS[1].data.value.valueAddedTaxIncluded}
    ${value_valueaddedtaxincluded}=          convert_polonex_string      ${value_valueaddedtaxincluded}


    ${guarantee_amount}=                     Get From Dictionary         ${ARGUMENTS[1].data.guarantee}         amount

    ${items}=                                Get From Dictionary         ${ARGUMENTS[1].data}                   items
    ${item0}=                                Get From List               ${items}                               0
    ${item_description}=                     Get From Dictionary         ${item0}                               description
    ${classification_scheme}=                Get From Dictionary         ${item0.classification}                scheme
    ${classification_description}=           Get From Dictionary         ${item0.classification}                description
    ${classification_id}=                    Get From Dictionary         ${item0.classification}                id
    ${deliveryaddress_postalcode}=           Get From Dictionary         ${item0.deliveryAddress}               postalCode
    ${deliveryaddress_countryname}=          Get From Dictionary         ${item0.deliveryAddress}               countryName
    ${deliveryaddress_streetaddress}=        Get From Dictionary         ${item0.deliveryAddress}               streetAddress
    ${deliveryaddress_region}=               Get From Dictionary         ${item0.deliveryAddress}               region
    ${deliveryaddress_locality}=             Get From Dictionary         ${item0.deliveryAddress}               locality
    ${unit_code}=                            Get From Dictionary         ${item0.unit}                          code
    ${unit_name}=                            Get From Dictionary         ${item0.unit}                          name
    ${quantity}=                             Get From Dictionary         ${item0}                               quantity
    ${deliverylocation_latitude}=            Get From Dictionary         ${item0.deliveryLocation}              latitude
    ${deliverylocation_longitude}=           Get From Dictionary         ${item0.deliveryLocation}              longitude


    ${procuringEntity}=                      Get From Dictionary         ${ARGUMENTS[1].data}                   procuringEntity

    ${procuringEntity_address_countryName}=      Get From Dictionary     ${procuringEntity.address}            countryName
    ${procuringEntity_address_locality}=         Get From Dictionary     ${procuringEntity.address}            locality
    ${procuringEntity_address_postalCode}=       Get From Dictionary     ${procuringEntity.address}            postalCode
    ${procuringEntity_address_region}=           Get From Dictionary     ${procuringEntity.address}            region
    ${procuringEntity_address_streetAddress}=    Get From Dictionary     ${procuringEntity.address}            streetAddress
    ${procuringEntity_contactPoint_name}=        Get From Dictionary     ${procuringEntity.contactPoint}       name
    ${procuringEntity_contactPoint_telephone}=   Get From Dictionary     ${procuringEntity.contactPoint}       telephone
    ${procuringEntity_identifier_id}=            Get From Dictionary     ${procuringEntity.identifier}         id
    ${procuringEntity_identifier_scheme}=        Get From Dictionary     ${procuringEntity.identifier}         scheme
    ${procuringEntity_name}=                     Get From Dictionary     ${procuringEntity}                    name

    ${minimalstep_amount}=              Convert To String     ${minimalstep_amount}
    ${value_amount}=                    Convert To String     ${value_amount}
    ${guarantee_amount}=                Convert To String     ${guarantee_amount}
    ${deliverylocation_latitude}=       Convert To String     ${deliverylocation_latitude}
    ${deliverylocation_longitude}=      Convert To String     ${deliverylocation_longitude}
    ${tenderAttempts}=                  Convert To String     ${tenderAttempts}

    ${auctionperiod_startdate}=        polonex_convertdate   ${auctionperiod_startdate}

    Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}/../../../prozorrosale/user/profile
    Sleep   2
    Input text      id=user-firm_phone                      ${procuringEntity_contactPoint_telephone}
    Input text      id=user-edrpoy                          ${procuringEntity_identifier_id}
    Input text      id=user-firm_name                       ${procuringEntity_name}
    Click Element       id=profile_save_btn
    Wait Until Page Contains    Інформацію успішно збережено!  10

    Go to   ${USERS.users['${ARGUMENTS[0]}'].homepage}
    Sleep   2
    Click Element   ${prozorropage}
    Sleep   2
    Click Element       xpath=//a[contains(@id, 'addauctionbtn')]
    Sleep   2
    Click Element   id=createtrade
    Sleep   4


    Select From List    xpath=//select[@id="addauctionform-procurementmethodtype"]                ${procurementmethodtype}
    Select From List    xpath=//select[@id="addauctionform-tenderattempts"]                       ${tenderAttempts}
    Select From List    xpath=//select[@id="addauctionform-minimalstep_valueaddedtaxincluded"]    ${value_valueaddedtaxincluded}
    Select From List    xpath=//select[@id="addauctionform-value_valueaddedtaxincluded"]          ${value_valueaddedtaxincluded}
    Input text      id=addauctionform-title                                                       ${title}
    Input text      id=addauctionform-dgfid                                                       ${dgfID}

    Input text      id=addauctionform-minnumberofqualifiedbids                                    ${minNumberOfQualifiedBids}

    Input text      id=addauctionform-description                                                 ${description}
    Input text      id=addauctionform-auctionperiod_startdate                                     ${auctionperiod_startdate}
    Input text      id=addauctionform-minimalstep_amount                                          ${minimalstep_amount}
    Input text      id=addauctionform-value_amount                                                ${value_amount}

    Input text      id=addauctionform-guarantee_amount                                            ${guarantee_amount}

    ${self}.Додати предмети      ${items}
    Sleep   5
    Click Element   xpath=//button[contains(@id, 'add-auction-form-save')]
    Wait Until Element Is Visible       xpath=//td[contains(@id, 'info_auctionID')]   30

    ${tender_uaid}=     Get Text        xpath=//td[contains(@id, 'info_auctionID')]
    [Return]    ${tender_uaid}

Додати предмети
    [Arguments]  ${items}
    ${Items_length}=   Get Length   ${items}
    :FOR   ${index}   IN RANGE   ${Items_length}
    \   ${self}.Додати предмет   ${items[${index}]}     ${index}

Додати предмет
    [Arguments]  ${item}  ${index}
    ${index}=  Convert To Integer  ${index}
    Run Keyword If  ${index} != 0   Click Element   id=additem
    Run Keyword If  ${index} != 0   Sleep           4
    Select From List    xpath=//select[@id="additemform-${index}-unit_code"]         ${item.unit.code}
    Input text      id=additemform-${index}-description                              ${item.description}
    ${quantity}=  Convert To String  ${item.quantity}
    Input text      id=additemform-${index}-quantity                                 ${quantity}
    Run Keyword If
    ...  '${item.classification.scheme}' == 'CAV-PS'  Execute Javascript    $("#additemform-${index}-classification_id").val("${item.classification.id}"); $("#additemform-${index}-classification_id").trigger("change");
    ...  ELSE       Execute Javascript    $("#additemform-${index}-classification_id_cpv").val("${item.classification.id}"); $("#additemform-${index}-classification_id_cpv").trigger("change");
    Execute Javascript    $("#additemform-${index}-additionalclassifications_id").val("${item.additionalClassifications[0].id}"); $("#additemform-${index}-additionalclassifications_id").trigger("change");
    ${contractperiod_startdate}=        polonex_convertdate     ${item.contractPeriod.startDate}
    Input text      id=additemform-${index}-contractperiod_startdate   ${contractperiod_startdate}
    ${contractperiod_enddate}=        polonex_convertdate     ${item.contractPeriod.endDate}
    Input text      id=additemform-${index}-contractperiod_enddate   ${contractperiod_enddate}

Додати предмет закупівлі
    [Arguments]  ${username}  ${tender_uaid}  ${item}
    Click Element   xpath=//a[contains(@id, "update_auction_btn")]

Видалити предмет закупівлі
    [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=${Empty}
    Click Element   xpath=//a[contains(@id, "update_auction_btn")]

Завантажити документ
    [Arguments]  ${username}  ${filepath}  ${tender_uaid}
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element     id=update_auction_btn
    Sleep   2
    Choose File     xpath=//input[contains(@id, "doc_upload_field_biddingDocuments")]   ${filepath}

Завантажити ілюстрацію
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element     id=update_auction_btn
    Sleep   2
    Choose File       id=doc_upload_field_illustration        ${filepath}

Додати Virtual Data Room
    [Arguments]  ${username}  ${tender_uaid}  ${vdr_url}  ${title}=Sample Virtual Data Room
    Wait Until Element Is Visible       xpath=//div[contains(@id,'doc_upload_wrap_virtualDataRoom')]/div/div[contains(@class,'ho_upload_link_btn')]      30
    Click Element   xpath=//div[contains(@id,'doc_upload_wrap_virtualDataRoom')]/div/div[contains(@class,'ho_upload_link_btn')]
    Sleep   4
    Input Text      jquery=#doc_upload_wrap_virtualDataRoom input#input_link   ${vdr_url}
    Click Element    jquery=#doc_upload_wrap_virtualDataRoom a.linkadd_submit
    Wait Until Element Is Visible       jquery=#doc_upload_wrap_virtualDataRoom div.ho_upload_item      30

Додати публічний паспорт активу
    [Arguments]  ${username}  ${tender_uaid}  ${certificate_url}
    Wait Until Element Is Visible       xpath=//div[contains(@id,'doc_upload_wrap_x_dgfPublicAssetCertificate')]/div/div[contains(@class,'ho_upload_link_btn')]      30
    Click Element   xpath=//div[contains(@id,'doc_upload_wrap_x_dgfPublicAssetCertificate')]/div/div[contains(@class,'ho_upload_link_btn')]
    Sleep   4
    Input Text      jquery=#doc_upload_wrap_x_dgfPublicAssetCertificate input#input_link   ${certificate_url}
    Click Element    jquery=#doc_upload_wrap_x_dgfPublicAssetCertificate a.linkadd_submit

Завантажити документ в тендер з типом
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${documentType}
    Choose File       id=doc_upload_field_${documentType}        ${filepath}

Додати офлайн документ
    [Arguments]  ${username}  ${tender_uaid}  ${accessDetails}
    Click Button    id=add-auction-form-save

Завантажити протокол аукціону
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${award_index}
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    :FOR    ${i}    IN RANGE    1   5
    \    ${test}=   Wait Until Page Contains    Кваліфікація переможця  30
    \    Exit For Loop If    ${test}
    \    reload page
    Click Element           id=add_user_bid_docs
    Sleep   2
    Choose File             xpath=//input[contains(@id, 'bid_doc_upload_fieldauctionProtocol')]   ${filepath}
    Click Button           xpath=//button[contains(@id,'submit_add_bid_doc_form')]

Пошук тендера по ідентифікатору
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${tender_uaid}
    Switch Browser   ${BROWSER_ALIAS}
    Go to   ${TESTDOMAIN}/prozorrosale2/auctions/sync-all
    Go to   ${TESTDOMAIN}/prozorrosale2/auctions/public
    Wait Until Element Is Visible       name=more-search-btn   30
    Click Element       name=more-search-btn
    Sleep  2
    Input Text          id=proauctionssearch-auctionid   ${ARGUMENTS[1]}
    Sleep  2
    Click Element       name=search-btn
    Sleep  5
    Click Element     xpath=(//a[contains(@class, 'auction_detail_btn')])
    Wait Until Element Is Visible       id=info   30

Задати питання
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...      ${ARGUMENTS[0]} ==  username
    ...      ${ARGUMENTS[1]} ==  tenderUaId
    ...      ${ARGUMENTS[2]} ==  questionId
    ${title}=        Get From Dictionary  ${ARGUMENTS[2].data}  title
    ${description}=  Get From Dictionary  ${ARGUMENTS[2].data}  description
    Click Element         id=add_question_btn
    Sleep  2
    Input Text          id=addquestionform-title          ${title}
    Input Text          id=addquestionform-description    ${description}
    Sleep  2
    Click Element       id=submit_add_question_form
    Wait Until Page Contains  ${title}  30

Задати запитання на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${question}
  ${self}.Задати питання  ${username}  ${tender_uaid}  ${question}

Задати запитання на предмет
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${question}
  ${self}.Задати питання  ${username}  ${tender_uaid}  ${question}

Оновити сторінку з тендером
    [Arguments]    @{ARGUMENTS}
    [Documentation]    ${ARGUMENTS[0]} = username
    ...      ${ARGUMENTS[1]} = ${TENDER_UAID}
    Switch Browser   ${BROWSER_ALIAS}
    ${self}.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}

Отримати інформацію із тендера
    [Arguments]  ${username}  ${tender_uaid}  ${field_name}
    ${return_value}=  Run Keyword If
    ...  'classification' in '${field_name}'       Отримати інформацію про класифікатор із предмету  ${field_name}
    ...  ELSE IF    'contractPeriod.startDate' in '${field_name}'     Отримати інформацію про items[0].contractPeriod.startDate
    ...  ELSE IF    'contractPeriod.endDate' in '${field_name}'     Отримати інформацію про items[0].contractPeriod.endDate
    ...  ELSE IF    'unit' in '${field_name}'      Отримати інформацію про юніт із предмету  ${field_name}
    ...  ELSE IF    'items' in '${field_name}'     Отримати інформацію із предмету без індекса  ${field_name}
    ...  ELSE IF    'questions' in '${field_name}'     Отримати інформацію із запитання без індекса  ${field_name}
    ...  ELSE       Отримати інформацію про ${field_name}
    [Return]  ${return_value}

Отримати інформацію із предмету без індекса
    [Arguments]  ${field_name}
    ${prop_field_name}=         Replace String    ${field_name}    .   _    count=1
    ${prop_field_name}=         Replace String    ${prop_field_name}    .   _    count=1
    ${return_value}=   Get Text     id=${prop_field_name}
    ${return_value}=  Run Keyword If
    ...  'quantity' in '${prop_field_name}'    Convert To Number    ${return_value}
    ...  ELSE       Convert To String   ${return_value}
    [Return]  ${return_value}

Отримати інформацію із запитання без індекса
    [Arguments]  ${field_name}
    ${index}=   Get Substring   ${field_name}    10      11
    ${index}=   Convert To Integer    ${index}
    ${list}=    Split String    ${field_name}    .
    Focus   xpath=//div[contains(@class, 'questions_item')]
    Wait Until Element Is Visible       id=q[${index}]${list[1]}      30
    ${return_value}=   Get Text     id=q[${index}]${list[1]}
    [Return]  ${return_value}

Отримати інформацію про класифікатор із предмету
    [Arguments]  ${field_name}
    ${prop_field_name}=         Replace String    ${field_name}    .   _    count=2
    ${return_value}=   Get Text     id=${prop_field_name}
    [Return]  ${return_value}

Отримати інформацію із документа по індексу
    [Arguments]  ${username}  ${tender_uaid}  ${document_index}  ${field}
    ${index}=   Convert To Integer    ${document_index}
    ${return_value}=   Get Element Attribute   xpath=//div[contains(@data-findex, ${index})]@data-${field}
    [Return]    ${return_value}

Отримати інформацію про юніт із предмету
    [Arguments]  ${field_name}
    ${prop_field_name}=         Replace String    ${field_name}    .   _    count=2
    ${return_value}=   Get Text     id=${prop_field_name}
    [Return]  ${return_value}

####Отримати інформацію із предмету
####    [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
####    ${index}=   Get Element Attribute   xpath=//td[contains(text(), '${item_id}')]@id
####    ${index}=   Get Substring   ${index}    0   9
####    ${return_value}=    Get Text     id=${item_id}${field_name}
####    ${return_value}=  Run Keyword If
####    ...  ${field_name} == 'quantity'      Convert To Integer    ${return_value}
####    [Return]  ${return_value}

Отримати текст із поля і показати на сторінці
  [Arguments]   ${fieldname}
  ${return_value}=   Get Text  ${locator.${fieldname}}
  [Return]  ${return_value}

Отримати інформацію про awards[0].status
    ${return_value}=   Get Text  id=award_status_0
    ${return_value}=   convert_polonex_string     ${return_value}
    [Return]  ${return_value}

Отримати інформацію про awards[1].status
    ${return_value}=   Get Text  id=award_status_1
    ${return_value}=   convert_polonex_string     ${return_value}
    [Return]  ${return_value}

Отримати інформацію про title
  ${return_value}=   Отримати текст із поля і показати на сторінці   title
  [Return]  ${return_value}

Отримати інформацію про dgfID
  ${return_value}=   Отримати текст із поля і показати на сторінці   dgfID
  [Return]  ${return_value}

Отримати інформацію про tenderAttempts
    ${return_value}=   Отримати текст із поля і показати на сторінці   tenderAttempts
    [Return]  ${return_value}

Отримати інформацію про eligibilityCriteria
  ${return_value}=   Отримати текст із поля і показати на сторінці   eligibilityCriteria
  [Return]  ${return_value}

Отримати інформацію про minNumberOfQualifiedBids
  ${return_value}=   Отримати текст із поля і показати на сторінці   minNumberOfQualifiedBids
  ${return_value}=   Convert To Number   ${return_value}
  [Return]  ${return_value}


Отримати інформацію про status
  reload page
  ${return_value}=   Отримати текст із поля і показати на сторінці   status
  ${return_value}=   convert_polonex_string     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про description
  ${return_value}=   Отримати текст із поля і показати на сторінці   description
  [Return]  ${return_value}

Отримати інформацію про procurementMethodType
  ${return_value}=   Отримати текст із поля і показати на сторінці   procurementMethodType
  ${return_value}=   convert_polonex_string     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про value.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці  value.amount
  ${return_value}=   Convert To Number   ${return_value}
  [Return]  ${return_value}

Отримати інформацію про guarantee.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці  guarantee.amount
  ${return_value}=   Convert To Number   ${return_value}
  [Return]  ${return_value}

Отримати інформацію про minimalStep.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці   minimalStep.amount
  ${return_value}=   Convert To Number   ${return_value}
  [Return]   ${return_value}

Внести зміни в тендер
  [Arguments]  ${username}  ${tender_uaid}  ${field_name}  ${field_value}
  ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${prop_field_name}=         Replace String    ${field_name}    .   _    count=1
  Click Element     id=update_auction_btn
  Wait Until Element Is Visible       name=AddAuctionForm[${prop_field_name}]   30
  ${field_value}=  Convert To String  ${field_value}
  Input text  name=AddAuctionForm[${prop_field_name}]  ${field_value}
  Click Button    id=add-auction-form-save
  Wait Until Page Contains  ${field_value}  30

Отримати інформацію про value.currency
  ${return_value}=   Отримати текст із поля і показати на сторінці  value.currency
  ${return_value}=   Convert To String     ${return_value}
  ${return_value}=   convert_polonex_string      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про value.valueAddedTaxIncluded
  ${return_value}=   Отримати текст із поля і показати на сторінці  value.valueAddedTaxIncluded
  ${return_value}=   convert_polonex_string      ${return_value}
  [Return]  ${return_value}

Отримати інформацію про auctionId
  ${return_value}=   Отримати текст із поля і показати на сторінці   tenderId
  [Return]  ${return_value}

Отримати інформацію про procuringEntity.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   procuringEntity.name
  [Return]  ${return_value}

Отримати інформацію про tenderPeriod.startDate
  ${return_value}=    Отримати текст із поля і показати на сторінці  tenderPeriod.startDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]    ${return_value}

Отримати інформацію про tenderPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.endDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]    ${return_value}

Отримати інформацію про enquiryPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.startDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]    ${return_value}

Отримати інформацію про enquiryPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.endDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]  ${return_value}

Отримати інформацію про auctionPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  auctionPeriod.startDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [return]  ${return_value}

Отримати інформацію про auctionPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  auctionPeriod.endDate
  ${return_value}=   convert_polonex_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [Return]  ${return_value}


Отримати інформацію про items[0].contractPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].contractPeriod
  ${index}=  Convert To Integer  0
  ${return_value}=   convert_contract_date_to_iso   ${return_value}  ${index}
  ${return_value}=   add_timezone_to_contact_date   ${return_value.split('.')[0]}
  [return]  ${return_value}

Отримати інформацію про items[0].contractPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].contractPeriod
  ${index}=  Convert To Integer  1
  ${return_value}=   convert_contract_date_to_iso   ${return_value}  ${index}
  ${return_value}=   add_timezone_to_contact_date   ${return_value.split('.')[0]}
  [return]  ${return_value}

Отримати інформацію про items[0].quantity
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].quantity
  ${return_value}=   Convert To Number   ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].unit.code
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].unit.code
  ${return_value}=   Convert To String     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].unit.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].unit.name
  ${return_value}=   Convert To String     ${return_value}
  [Return]   ${return_value}

Отримати інформацію про items[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].description
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.id
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.id
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.scheme
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.scheme
  [Return]  ${return_value}

Отримати інформацію про items[0].classification.description
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.description
  ${return_value}=   Convert To String     ${return_value}
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.countryName
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.countryName
  [Return]      ${return_value}

Отримати інформацію про items[0].deliveryAddress.postalCode
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.postalCode
  [Return]      ${return_value}

Отримати інформацію про items[0].deliveryAddress.region
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.region
  [Return]   ${return_value}

Отримати інформацію про items[0].deliveryAddress.locality
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.locality
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.streetAddress
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.streetAddress
  [Return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.latitude
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].deliveryLocation.latitude
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.longitude
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].deliveryLocation.longitude
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про questions[0].title
  ${return_value}=  Get text          ${locator.questions[0].title}
  [Return]  ${return_value}

Отримати інформацію про questions[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].description
  [Return]  ${return_value}

Отримати інформацію про questions[0].date
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].date
  [Return]  ${return_value}

Отримати інформацію про questions[0].answer
  ${return_value}=  Get text          ${locator.questions[0].answer}
  [Return]  ${return_value}

Отримати інформацію про cancellations[0].status
  ${return_value}=  Get text          ${locator.cancellations[0].status}
  [Return]  ${return_value}

Отримати інформацію про cancellations[0].reason
  ${return_value}=  Get text          ${locator.cancellations[0].reason}
  [Return]  ${return_value}

Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
  ${tender}=  ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${return_value}=   Get Element Attribute   xpath=//div[contains(@data-name,'${doc_id}')]@data-name
  [Return]  ${return_value}

Отримати документ
    [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
    ###${file_name}=   Get Element Attribute   xpath=//div[contains(@data-name,'${doc_id}')]@data-name
    ${file_name}=   Get Text   xpath=//div[contains(text(),'${doc_id}')]
    ${url}=   Get Element Attribute   xpath=//div[contains(@data-name,'${file_name}')]@data-src
    polonex_download_file   ${url}  ${file_name}  ${OUTPUT_DIR}
    [return]  ${file_name}

Отримати кількість документів в тендері
    [Arguments]  ${username}  ${tender_uaid}
    ${number}=   Get Element Attribute   xpath=//p[contains(@id,'document_section_title')]@data-num
    ${number}=   Convert To Number      ${number}
    [return]  ${number}

Отримати кількість документів в ставці
    [Arguments]  ${username}  ${tender_uaid}  ${bid_index}
    ${bid_doc_number}=   Get Text      id=bid_doc_count
    ${bid_doc_number}=   Convert To Number      ${bid_doc_number}
    [return]  ${bid_doc_number}

Отримати кількість предметів в тендері
    [Arguments]  ${username}  ${tender_uaid}
    ${self}.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}
    ${res}=   Get Text      id=item_count
    [return]  ${res}

Отримати дані із документу пропозиції
    [Arguments]  ${username}  ${tender_uaid}  ${bid_index}  ${document_index}  ${field}
    ${doc_value}=   Get Element Attribute   xpath=//p[contains(@id,"bid_files_auctionProtocol")]@data-key
    [return]  ${doc_value}

Скасування рішення кваліфікаційної комісії
    [Arguments]  ${username}  ${tender_uaid}  ${award_num}
    ${self}.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}
    Click Element                         xpath=//a[contains(@id, "refuse_btn")]
    Wait Until Page Contains   Ви успішно відмовились від участі в кваліфікації переможців   10

Дискваліфікувати постачальника
    [Arguments]  ${username}  ${tender_uaid}  ${award_num}  ${description}
    ${self}.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}
    Click Element              xpath=//a[contains(@id, 'discwalificate_winer_btn_${award_num}')]
    Sleep   4
    Execute Javascript          $('textarea#adddisqualifyform-description_${award_num}').value = '${description}';
    Execute Javascript          $('#submit_bid_disqualify_form_${award_num}').click();
    Wait Until Page Contains   Учасника дискваліфіковано   30

Завантажити документ рішення кваліфікаційної комісії
    [Arguments]  ${username}  ${document}  ${tender_uaid}  ${award_num}
    ${self}.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}

Відповісти на запитання
    [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
    ${index}=   Get Element Attribute   xpath=//div[contains(text(), '${question_id}')]@id
    ${index}=   Get Substring   ${index}    2   3
    Click Element                         xpath=//a[contains(@id, 'add_answer_btn_${index}')]
    Sleep     4
    Input Text                            id=addanswerform-answer        ${answer_data.data.answer}
    Sleep     2
    Click Button                        id=submit_add_answer_form
    Wait Until Page Contains   ${answer_data.data.answer}   10

Подати цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  tenderId
    ...    ${ARGUMENTS[2]} ==  ${test_bid_data}
    ${status}=          Get From Dictionary         ${ARGUMENTS[2].data}    qualified
    log to console      ${status}
    ${amount}=    Get From Dictionary     ${ARGUMENTS[2].data.value}    amount
    ${amount}=          Convert To String     ${amount}
    Run Keyword If  ${status}
    ...  ${self}.Пошук тендера по ідентифікатору  ${ARGUMENTS[0]}  ${ARGUMENTS[1]}
    ...  ELSE   Go To  ${TESTDOMAIN}
    Click Element       id=add_bid_btn
    Sleep   4
    Wait Until Element Is Visible       id=addbidform-agriment   10
    Click Element       id=addbidform-agriment
    Sleep   2
    Input Text          id=addbidform-sum       ${amount}
    Sleep   4
    Click Element       id=submit_add_bid_form
    Wait Until Element Is Visible       id=userbidamount   30
    ${resp}=    Get Text      id=userbidamount
    [Return]    ${resp}


Скасувати цінову пропозицію
    [Arguments]  ${username}  ${tender_uaid}
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element       id=cansel-bid

Змінити цінову пропозицію
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  tenderId
    ...    ${ARGUMENTS[2]} ==  amount
    ...    ${ARGUMENTS[3]} ==  amount.value
    Click Element       id=edit_user_bid
    Sleep   2
    ${newsum}=          Convert To String       ${ARGUMENTS[3]}
    Input Text          id=addbidform-sum       ${newsum}
    Click Element       id=submit_add_bid_form
    Sleep   10
    ${resp}=    Get Text      id=userbidamount
    [Return]    ${resp}

Завантажити документ в ставку
    [Arguments]  ${username}  ${path}  ${tender_uaid}  ${doc_type}=documents
    Sleep   60
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element           id=edit_user_bid
    Sleep   2
    Choose File             xpath=//input[contains(@id, 'bid_doc_upload_fieldcommercialProposal')]   ${path}
    sleep   4
    Click Element           id=submit_add_bid_form

Змінити документ в ставці
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  file
    ...    ${ARGUMENTS[2]} ==  tenderId

    Click Element           id=file_edit_0
    Sleep   2
    Choose File             xpath=//input[contains(@id, 'prouploadform-filedata')]   ${ARGUMENTS[1]}
    sleep   2
    Click Element           id=submit_add_file_form

Завантажити фінансову ліцензію
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}
    ${self}.Завантажити документ в ставку  ${username}  ${filepath}  ${tender_uaid}

Отримати пропозицію
    [Arguments]  ${field}
    Wait Until Page Contains Element    ${locator.proposition.${field}}            30
    ${proposition_amount}=              Get Text            id=userbidamount
    ${proposition_amount}=              Convert To Number                          ${proposition_amount}
    ${data}=     Create Dictionary
    ${bid}=      Create Dictionary
    ${value}=    Create Dictionary
    Set To Dictionary  ${bid}     data=${data}
    Set To Dictionary  ${data}    value=${value}
    Set To Dictionary  ${value}   amount=${proposition_amount}
    [return]           ${bid}

Отримати інформацію із запитання
    [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
    ${index}=   Get Element Attribute   xpath=//td[contains(text(), '${question_id}')]@id
    ${index}=   Get Substring   ${index}    0   4
    ${return_value}=    Get Text     id=${item_id}${field_name}
    [Return]  ${return_value}

Отримати інформацію із пропозиції
    [Arguments]  ${username}  ${tender_uaid}  ${field}
    ${bid}=   ${self}.Отримати пропозицію  ${field}
    [return]  ${bid.data.${field}}

Отримати посилання на аукціон для глядача
    [Arguments]  @{ARGUMENTS}
    Switch Browser   ${BROWSER_ALIAS}
    ${self}.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}
    ${result}=                  Get Element Attribute               id=show_public_btn@href
    [Return]   ${result}

Отримати посилання на аукціон для учасника
    [Arguments]  @{ARGUMENTS}
    Switch Browser   ${BROWSER_ALIAS}
    ${self}.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}    ${ARGUMENTS[1]}
    ${result}=                  Get Element Attribute               id=show_private_btn@href
    [Return]   ${result}

Підтвердити постачальника
    [Arguments]  ${username}  ${tender_uaid}  ${award_num}
    :FOR    ${i}    IN RANGE    1   5
    \    ${test}=   Wait Until Element Is Visible     id=cwalificate_winer_btn    30
    \    Exit For Loop If    ${test}
    \    reload page
    Click Element     id=cwalificate_winer_btn
    Wait Until Element Is Visible       id=signed_contract_btn   30

Підтвердити підписання контракту
    [Documentation]
    ...      [Arguments] Username, tender uaid, contract number
    ...      [Return] Nothing
    [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element     id=signed_contract_btn
    Input Text  xpath=//input[contains(@id,"addsignform-contractnumber")]  ${contract_num}
    Click Button     id=submit_sign_contract
    Wait Until Page Contains  Договір підписано успішно  10


Скасувати закупівлю
  [Documentation]
  ...      [Arguments] Username, tender uaid, cancellation reason,
  ...      document and new description of document
  ...      [Description] Find tender using uaid, set cancellation reason, get data from cancel_tender
  ...      and call create_cancellation
  ...      After that add document to cancellation and change description of document
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${cancellation_reason}  ${document}  ${new_description}
  ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible       id=cansel_auction_btn   30
  Click Element           id=cansel_auction_btn
  sleep  2
  Input text        xpath=//textarea[@id="canselform-reason"]       ${cancellation_reason}
  Choose File       id=cansel_doc_upload_field                      ${document}
  Wait Until Element Is Visible       xpath=//div[contains(@class, 'ho_upload_item_wrap')]   30
  sleep  4
  Click Element     xpath=//div[contains(@class, 'ho_upload_item_wrap')]/div[contains(@class, 'edit')]
  sleep  2
  Input text        xpath=//textarea[@name="ho_file_info_edit_description"]       ${new_description}
  Click Element           id=fileeditform_submit
  sleep  2
  Click Element           id=submit_cansel_form

Завантажити угоду до тендера
    [Arguments]  ${username}  ${tender_uaid}  ${contract_num}  ${filepath}
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}

Завантажити протокол аукціону в авард
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${award_index}
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element           id=upload_owner_protocol_and_contract
    sleep  4
    Choose File             xpath=//input[contains(@id, "award_doc_upload_field_auctionProtocol")]   ${filepath}

Підтвердити наявність протоколу аукціону
    [Arguments]  ${username}  ${tender_uaid}  ${award_index}
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Click Element           id=upload_owner_protocol_and_payment
    sleep  4
    Click Element           id=submit_owner_add_protocol_andpay
    Wait Until Page Contains  Переможець кваліфікований успішно  20
    sleep  120
    ${self}.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
    Wait Until Page Contains  [Очікується оплата]  20


######################### Активи #########################

Створити об'єкт МП
    [Arguments]  ${username}  ${tender_data}
    [Documentation]
    ...      [Призначення] Створює об’єкт МП з початковими даними tender_data
    ...      [Повертає] tender_uaid (ідентифікатор новоствореного об’єкта МП)
    Click Element    id=assets_btn
    Sleep   5
    Click Element    id=addassetsbtn

    ${description}=                                         Get From Dictionary               ${tender_data.data}  description
    ${title}=                                               Get From Dictionary               ${tender_data.data}  title
    ${assetCustodian_address_countryName}=                  Get From Dictionary               ${tender_data.data.assetCustodian.address}  countryName
    ${assetCustodian_address_locality}=                     Get From Dictionary               ${tender_data.data.assetCustodian.address}  locality
    ${assetCustodian_address_postalCode}=                   Get From Dictionary               ${tender_data.data.assetCustodian.address}  postalCode
    ${assetCustodian_address_region}=                       Get From Dictionary               ${tender_data.data.assetCustodian.address}  region
    ${assetCustodian_address_streetAddress}=                Get From Dictionary               ${tender_data.data.assetCustodian.address}  streetAddress
    ${assetCustodian_contactPoint_email}=                   Get From Dictionary               ${tender_data.data.assetCustodian.contactPoint}  email
    ###${assetCustodian_contactPoint_faxNumber}=               Get From Dictionary               ${tender_data.data.assetCustodian.contactPoint}  faxNumber
    ${assetCustodian_contactPoint_name}=                    Get From Dictionary               ${tender_data.data.assetCustodian.contactPoint}  name
    ${assetCustodian_contactPoint_telephone}=               Get From Dictionary               ${tender_data.data.assetCustodian.contactPoint}  telephone
    ${assetCustodian_contactPoint_url}=                     Get From Dictionary               ${tender_data.data.assetCustodian.contactPoint}  url
    ${assetCustodian_identifier_id}=                        Get From Dictionary               ${tender_data.data.assetCustodian.identifier}  id
    ${assetCustodian_identifier_legalName}=                 Get From Dictionary               ${tender_data.data.assetCustodian.identifier}  legalName
    ${assetCustodian_identifier_scheme}=                    Get From Dictionary               ${tender_data.data.assetCustodian.identifier}  scheme
    ${assetCustodian_name}=                                 Get From Dictionary               ${tender_data.data.assetCustodian}  name
    ${assetHolder_address_countryName}=                     Get From Dictionary               ${tender_data.data.assetHolder.address}  countryName
    ${assetHolder_address_locality}=                        Get From Dictionary               ${tender_data.data.assetHolder.address}  locality
    ${assetHolder_address_postalCode}=                      Get From Dictionary               ${tender_data.data.assetHolder.address}  postalCode
    ${assetHolder_address_region}=                          Get From Dictionary               ${tender_data.data.assetHolder.address}  region
    ${assetHolder_address_streetAddress}=                   Get From Dictionary               ${tender_data.data.assetHolder.address}  streetAddress
    ${assetHolder_contactPoint_email}=                      Get From Dictionary               ${tender_data.data.assetHolder.contactPoint}  email
    ###${assetHolder_contactPoint_faxNumber}=                  Get From Dictionary               ${tender_data.data.assetHolder.contactPoint}  faxNumber
    ${assetHolder_contactPoint_name}=                       Get From Dictionary               ${tender_data.data.assetHolder.contactPoint}  name
    ${assetHolder_contactPoint_telephone}=                  Get From Dictionary               ${tender_data.data.assetHolder.contactPoint}  telephone
    ${assetHolder_contactPoint_url}=                        Get From Dictionary               ${tender_data.data.assetHolder.contactPoint}  url
    ${assetHolder_identifier_id}=                           Get From Dictionary               ${tender_data.data.assetHolder.identifier}  id
    ${assetHolder_identifier_legalName}=                    Get From Dictionary               ${tender_data.data.assetHolder.identifier}  legalName
    ${assetHolder_identifier_scheme}=                       Get From Dictionary               ${tender_data.data.assetHolder.identifier}  scheme
    ${assetHolder_name}=                                    Get From Dictionary               ${tender_data.data.assetHolder}  name
    ${decisions_0_decisionDate}=                            Get From Dictionary               ${tender_data.data.decisions[0]}  decisionDate
    ${decisions_0_decisionID}=                              Get From Dictionary               ${tender_data.data.decisions[0]}  decisionID
    ${decisions_0_title}=                                   Get From Dictionary               ${tender_data.data.decisions[0]}  title
    ${items}=                                               Get From Dictionary               ${tender_data.data}  items
    ${item}=                                                Get From List                     ${items}                                  0
    ${items_0_additionalClassifications_0_description}=     Get From Dictionary               ${item.additionalClassifications[0]}  description
    ${items_0_additionalClassifications_0_id}=              Get From Dictionary               ${item.additionalClassifications[0]}  id
    ${items_0_additionalClassifications_0_scheme}=          Get From Dictionary               ${item.additionalClassifications[0]}  scheme
    ${items_0_address_countryName}=                         Get From Dictionary               ${item.address}  countryName
    ${items_0_address_locality}=                            Get From Dictionary               ${item.address}  locality
    ${items_0_address_postalCode}=                          Get From Dictionary               ${item.address}  postalCode
    ${items_0_address_region}=                              Get From Dictionary               ${item.address}  region
    ${items_0_address_streetAddress}=                       Get From Dictionary               ${item.address}  streetAddress
    ${items_0_classification_description}=                  Get From Dictionary               ${item.classification}  description
    ${items_0_classification_id}=                           Get From Dictionary               ${item.classification}  id
    ${items_0_classification_scheme}=                       Get From Dictionary               ${item.classification}  scheme
    ${items_0_description}=                                 Get From Dictionary               ${item}  description
    ${items_0_quantity}=                                    Get From Dictionary               ${item}  quantity
    ${items_0_registrationDetails_status}=                  Get From Dictionary               ${item.registrationDetails}  status
    ${items_0_unit_code}=                                   Get From Dictionary               ${item.unit}  code
    ${items_0_unit_name}=                                   Get From Dictionary               ${item.unit}  name



    ${description}=                                       Convert To String   ${description}
    ${title}=                                             Convert To String   ${title}
    ${assetCustodian_address_countryName}=                Convert To String   ${assetCustodian_address_countryName}
    ${assetCustodian_address_locality}=                   Convert To String   ${assetCustodian_address_locality}
    ${assetCustodian_address_postalCode}=                 Convert To String   ${assetCustodian_address_postalCode}
    ${assetCustodian_address_region}=                     Convert To String   ${assetCustodian_address_region}
    ${assetCustodian_address_streetAddress}=              Convert To String   ${assetCustodian_address_streetAddress}
    ${assetCustodian_contactPoint_email}=                 Convert To String   ${assetCustodian_contactPoint_email}
    ###${assetCustodian_contactPoint_faxNumber}=             Convert To String   ${assetCustodian_contactPoint_faxNumber}
    ${assetCustodian_contactPoint_name}=                  Convert To String   ${assetCustodian_contactPoint_name}
    ${assetCustodian_contactPoint_telephone}=             Convert To String   ${assetCustodian_contactPoint_telephone}
    ${assetCustodian_contactPoint_url}=                   Convert To String   ${assetCustodian_contactPoint_url}
    ${assetCustodian_identifier_id}=                      Convert To String   ${assetCustodian_identifier_id}
    ${assetCustodian_identifier_legalName}=               Convert To String   ${assetCustodian_identifier_legalName}
    ${assetCustodian_identifier_scheme}=                  Convert To String   ${assetCustodian_identifier_scheme}
    ${assetCustodian_name}=                               Convert To String   ${assetCustodian_name}
    ${assetHolder_address_countryName}=                   Convert To String   ${assetHolder_address_countryName}
    ${assetHolder_address_locality}=                      Convert To String   ${assetHolder_address_locality}
    ${assetHolder_address_postalCode}=                    Convert To String   ${assetHolder_address_postalCode}
    ${assetHolder_address_region}=                        Convert To String   ${assetHolder_address_region}
    ${assetHolder_address_streetAddress}=                 Convert To String   ${assetHolder_address_streetAddress}
    ${assetHolder_contactPoint_email}=                    Convert To String   ${assetHolder_contactPoint_email}
    ###${assetHolder_contactPoint_faxNumber}=                Convert To String   ${assetHolder_contactPoint_faxNumber}
    ${assetHolder_contactPoint_name}=                     Convert To String   ${assetHolder_contactPoint_name}
    ${assetHolder_contactPoint_telephone}=                Convert To String   ${assetHolder_contactPoint_telephone}
    ${assetHolder_contactPoint_url}=                      Convert To String   ${assetHolder_contactPoint_url}
    ${assetHolder_identifier_id}=                         Convert To String   ${assetHolder_identifier_id}
    ${assetHolder_identifier_legalName}=                  Convert To String   ${assetHolder_identifier_legalName}
    ${assetHolder_identifier_scheme}=                     Convert To String   ${assetHolder_identifier_scheme}
    ${assetHolder_name}=                                  Convert To String   ${assetHolder_name}
    ${decisions_0_decisionDate}=                          Convert To String   ${decisions_0_decisionDate}
    ${decisions_0_decisionID}=                            Convert To String   ${decisions_0_decisionID}
    ${decisions_0_title}=                                 Convert To String   ${decisions_0_title}
    ${items}=                                             Convert To String   ${items}
    ${item}=                                              Convert To String   ${item}
    ${items_0_additionalClassifications_0_description}=   Convert To String   ${items_0_additionalClassifications_0_description}
    ${items_0_additionalClassifications_0_id}=            Convert To String   ${items_0_additionalClassifications_0_id}
    ${items_0_additionalClassifications_0_scheme}=        Convert To String   ${items_0_additionalClassifications_0_scheme}
    ${items_0_address_countryName}=                       Convert To String   ${items_0_address_countryName}
    ${items_0_address_locality}=                          Convert To String   ${items_0_address_locality}
    ${items_0_address_postalCode}=                        Convert To String   ${items_0_address_postalCode}
    ${items_0_address_region}=                            Convert To String   ${items_0_address_region}
    ${items_0_address_streetAddress}=                     Convert To String   ${items_0_address_streetAddress}
    ${items_0_classification_description}=                Convert To String   ${items_0_classification_description}
    ${items_0_classification_id}=                         Convert To String   ${items_0_classification_id}
    ${items_0_classification_scheme}=                     Convert To String   ${items_0_classification_scheme}
    ${items_0_description}=                               Convert To String   ${items_0_description}
    ${items_0_quantity}=                                  Convert To String   ${items_0_quantity}
    ${items_0_registrationDetails_status}=                Convert To String   ${items_0_registrationDetails_status}
    ${items_0_unit_code}=                                 Convert To String   ${items_0_unit_code}
    ${items_0_unit_name}=                                 Convert To String   ${items_0_unit_name}



    Input text      id=addassetform-title       ${title}
    Input text      id=addassetform-description       ${description}
    Input text      id=addassetdecisionsform-0-title       ${decisions_0_title}
    Input text      id=addassetdecisionsform-0-decisiondate       ${decisions_0_decisionDate}
    Input text      id=addassetdecisionsform-0-decisionid       ${decisions_0_decisionID}
    Input text      id=addassetform-assetcustodian_address_countryname       ${assetCustodian_address_countryName}
    Input text      id=addassetform-assetcustodian_address_locality       ${assetCustodian_address_locality}
    Input text      id=addassetform-assetcustodian_address_postalcode       ${assetCustodian_address_postalCode}
    Input text      id=addassetform-assetcustodian_address_region       ${assetCustodian_address_region}
    Input text      id=addassetform-assetcustodian_address_streetaddress       ${assetCustodian_address_streetAddress}
    Input text      id=addassetform-assetcustodian_contactpoint_email       ${assetCustodian_contactPoint_email}
    ###Input text      id=addassetform-assetcustodian_contactpoint_faxNumber       ${assetCustodian_contactPoint_faxNumber}
    Input text      id=addassetform-assetcustodian_contactpoint_name       ${assetCustodian_contactPoint_name}
    Input text      id=addassetform-assetcustodian_contactpoint_telephone       ${assetCustodian_contactPoint_telephone}
    Input text      id=addassetform-assetcustodian_contactpoint_url       ${assetCustodian_contactPoint_url}
    Input text      id=addassetform-assetcustodian_identifier_id       ${assetCustodian_identifier_id}
    Input text      id=addassetform-assetcustodian_identifier_legalname       ${assetCustodian_identifier_legalName}
    Select From List    id=addassetform-assetcustodian_identifier_scheme       ${assetCustodian_identifier_scheme}
    Input text      id=addassetform-assetcustodian_name       ${assetCustodian_name}
    Input text      id=addassetform-assetholder_address_countryname       ${assetHolder_address_countryName}
    Input text      id=addassetform-assetholder_address_locality       ${assetHolder_address_locality}
    Input text      id=addassetform-assetholder_address_postalcode       ${assetHolder_address_postalCode}
    Input text      id=addassetform-assetholder_address_region       ${assetHolder_address_region}
    Input text      id=addassetform-assetholder_address_streetaddress       ${assetHolder_address_streetAddress}
    Input text      id=addassetform-assetholder_contactpoint_email       ${assetHolder_contactPoint_email}
    ###Input text      id=addassetform-assetholder_contactpoint_faxNumber       ${assetHolder_contactPoint_faxNumber}
    Input text      id=addassetform-assetholder_contactpoint_name       ${assetHolder_contactPoint_name}
    Input text      id=addassetform-assetholder_contactpoint_telephone       ${assetHolder_contactPoint_telephone}
    Input text      id=addassetform-assetholder_contactpoint_url       ${assetHolder_contactPoint_url}
    Input text      id=addassetform-assetholder_identifier_id       ${assetHolder_identifier_id}
    Input text      id=addassetform-assetholder_identifier_legalname       ${assetHolder_identifier_legalName}
    Select From List      id=addassetform-assetholder_identifier_scheme       ${assetHolder_identifier_scheme}
    Input text      id=addassetform-assetholder_name       ${assetHolder_name}


    Input text      id=addassetitemform-0-description       ${items_0_description}
    Input text      id=addassetitemform-0-quantity       ${items_0_quantity}
    Select From List      id=addassetitemform-0-unit_code       ${items_0_unit_code}
    Select From List      id=addassetitemform-0-registrationdetails_status       ${items_0_registrationDetails_status}

    Input text      id=addassetitemform-0-address_countryname       ${items_0_address_countryName}
    Input text      id=addassetitemform-0-address_locality       ${items_0_address_locality}
    Input text      id=addassetitemform-0-address_postalcode       ${items_0_address_postalCode}
    Input text      id=addassetitemform-0-address_region       ${items_0_address_region}
    Input text      id=addassetitemform-0-address_streetaddress       ${items_0_address_streetAddress}

    Execute Javascript    $("#addassetitemform-0-classification_id").val("${items_0_classification_id}"); $("#addassetitemform-0-classification_id").trigger("change");
    Execute Javascript    $("#addassetitemform-0-classification_id_cpv").val("${items_0_additionalClassifications_0_id}"); $("#addassetitemform-0-classification_id_cpv").trigger("change");

    Sleep   5
    Click Element   xpath=//button[contains(@id, 'save_asset')]
    Wait Until Element Is Visible       xpath=//td[contains(@id, 'info_assetID')]   30
    Click Element  id=update_asset_btn
    Click Element  id=publish_asset
    Wait Until Element Is Visible       xpath=//td[contains(@id, 'info_assetID')]   30
    ${tender_uaid}=     Get Text        xpath=//td[contains(@id, 'info_assetID')]
    [Return]    ${tender_uaid}


Пошук об’єкта МП по ідентифікатору
    [Arguments]  ${username}  ${tender_uaid}
    [Documentation]
    ...      [Призначення] Шукає об’єкт МП з uaid = tender_uaid.
    ...      [Повертає] tender (словник з інформацією про об’єкт МП)
    Go to    ${TESTDOMAIN}/prozorrosale2/auctions/assets
    Input text      id=registr2assetssearch-all       ${tender_uaid}
    Click Element   id=assets-search-btn
    Sleep   5
    Click Element   xpath=//a[contains(@class, 'show-one-btn')]
    Wait Until Element Is Visible      id=info_status    30

Оновити сторінку з об'єктом МП
    [Arguments]  ${username}  ${tender_uaid}
    [Documentation]
    ...      [Призначення] Оновлює сторінку з об’єктом МП для отримання потенційно оновлених даних.
    Go to    ${TESTDOMAIN}/prozorrosale2/auctions/get-all-assets?n=10
    Sleep   10
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}

Отримати інформацію із об'єкта МП
    [Arguments]  ${username}  ${tender_uaid}  ${fieldname}
    [Documentation]
    ...      [Призначення] Отримує значення поля field_name для об’єкту МП tender_uaid.
    ...      [Повертає] tender['field_name'] (значення поля).
    ${return_value}=   Get Text  ${assetlocator.${fieldname}}

    ${return_value}=  Run Keyword If
    ...  'status' in '${fieldname}'                                   convert_polonex_string  ${return_value}
    ...  ELSE IF    'registrationDetails.status' in '${fieldname}'    convert_polonex_string  ${return_value}
    ...  ELSE IF    'rectificationPeriod.endDate' in '${fieldname}'  convert_polonex_date_to_iso_format  ${return_value}
    ...  ELSE IF    'quantity' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'documentType' in '${fieldname}'  Execute Javascript  return $("#doclist_0").html();
    ...  ELSE       Convert to string  ${return_value}

    [Return]  ${return_value}

Отримати інформацію з активу об'єкта МП
    [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${fieldname}
    [Documentation]
    ...      [Призначення] Отримує значення поля field_name з активу з item_id в описі об’єкта МП tender_uaid.
    ...      [Повертає] item['field_name'] (значення поля).
    ${return_value}=   Get Text  ${assetitemlocator.${fieldname}}

    ${return_value}=  Run Keyword If
    ...  'status' in '${fieldname}'                                   convert_polonex_string  ${return_value}
    ...  ELSE IF    'registrationDetails.status' in '${fieldname}'    convert_polonex_string  ${return_value}
    ...  ELSE IF    'rectificationPeriod.endDate' in '${fieldname}'  convert_polonex_date_to_iso_format  ${return_value}
    ...  ELSE IF    'quantity' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE       Convert to string  ${return_value}

    [Return]  ${return_value}

Внести зміни в об'єкт МП
    [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
    [Documentation]
    ...      [Призначення] Змінює значення поля fieldname на fieldvalue для об’єкта МП tender_uaid.
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
    Wait Until Element Is Visible      id=info_status    30
    Click Element  id=update_asset_btn
    ${prop_field_name}=         Replace String    ${fieldname}    .   _    count=1
    Wait Until Element Is Visible       name=AddAssetForm[${prop_field_name}]   30
    ${field_value}=  Convert To String  ${fieldvalue}
    Input text  name=AddAssetForm[${prop_field_name}]  ${fieldvalue}
    Click Element  id=save_asset
    Wait Until Page Contains  ${fieldvalue}  30

Внести зміни в актив об'єкта МП
    [Arguments]  ${username}  ${item_id}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
    [Documentation]
    ...      [Призначення] Змінює значення поля fieldname на fieldvalue для активу item_id об’єкта МП tender_uaid.
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
    Wait Until Element Is Visible      id=info_status    30
    Click Element  id=update_asset_btn
    ${prop_field_name}=         Replace String    ${fieldname}    .   _    count=1
    Wait Until Element Is Visible       name=AddAssetItemForm[0][${prop_field_name}]   30
    ${field_value}=  Convert To String  ${fieldvalue}
    Input text  name=AddAssetItemForm[0][${prop_field_name}]  ${fieldvalue}
    Click Element  id=save_asset
    Wait Until Page Contains  ${fieldvalue}  30

Завантажити ілюстрацію в об'єкт МП
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}
    [Documentation]
    ...      [Призначення] Завантажує ілюстрацію, яка знаходиться по шляху filepath і має documentType = illustration, до об’єкта МП tender_uaid користувачем username.
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=update_asset_btn
    Sleep   2
    Choose File     xpath=//input[contains(@id, "doc_upload_field_illustration")]   ${filepath}
    Sleep   10
    Click Element  id=save_asset

Завантажити документ в об'єкт МП з типом
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${documentType}
    [Documentation]
    ...      [Призначення] Завантажує документ, який знаходиться по шляху filepath і має певний documentType (наприклад, notice і т.д), до об’єкта МП tender_uaid користувачем username.
    ...      [Повертає] reply (словник з інформацією про документ).
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=update_asset_btn
    Sleep   2
    Choose File     id=doc_upload_field_${documentType}   ${filepath}
    Sleep   10
    Click Element  id=save_asset

Додати актив до об'єкта МП
    [Arguments]  ${username}  ${tender_uaid}  ${item}
    [Documentation]
    ...      [Призначення] Додає дані про предмет item до об’єкта МП tender_uaid користувачем username.
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=update_asset_btn
    Sleep   2
    Click Element  id=additem

    ${items_1_additionalClassifications_0_description}=     Get From Dictionary               ${item.additionalClassifications[0]}  description
    ${items_1_additionalClassifications_0_id}=              Get From Dictionary               ${item.additionalClassifications[0]}  id
    ${items_1_additionalClassifications_0_scheme}=          Get From Dictionary               ${item.additionalClassifications[0]}  scheme
    ${items_1_address_countryName}=                         Get From Dictionary               ${item.address}  countryName
    ${items_1_address_locality}=                            Get From Dictionary               ${item.address}  locality
    ${items_1_address_postalCode}=                          Get From Dictionary               ${item.address}  postalCode
    ${items_1_address_region}=                              Get From Dictionary               ${item.address}  region
    ${items_1_address_streetAddress}=                       Get From Dictionary               ${item.address}  streetAddress
    ${items_1_classification_description}=                  Get From Dictionary               ${item.classification}  description
    ${items_1_classification_id}=                           Get From Dictionary               ${item.classification}  id
    ${items_1_classification_scheme}=                       Get From Dictionary               ${item.classification}  scheme
    ${items_1_description}=                                 Get From Dictionary               ${item}  description
    ${items_1_quantity}=                                    Get From Dictionary               ${item}  quantity
    ${items_1_registrationDetails_status}=                  Get From Dictionary               ${item.registrationDetails}  status
    ${items_1_unit_code}=                                   Get From Dictionary               ${item.unit}  code
    ${items_1_unit_name}=                                   Get From Dictionary               ${item.unit}  name

    ${items_1_additionalClassifications_0_description}=   Convert To String   ${items_1_additionalClassifications_0_description}
    ${items_1_additionalClassifications_0_id}=            Convert To String   ${items_1_additionalClassifications_0_id}
    ${items_1_additionalClassifications_0_scheme}=        Convert To String   ${items_1_additionalClassifications_0_scheme}
    ${items_1_address_countryName}=                       Convert To String   ${items_1_address_countryName}
    ${items_1_address_locality}=                          Convert To String   ${items_1_address_locality}
    ${items_1_address_postalCode}=                        Convert To String   ${items_1_address_postalCode}
    ${items_1_address_region}=                            Convert To String   ${items_1_address_region}
    ${items_1_address_streetAddress}=                     Convert To String   ${items_1_address_streetAddress}
    ${items_1_classification_description}=                Convert To String   ${items_1_classification_description}
    ${items_1_classification_id}=                         Convert To String   ${items_1_classification_id}
    ${items_1_classification_scheme}=                     Convert To String   ${items_1_classification_scheme}
    ${items_1_description}=                               Convert To String   ${items_1_description}
    ${items_1_quantity}=                                  Convert To String   ${items_1_quantity}
    ${items_1_registrationDetails_status}=                Convert To String   ${items_1_registrationDetails_status}
    ${items_1_unit_code}=                                 Convert To String   ${items_1_unit_code}
    ${items_1_unit_name}=                                 Convert To String   ${items_1_unit_name}


    Input text      id=addassetitemform-1-description       ${items_1_description}
    Input text      id=addassetitemform-1-quantity       ${items_1_quantity}
    Select From List      id=addassetitemform-1-unit_code       ${items_1_unit_code}
    Select From List      id=addassetitemform-1-registrationdetails_status       ${items_1_registrationDetails_status}

    Input text      id=addassetitemform-1-address_countryname       ${items_1_address_countryName}
    Input text      id=addassetitemform-1-address_locality       ${items_1_address_locality}
    Input text      id=addassetitemform-1-address_postalcode       ${items_1_address_postalCode}
    Input text      id=addassetitemform-1-address_region       ${items_1_address_region}
    Input text      id=addassetitemform-1-address_streetaddress       ${items_1_address_streetAddress}

    Execute Javascript    $("#addassetitemform-1-classification_id").val("${items_1_classification_id}"); $("#addassetitemform-1-classification_id").trigger("change");
    Execute Javascript    $("#addassetitemform-1-classification_id_cpv").val("${items_1_additionalClassifications_0_id}"); $("#addassetitemform-1-classification_id_cpv").trigger("change");

    Sleep   5
    Click Element   xpath=//button[contains(@id, 'save_asset')]
    Wait Until Element Is Visible       xpath=//td[contains(@id, 'info_assetID')]   30

Отримати кількість активів в об'єкті МП
    [Arguments]  ${username}  ${tender_uaid}
    [Documentation]
    ...      [Призначення] Отримує кількість активів в об’єкті МП tender_uaid.
    ...      [Повертає] number_of_items (кількість активів).
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
    ${res}=   Get Text      id=item_count
    ${res}=   Convert to Number    ${res}
    [return]  ${res}

Завантажити документ для видалення об'єкта МП
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}
    [Documentation]
    ...      [Призначення] Завантажує документ, який знаходиться по шляху filepath і має documentType = cancellationDetails, до об’єкта МП tender_uaid користувачем username.
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=update_asset_btn
    Sleep   2
    Choose File     xpath=//input[contains(@id, "doc_upload_field_cancellationDetails")]   ${filepath}
    Sleep   10
    Click Element  id=save_asset

Видалити об'єкт МП
    [Arguments]  ${username}  ${tender_uaid}
    [Documentation]
    ...      [Призначення] Видаляє об’єкт МП tender_uaid користувачем username.
    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=delete_asset_btn
    Wait Until Page Contains    Видалено з реєстру актив  20


######################### Лоти #########################


Створити лот
    [Arguments]  ${username}  ${tender_data}  ${asset_uaid}
    [Documentation]
    ...      [Призначення] Створює лот з початковими даними tender_data і прив’язаним до нього об’єктом МП asset_uaid
    ...      [Повертає] tender_uaid (ідентифікатор новоствореного лоту)
    log to console   ${tender_data}

    ${self}.Пошук об’єкта МП по ідентифікатору  ${username}  ${asset_uaid}
    ${asset_id}=   Get Text  id=info_id

    Go to    ${TESTDOMAIN}/prozorrosale2/auctions/lots
    sleep  5
    Click Element    id=addlotbtn

    ${decisions}=            Get From Dictionary               ${tender_data.data}  decisions
    ${decision}=             Get From List                     ${decisions}                                  0
    ${decisions_0_decisionDate}=     Get From Dictionary               ${decision}  decisionDate
    ${decisions_0_decisionID}=     Get From Dictionary               ${decision}  decisionID

    ${decisions}=                    Convert To String       ${decisions}
    ${decision}=                     Convert To String       ${decision}
    ${decisions_0_decisionDate}=     Convert To String       ${decisions_0_decisionDate}
    ${decisions_0_decisionID}=       Convert To String       ${decisions_0_decisionID}

    Input text      id=addlotform-asset_id                   ${asset_id}
    Input text      id=addassetdecisionsform-0-title         ${asset_uaid}
    Input text      id=addassetdecisionsform-0-decisiondate  ${asset_uaid}
    Input text      id=addassetdecisionsform-0-decisionid    ${asset_uaid}

    Sleep   5
    Click Element   xpath=//button[contains(@id, 'save_lot')]
    Wait Until Element Is Visible       xpath=//td[contains(@id, 'info_lotID')]   30
    Click Element  id=to_compose_lot_btn
    Wait Until Element Is Visible       xpath=//td[contains(@id, 'info_lotID')]   30
    ${tender_uaid}=     Get Text        xpath=//td[contains(@id, 'info_lotID')]
    [Return]    ${tender_uaid}

Пошук лоту по ідентифікатору
    [Arguments]  ${username}  ${tender_uaid}
    [Documentation]
    ...      [Призначення] Шукає лот з uaid = tender_uaid.
    ...      [Повертає] tender (словник з інформацією про лот)
    Go to    ${TESTDOMAIN}/prozorrosale2/auctions/lots
    Input text      id=registr2lotssearch-all       ${tender_uaid}
    Click Element   id=lots-search-btn
    Sleep   5
    Click Element   xpath=//a[contains(@class, 'show-one-btn')]
    Wait Until Element Is Visible      id=info_status    30

Оновити сторінку з лотом
    [Arguments]  ${username}  ${tender_uaid}
    [Documentation]
    ...      [Призначення] Оновлює сторінку з лотом для отримання потенційно оновлених даних.
    Go to    ${TESTDOMAIN}/prozorrosale2/auctions/get-all-lots?n=10
    Sleep   10
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}

Отримати інформацію із лоту
    [Arguments]  ${username}  ${tender_uaid}  ${field_name}
    [Documentation]
    ...      [Призначення] Отримує значення поля field_name для лоту tender_uaid.
    ...      [Повертає] tender['field_name'] (значення поля).

    ${return_value}=   Get Text  ${lotlocator.${fieldname}}

    ${return_value}=  Run Keyword If
    ...  'status' in '${fieldname}'                                   convert_polonex_lot_string  ${return_value}
    ...  ELSE IF    'registrationDetails.status' in '${fieldname}'    convert_polonex_lot_string  ${return_value}
    ...  ELSE IF    'procurementMethodType' in '${fieldname}'    convert_polonex_lot_string  ${return_value}
    ...  ELSE IF    'rectificationPeriod.endDate' in '${fieldname}'  convert_polonex_date_to_iso_format  ${return_value}
    ...  ELSE IF    'auctionPeriod' in '${fieldname}'  convert_polonex_date_to_iso_format  ${return_value}
    ...  ELSE IF    'quantity' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'tenderAttempts' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'value' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'minimalStep' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'guarantee' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'registrationFee' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE       Convert to string  ${return_value}

    [Return]  ${return_value}

Отримати інформацію з активу лоту
    [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
    [Documentation]
    ...      [Призначення] Отримує значення поля field_name з активу з item_id в описі лоту tender_uaid.
    ...      [Повертає] item['field_name'] (значення поля).

    ${return_value}=   Get Text  ${lotitemlocator.${fieldname}}

    ${return_value}=  Run Keyword If
    ...  'status' in '${fieldname}'                                   convert_polonex_lot_string  ${return_value}
    ...  ELSE IF    'registrationDetails.status' in '${fieldname}'    convert_polonex_lot_string  ${return_value}
    ...  ELSE IF    'procurementMethodType' in '${fieldname}'    convert_polonex_lot_string  ${return_value}
    ...  ELSE IF    'rectificationPeriod.endDate' in '${fieldname}'  convert_polonex_date_to_iso_format  ${return_value}
    ...  ELSE IF    'auctionPeriod' in '${fieldname}'  convert_polonex_date_to_iso_format  ${return_value}
    ...  ELSE IF    'quantity' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'tenderAttempts' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'value' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'minimalStep' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'guarantee' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE IF    'registrationFee' in '${fieldname}'  Convert To Number  ${return_value}
    ...  ELSE       Convert to string  ${return_value}

    [Return]  ${return_value}

Внести зміни в лот
    [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
    [Documentation]
    ...      [Призначення] Змінює значення поля fieldname на fieldvalue для лоту tender_uaid.
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Wait Until Element Is Visible      id=info_status    30
    Click Element  id=update_lot_btn
    Wait Until Element Is Visible      id=addlotform-asset_id    30
    ${prop_field_name}=         Replace String    ${fieldname}    .   _    count=1
    Wait Until Element Is Visible       name=AddLotForm[${prop_field_name}]   30
    ${field_value}=  Convert To String  ${fieldvalue}
    Input text  name=AddLotForm[${prop_field_name}]  ${fieldvalue}
    Click Element  id=save_lot
    Wait Until Page Contains  ${fieldvalue}  30

Внести зміни в актив лоту
    [Arguments]  ${username}  ${item_id}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
    [Documentation]
    ...      [Призначення] Змінює значення поля fieldname на fieldvalue для активу item_id лоту tender_uaid.
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Wait Until Element Is Visible      id=info_status    30
    Click Element  id=update_lot_btn
    Wait Until Element Is Visible      id=addlotform-asset_id    30
    ${prop_field_name}=         Replace String    ${fieldname}    .   _    count=1
    Wait Until Element Is Visible       name=AddAssetItemForm[0][${prop_field_name}]   30
    ${field_value}=  Convert To String  ${fieldvalue}
    Input text  name=AddAssetItemForm[0][${prop_field_name}]  ${fieldvalue}
    Click Element  id=save_lot
    Wait Until Page Contains  ${fieldvalue}  30

Завантажити ілюстрацію в лот
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}
    [Documentation]
    ...      [Призначення] Завантажує ілюстрацію, яка знаходиться по шляху filepath і має documentType = illustration, до лоту tender_uaid користувачем username.
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=update_lot_btn
    Wait Until Element Is Visible      id=addlotform-asset_id    30

    Sleep   2
    Choose File     xpath=//input[contains(@id, "doc_upload_field_illustration")]   ${filepath}
    Sleep   10
    Click Element  id=save_lot

Завантажити документ в лот з типом
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${documentType}
    [Documentation]
    ...      [Призначення] Завантажує документ, який знаходиться по шляху filepath і має певний documentType (наприклад, notice і т.д), до лоту tender_uaid користувачем username.
    ...      [Повертає] reply (словник з інформацією про документ).
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=update_lot_btn
    Wait Until Element Is Visible      id=addlotform-asset_id    30
    Sleep   2
    Choose File     id=doc_upload_field_${documentType}   ${filepath}
    Sleep   10
    Click Element  id=save_lot


Завантажити документ для видалення лоту
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}
    [Documentation]
    ...      [Призначення] Завантажує документ, який знаходиться по шляху filepath і має documentType = cancellationDetails, до лоту tender_uaid користувачем username.
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=update_lot_btn
    Wait Until Element Is Visible      id=addlotform-asset_id    30
    Sleep   2
    Choose File     xpath=//input[contains(@id, "doc_upload_field_cancellationDetails")]   ${filepath}
    Sleep   10
    Click Element  id=save_lot

Видалити лот
    [Arguments]  ${username}  ${tender_uaid}
    [Documentation]
    ...      [Призначення] Видаляє лот tender_uaid користувачем username.
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=delete_lot_btn
    Wait Until Page Contains    Видалено з реєстру лот  20

Додати умови проведення аукціону
    [Arguments]  ${username}  ${auction}  ${auction_index}  ${tender_uaid}
    [Documentation]
    ...      [Призначення] Додає умови проведення аукціону(auction_index) auction користувачем username
    Run Keyword If
    ...  ${auction_index} == 0  Додати умови проведення аукціону для індексу 0    ${username}  ${auction}  ${auction_index}  ${tender_uaid}
    ...  ELSE IF    ${auction_index} == 1    Додати умови проведення аукціону для індексу 1    ${username}  ${auction}  ${auction_index}  ${tender_uaid}
    ...  ELSE IF    ${auction_index} == 2    Додати умови проведення аукціону для індексу 2    ${username}  ${auction}  ${auction_index}  ${tender_uaid}

Додати умови проведення аукціону для індексу 0
    [Arguments]  ${username}  ${auction}  ${auction_index}  ${tender_uaid}
    log to console     ${auction}
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Wait Until Element Is Visible      id=info_status    30
    Click Element  id=update_lot_btn
    Wait Until Element Is Visible      id=addlotform-asset_id    30
    ${auctionPeriod.startDate}=             Get From Dictionary      ${auction.auctionPeriod}    startDate
    ${guarantee.amount}=                    Get From Dictionary      ${auction.guarantee}        amount
    ${minimalStep.amount}=                  Get From Dictionary      ${auction.minimalStep}      amount
    ${minimalStep.valueAddedTaxIncluded}=   Get From Dictionary      ${auction.minimalStep}      valueAddedTaxIncluded
    ${registrationFee.amount}=              Get From Dictionary      ${auction.registrationFee}  amount
    ${value.amount}=                        Get From Dictionary      ${auction.value}            amount
    ${value.valueAddedTaxIncluded}=         Get From Dictionary      ${auction.value}            valueAddedTaxIncluded
    ${auctionPeriod.startDate}=             Convert to string     ${auctionPeriod.startDate}
    ${guarantee.amount}=                    Convert to string     ${guarantee.amount}
    ${minimalStep.amount}=                  Convert to string     ${minimalStep.amount}
    ###${minimalStep.valueAddedTaxIncluded}=   Convert to Number     ${minimalStep.valueAddedTaxIncluded}
    ${registrationFee.amount}=              Convert to string     ${registrationFee.amount}
    ${value.amount}=                        Convert to string     ${value.amount}
    ###${value.valueAddedTaxIncluded}=         Convert to Number     ${value.valueAddedTaxIncluded}
    ${auctionPeriod.startDate}=             polonex_convertdate     ${auctionPeriod.startDate}

    Input text    id=addlotauctionform-0-auctionperiod_startdate                    ${auctionPeriod.startDate}
    Input text    id=addlotauctionform-0-value_amount                               ${value.amount}
    Input text    id=addlotauctionform-0-minimalstep_amount                         ${minimalStep.amount}
    Input text    id=addlotauctionform-0-guarantee_amount                           ${guarantee.amount}
    Input text    id=addlotauctionform-0-registrationfee_amount                     ${registrationFee.amount}

Додати умови проведення аукціону для індексу 1
    [Arguments]  ${username}  ${auction}  ${auction_index}  ${tender_uaid}
    log to console     ${auction}
    ${w}=      Get From Dictionary     ${auction}    tenderingDuration
    Input text    addlotauctionform-1-tenderingduration_y    ${EMPTY}
    Input text    addlotauctionform-1-tenderingduration_m    ${EMPTY}
    Input text    addlotauctionform-1-tenderingduration_w    1
    Input text    addlotauctionform-1-tenderingduration_d    ${EMPTY}
    Click Element  id=publish_lot
    Wait Until Element Is Visible      id=info_status    60

Додати умови проведення аукціону для індексу 2
    [Arguments]  ${username}  ${auction}  ${auction_index}  ${tender_uaid}
    log to console     ${auction}
    Click Element  id=publish_lot
    Wait Until Element Is Visible      id=info_status    30

Внести зміни в умови проведення аукціону
    [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}  ${auction_index}
    [Documentation]
    ...      [Призначення] Змінює значення поля fieldname на fieldvalue для аукціону auction_index лоту tender_uaid.
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Wait Until Element Is Visible      id=info_status    30
    Click Element  id=update_lot_btn
    Wait Until Element Is Visible      id=addlotform-asset_id    30

    ${prop_field_name}=         Replace String    ${fieldname}    .   _    count=1
    Wait Until Element Is Visible       name=AddLotAuctionForm[${auction_index}][${prop_field_name}]   30

    ${fieldvalue}=  Run keyword if
    ...  'auctionPeriod_startDate' in '${fieldname}'    polonex_convertdate  ${fieldname}
    ...  ELSE    Convert to string   ${fieldvalue}

    Input text  name=AddLotAuctionForm[${auction_index}][${prop_field_name}]  ${fieldvalue}

    Click Element  id=save_lot
    Wait Until Element Is Visible      id=info_status    30

Завантажити документ в умови проведення аукціону
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${documentType}  ${auction_index}
    [Documentation]
    ...      [Призначення] Завантажує документ, який знаходиться по шляху filepath і має певний documentType (наприклад, notice і т.д), до умов проведення аукціону з індексом auction_index лоту tender_uaid.
    ...      [Повертає] reply (словник з інформацією про документ).
    ${self}.Пошук лоту по ідентифікатору  ${username}  ${tender_uaid}
    Click Element  id=update_lot_btn
    Wait Until Element Is Visible      id=addlotform-asset_id    30
    Sleep   2
    Choose File     xpath=//input[contains(@id, 'lot_auctions_doc_upload_field_${auction_index}_${documentType}')]   ${filepath}
    Sleep   10
    Click Element  id=save_lot


