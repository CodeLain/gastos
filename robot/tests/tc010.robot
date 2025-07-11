*** Settings ***
Library     Browser

Suite Setup       New Page    http://127.0.0.1:8000/login/
Suite Teardown    Close Browser

*** Variables ***
${USERNAME}       fede2
${PASSWORD}       hola1234
${UPDATED_AMOUNT}       320.75
${UPDATED_DESC}         Cena con amigos

*** Test Cases ***
Editar Gasto Existente
    [Documentation]    Modifica el monto y descripción de un gasto ya registrado
    # — Login —
    Type Text               id=id_username    ${USERNAME}
    Type Text               id=id_password    ${PASSWORD}
    Click With Options      text=Entrar        force=True

    # — Ir a la Lista de Gastos —
    # (As view redirects to list after login)

    # — Hacer clic en botón de editar (ícono lápiz) —
    # Localizar fila con descripción "Cena"
    Wait Until Element Is Visible    xpath=//tr[td[contains(text(), "Cena")]]//a[contains(@class, "btn") and contains(., "Editar")]    timeout=10s
    Click With Options              xpath=//tr[td[contains(text(), "Cena")]]//a[contains(@class, "btn") and contains(., "Editar")]   force=True

    # — En formulario, modificar monto y descripción —
    Wait Until Element Is Visible    id=id_monto        timeout=10s
    Clear Element Text              id=id_monto
    Type Text                       id=id_monto        ${UPDATED_AMOUNT}
    Clear Element Text              id=id_descripcion
    Type Text                       id=id_descripcion  ${UPDATED_DESC}

    # — Enviar —
    Click With Options              text="💾 Guardar"   force=True

    # — Verificar retorno a la lista y cambios aplicados —
    Wait Until Element Is Visible    xpath=//tr[td[contains(text(), "${UPDATED_DESC}")]]    timeout=10s

    ${table_text}=    Get Text    css=table
    Should Contain    ${table_text}    ${UPDATED_AMOUNT}
    Should Contain    ${table_text}    ${UPDATED_DESC}