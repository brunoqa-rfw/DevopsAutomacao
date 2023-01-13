*** Settings ***
Library    AppiumLibrary

Test Setup       Abrir aplicativo
Test Teardown    Fechar aplicativo

*** Variables ***
### CAPABILITYS
${REMOTE_URL}         http://localhost:4723/wd/hub
${AUTOMATION_NAME}    UiAutomator2
${PLATFORM_NAME}      Android
${UDID}               emulator-5554
${APP}                ${EXECDIR}/resources/app/smartbit.apk

### Salcelabs
${SALCELABS_KEY}                   oauth-bmdscftv-d8754:16dd6892-189a-46cc-981d-c7fcbe2da5fb
${SALCELABS_URL}                   https://oauth-bmdscftv-d8754:16dd6892-189a-46cc-981d-c7fcbe2da5fb@ondemand.us-west-1.saucelabs.com:80/wd/hub
${SAUCELABS_AUTOMATION_NAME}       Andoird
${SALCELABS_PLATAFORM_VERSION}     12.0
${SALCELABS_AUTOMATION_NAME}       UiAutomator2
${SALCELABS_APP}                   storage:filename=smartbit-beta.apk
${SALCELABS_DEVICE_NAME}           Android GoogleAPI Emulator
${SALCELABS_DEVIDE_ORIENTATION}    portrait
${SALCELABS_APPIUM_VERSION}        1.22.1

### ELEMENTOS
${INPUT_IP}         xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup[1]/android.widget.EditText
${INPUT_ID_USER}    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup[2]/android.widget.EditText
${BTN_ENTRAR}       xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup[3]/android.widget.TextView

*** Test Cases ***
Tentar realizar login
    # Log    sucesso
    Realiza login       192.168.1.11    1
    Validar mensagem    Acesso não autorizado! Entre em contato com a equipe de atendimento.


*** Keywords ***
Abrir aplicativo
    IF    '${SALCELABS}' == 'True'
        Abrir aplicativo Salcelabs
    ELSE
        Abrir aplicativo Local
    END

Abrir aplicativo Local
    Open Application    ${SALCELABS_URL}
    ...                 appium:automationName=${SAUCELABS_AUTOMATION_NAME}
    ...                 appium:platformName=${PLATFORM_NAME}
    ...                 appium:deviceName=${SALCELABS_DEVICE_NAME}
    ...                 appium:udid=${UDID}
    ...                 appium:app=${APP}
    ...                 aapium:autoGranPermissions=true

    Set Appium Timeout    30

Abrir aplicativo Salcelabs
    Open Application    remote_url=https://oauth-bmdscftv-d8754:16dd6892-189a-46cc-981d-c7fcbe2da5fb@ondemand.us-west-1.saucelabs.com:443/wd/hub    alias=None
    ...    platformName=Android
    ...    app=storage:filename=smartbit.apk
    ...    deviceName=Android GoogleAPI Emulator
    ...    platformVersion=12.0
    ...    appium:automationName=UiAutomator2
    ...    appiumVersion=1.20.2
    ...    name=Android
    ...    autoGranPermissions=true

    Set Appium Timeout    30

Realiza login
    [Arguments]  ${ip}  ${id_user}
    
    Wait Until Element Is Visible     ${INPUT_IP}
    Input Text                        ${INPUT_IP}         ${ip}
    Input Text                        ${INPUT_ID_USER}    ${id_user}
    Click Element                     ${BTN_ENTRAR}

Validar mensagem
    [Arguments]  ${msg_esperada}
    Wait Until Page Contains    ${msg_esperada}

Fechar aplicativo
    Close Application