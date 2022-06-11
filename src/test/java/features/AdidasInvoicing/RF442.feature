@RF-442
Feature: RF-442 - Calling ConsumerService w/ payload ensuring destination of Reconcilation database

  Background:
    #JDBC Config
    #ReconDB DEV DATABASE
#    * json jdbcDetails = read('../authConnectionData/connection/DevConsumerService.json')
#    * def username = jdbcDetails.username
#    * def password = jdbcDetails.password
#    * def jdbcurl = jdbcDetails.url
#
#    * def config = { username: '#(username)',password: '#(password)', url: '#(jdbcurl)', driverClassName: 'com.mysql.cj.jdbc.Driver' }
#    * def DbUtils = Java.type('karate.util.DbUtils')
#    * def db = new DbUtils(config)

    #Set URL to Auth Token Generation endpoint
    * url CSAuth
    #Json containing token gen details
    * json authDetails = read('../authConnectionData/auth/devAuth.json')
    #Build request via datadrive
    * form field grant_type = authDetails.grant_type
    * form field client_id = authDetails.client_id
    * form field client_secret = authDetails.client_secret
    * form field scope = authDetails.scope
    * method post
    * status 200
    #Debug print statement
    And print 'Response Body: ', response
    #Initialize accessToken variable to be used in header of subsequent call
    * def accessToken = response.access_token
    #Set URL back to BaseUrl after Auth is complete
    * url CSBaseUrl

  @Debug
  Scenario: TC01 + 02 - Ensure valid payload can be sent to the endpoint and response is received
    #Initialize variables used in test
    * def myRequest = read('/data/TC01.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01a
    #Initialize variables used in test
    * def myRequest = read('/data/TC01a.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01b
    #Initialize variables used in test
    * def myRequest = read('/data/TC01b.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01c
    #Initialize variables used in test
    * def myRequest = read('/data/TC01c.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01d
    #Initialize variables used in test
    * def myRequest = read('/data/TC01d.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01e
    #Initialize variables used in test
    * def myRequest = read('/data/TC01e.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01f
    #Initialize variables used in test
    * def myRequest = read('/data/TC01f.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01g
    #Initialize variables used in test
    * def myRequest = read('/data/TC01g.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01h
    #Initialize variables used in test
    * def myRequest = read('/data/TC01h.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount

  @Debug
  Scenario: TC01i
    #Initialize variables used in test
    * def myRequest = read('/data/TC01i.json')
    * def count = [{"count(*)":1}]
    #* def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/OrderDispatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
#    Then match response == expectedResponse
#    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01"')
#    Then match count == actualCount









  @SINGLETHREAD
  Scenario: TC01a - Ensure valid payload w/ 2 orderLines blocks can be sent to the endpoint and response is received
    #Initialize variables used in test
    * def myRequest = read('/data/TC01a.json')
    * def count = [{"count(*)":1}]
    * def expectedResponse = read('/data/validResponse.json')
    #Request
    #Given header Authorization = 'Bearer ' + accessToken
    And path '/orderDespatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
    Then match response == expectedResponse
    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01a"')
    Then match count == actualCount

  @SINGLETHREAD
  Scenario: TC01b - Ensure valid payload w/ 6 orderLines blocks can be sent to the endpoint and response is received
    #Initialize variables used in test
    * def myRequest = read('/data/TC01b.json')
    * def count = [{"count(*)":1}]
    * def expectedResponse = read('/data/validResponse.json')
    #Request
    #Given header Authorization = 'Bearer ' + accessToken
    And path '/orderDespatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
    Then match response == expectedResponse
    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01b"')
    Then match count == actualCount

  @SINGLETHREAD
  Scenario: TC01c - Ensure valid payload w/ 6 orderLines blocks can be sent to the endpoint and response is received
    #Initialize variables used in test
    * def myRequest = read('/data/TC01c.json')
    * def count = [{"count(*)":1}]
    * def expectedResponse = read('/data/validResponse.json')
    #Request
    #Given header Authorization = 'Bearer ' + accessToken
    And path '/orderDespatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
    Then match response == expectedResponse
    * def actualCount = db.readRows('SELECT count(*) FROM ffm_order WHERE order_id = "TC01c"')
    Then match count == actualCount

  @MULTITHREAD
  Scenario: TC03 - 06 - Ensure valid payload can be sent to the endpoint and response is received
    #Initialize variables used in test
    * def myRequest = read('/data/TC01.json')
    * def expectedResponse = read('/data/validResponse.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/orderDespatchEventConsumer'
    And request myRequest
    When method post
    Then status 200
    And print response
    Then match response == expectedResponse

  @VALIDATION
  Scenario Outline: TC07 - 22 - Validation checks via missing fields in payload
    #Initialize variables used in test
    * def myRequest = read('/data/<TC>.json')
    * def expectedResponse =
    #Request
    #Given header Authorization = 'Bearer ' + accessToken
    And path '/orderDespatchEventConsumer'
    And request myRequest
    When method post
    Then status 500
    #Response
    #Print ResponseBody and assert response against expectedResponse
    And print 'Response Body: ', response
    And match response == expectedResponse
    Examples:
      | TC   |
      | TC07 |
      | TC08 |
      | TC09 |
      | TC10 |
      | TC11 |
      | TC12 |
      | TC13 |
      | TC14 |
      | TC15 |
      | TC16 |
      | TC17 |
      | TC18 |
      | TC19 |
      | TC20 |
      | TC21 |
      | TC22 |

  @VALIDATION
  Scenario Outline: TC23 - 37 - Validation checks via incorrect data types in payload
    #Initialize variables used in test
    * def myRequest = read('/data/<TC>.json')
    * def expectedResponse =
    #Request
    #Given header Authorization = 'Bearer ' + accessToken
    And path '/orderDespatchEventConsumer'
    And request myRequest
    When method post
    Then status 500
    #Response
    #Print ResponseBody and assert response against expectedResponse
    And print 'Response Body: ', response
    And match response == expectedResponse
    Examples:
      | TC   |
      | TC23 |
      | TC24 |
      | TC25 |
      | TC26 |
      | TC27 |
      | TC28 |
      | TC29 |
      | TC30 |
      | TC31 |
      | TC32 |
      | TC33 |
      | TC34 |
      | TC35 |
      | TC36 |
      | TC37 |