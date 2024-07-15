*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Variables.robot
Resource  ../Keywords/CommonWeb.robot

*** Variables ***
${BROWSER}          ${device}
&{options}          platform=${platform}       name=DY Lamda Test Run
&{CAPABILITIES}     LT:Options=&{options}
${REMOTE_URL}       http://${LT_USERNAME}:${LT_ACCESS_KEY}@hub.lambdatest.com/wd/hub
${TIMEOUT}          3000

*** Keywords ***

Open Lamda Test browser
    [Timeout]   ${TIMEOUT}
    Open browser  ${URL}  browser=${BROWSER}  remote_url=${REMOTE_URL}  desired_capabilities=${CAPABILITIES}