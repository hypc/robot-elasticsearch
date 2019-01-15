=========
Resources
=========

*** Variables ***
${SERVER}           192.168.56.10
${PORT}             9200
${TEST_TIMEOUT}     2


*** Settings ***
Library             JSONSchemaLibrary  tests


*** Keywords ***
Status Should be
    [Documentation]     检测响应状态
    ...                 ${resp}: 响应实体
    ...                 ${status_code}: 预期的响应状态
    [Arguments]         ${resp}  ${status_code}
    Should Be Equal As Integers    ${resp.status_code}  ${status_code}
