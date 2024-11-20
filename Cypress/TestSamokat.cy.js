describe('template spec', () => {
  it('passes', () => {
    cy.viewport(1920,1080)
    cy.visit('https://www.google.ru/')
    cy.get('.gLFyf').type('samokat{enter}')
    cy.get('.lv7K9c > .sjVJQd').click()
    cy.get('a').invoke('removeAttr', 'target')
    cy.get('[lang="ru"] > .tF2Cxc > .yuRUbf > :nth-child(1) > [jscontroller="msmzHf"] > a > .LC20lb').click()
    cy.origin('https://samokat.ru/', () => {
      cy.get('.Footer_infoLinks__HUpOR > :nth-child(2)').click()
      cy.get(':nth-child(1) > .ContactsDrawer_contacts__LvK1j > :nth-child(2)') 
        .should('have.attr', 'href')
        .and('eq', 'https://t.me/samokatsupportbot')
    })
  })
})