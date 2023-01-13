*** Settings ***
Library    AppiumLibrary

# Test Setup       Abrir aplicativo
# Test Teardown    Fechar aplicativo

*** Variables ***
### CAPABILITYS
${REMOTE_URL}         http://localhost:4723/wd/hub
${AUTOMATION_NAME}    UiAutomator2
${PLATFORM_NAME}      Android
${UDID}               emulator-5554
${APP}                ${EXECDIR}/resources/app/smartbit-beta.apk

### ELEMENTOS
${INPUT_IP}         xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup[1]/android.widget.EditText
${INPUT_ID_USER}    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup[2]/android.widget.EditText
${BTN_ENTRAR}       xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup[3]/android.widget.TextView

*** Test Cases ***
Tentar realizar login
    Realiza login       192.168.1.11    1
    Validar mensagem    Acesso não autorizado! Entre em contato com a equipe de atendimento.


*** Keywords ***
Abrir aplicativo
    Log    sucesso

    # Open Application    ${REMOTE_URL}
    # ...                 appium:alias=smartbit
    # ...                 appium:automationName=${AUTOMATION_NAME}
    # ...                 appium:platformName=${PLATFORM_NAME}
    # ...                 appium:deviceName=Android Simulator
    # ...                 appium:udid=${UDID}
    # ...                 appium:app=${APP}
    # ...                 aapium:autoGranPermissions=true

    # Set Appium Timeout    30

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