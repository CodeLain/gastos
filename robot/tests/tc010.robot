*** Variables ***
${USERNAME}       fede2
${PASSWORD}       hola1234
${UPDATED_AMOUNT}       320.75
${UPDATED_DESC}         Cena con amigos

*** Settings ***
Library     Browser
Suite Setup     Open Browser    http://127.0.0.1:8000/    chromium
Suite Teardown    Close Browser

*** Test Cases ***
Editar Gasto Existente
    [Documentation]    Modifica el monto y descripción de un gasto ya registrado
    # — Login —
    Type Text               id=id_username    ${USERNAME}
    Type Text               id=id_password    ${PASSWORD}
    Click With Options      text=Ingresar        force=True

    # — Ir a la Lista de Gastos —
    # (As view redirects to list after login)

    # — Hacer clic en botón de editar (ícono lápiz) —
    # Localizar fila con descripción "Cena"
    Wait For Elements State    xpath=/html/body/div[2]/div[2]/table/tbody/tr[1]/td[6]/a    visible    timeout=10s
    Click With Options              xpath=/html/body/div[2]/div[2]/table/tbody/tr[1]/td[6]/a   force=True

    # — En formulario, modificar monto y descripción —
     Wait For Elements State    id=id_monto    visible    timeout=10s
    #Wait Until Element Is Visible    id=id_monto        timeout=10s
    Click With Options      id=id_descripcion        force=True
    Fill Text                       id=id_descripcion  ${UPDATED_DESC}
    Click With Options      id=id_monto        force=True
    Fill Text                       id=id_monto  ${UPDATED_AMOUNT}

    # — Enviar —
    Click With Options              text="💾 Guardar"   force=True

    # — Verificar retorno a la lista y cambios aplicados —
    Wait For Elements State    text=Lista de Gastos    visible    timeout=10s

    ${table_text}=    Get Text    css=table
    Should Contain    ${table_text}    ${UPDATED_AMOUNT}
    Should Contain    ${table_text}    ${UPDATED_DESC}