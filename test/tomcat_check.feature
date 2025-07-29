Feature: Check Tomcat Homepage

  Scenario: Verify Tomcat Homepage contains "tomcat"
    Given url 'http://localhost:8080'
    When method GET
    Then status 200
    And match response contains '<html>'
    And match response contains 'tomcat'

