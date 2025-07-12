*** Settings ***
Library     Browser
Suite Setup     Open Browser    http://127.0.0.1:8000/    chromium
Suite Teardown    Close Browser

*** Variables ***
${USERNAME}     fede2
${PASSWORD}     hola1234
${LOGIN_URL}    http://127.0.0.1:8000/login/
${GASTOS_URL}   http://127.0.0.1:8000/

*** Test Cases ***
TC‑015 – Cerrar la sesión actual
    [Documentation]    Validar que el usuario puede cerrar sesión correctamente.

    # --- Login ---
    Type Text         id=id_username    ${USERNAME}
    Type Text         id=id_password    ${PASSWORD}
    Click             text=Ingresar

    Wait For Elements State    text=Lista de Gastos    visible

    # --- Click on "Salir" button in sidebar ---
    Click    text=Salir

    # --- Verify redirected to login ---
    Wait For Elements State    text=Usuario    visible    timeout=5s
    ${page_text}=    Get Text       css=body
    Should Contain   ${page_text}   ¿No tienes una cuenta? Regístrate