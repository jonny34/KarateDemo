@RF-196 @PID
Feature: RF-196 - Generating new PIDs via endpoint and checking results via response json + JDBC queries

  Background:
    ########################################################
    #JDBC Config
    #PID DEV DATABASE
    * json jdbcDetails = read('../authConnectionData/connection/pidDev.json')
    * def username = jdbcDetails.username
    * def password = jdbcDetails.password
    * def jdbcurl = jdbcDetails.url
    * def driver = jdbcDetails.driver

    #hardcode
#    * def config = { username: 'admin',password: 'password01', url: 'jdbc:mysql://connectiondetails', driverClassName: 'com.mysql.cj.jdbc.Driver' }

    #datadrive
    * def config = { username: '#(username)',password: '#(password)', url: '#(jdbcurl)', driverClassName: 'com.mysql.cj.jdbc.Driver' }
    * def DbUtils = Java.type('karate.util.DbUtils')
    * def db = new DbUtils(config)

    ########################################################

    #Base Url used across endpoints
    * url PIDAuth
    #Request to generate token
    * path '/token'
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
    * url PIDBaseUrl

  @Process2 @1Thread
  Scenario: TC12 - Requested no. of PID < Available no. of PID -> Available > Freespace (No Generation)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC12.json')
    * def count = [{"count(*)":101}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/99'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    Then print 'Response Body: ', response
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @1Thread
  Scenario: TC13 - Requested no. of PID < Available no. of PID -> Available = Freespace (Generation)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC13.json')
    * def count = [{"count(*)":1100}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/100'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @1Thread
  Scenario: TC14 - Requested no. of PID < Available no. of PID -> Available < Freespace (Generation)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC14.json')
    * def count = [{"count(*)":1099}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/101'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @1Thread
  Scenario: TC15 - Requested no. of PID = Available no. of PID -> Available < Freespace (Generation)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC15.json')
    * def count = [{"count(*)":1000}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/200'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @MultiThread
  Scenario: TC16 - Requested no. of PID < Available no. of PID -> Available > Freespace (No Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC16.json')
    * def count = [{"count(*)":110}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/45'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @MultiThread
  Scenario: TC17 - Requested no. of PID < Available no. of PID -> Available = Freespace (T1-Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC17.json')
    * def count = [{"count(*)":1000}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/100'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @MultiThread
  Scenario: TC17a - Requested no. of PID < Available no. of PID -> Available = Freespace (T2-Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC17a.json')
    * def count = [{"count(*)":1100}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/50'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @MultiThread
  Scenario: TC18 - Requested no. of PID < Available no. of PID -> Available < Freespace (T1-Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC18.json')
    * def count = [{"count(*)":996}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/102'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @MultiThread
  Scenario: TC18a - Requested no. of PID < Available no. of PID -> Available < Freespace (T2-Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC18.json')
    * def count = [{"count(*)":1098}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/51'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @MultiThread
  Scenario: TC19 - Requested no. of PID = Available no. of PID -> Available < Freespace (T1-Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC19.json')
    * def count = [{"count(*)":800}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/200'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @MultiThread
  Scenario: TC20 - Requested no. of PID = Available no. of PID -> Available < Freespace (T2-Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC20.json')
    * def count = [{"count(*)":1002}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/99'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process3 @1Thread
  Scenario: TC21 - Requested no. of PID > Available no. of PID -> Available < Freespace (Generation)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC21.json')
    * def count = [{"count(*)":850}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/150'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process3 @1Thread
  Scenario: TC22 - Requested no. of PID > Available no. of PID -> Available < Freespace (Generation)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC21.json')
    * def count = [{"count(*)":951}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/150'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process3 @MultiThread
  Scenario: TC23 - Requested no. of PID > Available no. of PID -> Available < Freespace (T1-Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC21.json')
    * def count = [{"count(*)":801}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/150'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process3 @MultiThread
  Scenario: TC24 - Requested no. of PID > Available no. of PID -> Available < Freespace (T2-Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC24.json')
    * def count = [{"count(*)":951}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/75'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process3 @MultiThread
  Scenario: TC25 - Requested no. of PID > Available no. of PID -> Available < Freespace (Generation) (Multithread)
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC21.json')
    * def count = [{"count(*)":700}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/150'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @Process3 @EndpointValidation
  Scenario: TC26 - Generate 1 ProductID
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC26.json')
    * def count = [{"count(*)":199}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/1'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @Process3 @EndpointValidation
  Scenario: TC27 - Generate 100 ProductIDs
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC27.json')
    * def count = [{"count(*)":1100}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/100'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @Process3 @EndpointValidation
  Scenario: TC28 - Generate 1000 ProductIDs
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC28.json')
    * def count = [{"count(*)":200}]
    #* def lowestAvailablePID = db.readRows('SELECT min(tvg_product_id) FROM qa_ffm_product_id_gen.style_sku_store WHERE reserved_ind = "N" AND tvg_product_id != 00000;')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/1000'
    When method get
    Then status 200
    #Response
    #Check response from call against data driven .json file
    And match response == expectedResponse
    #And match lowestAvailablePID == response.itemDescNumber.[0]
    #Check count of PIDS in DB w/ Reserved = N
    * def actualCount = db.readRows('SELECT count(*) FROM style_sku_store WHERE reserved_ind = "n"')
    Then match count == actualCount
    * print '\nExpected: ', count, 'Actual: ', actualCount

  @Process2 @Process3 @EndpointValidation
  Scenario Outline: TC29 - TC38 - Invalid Paths in Endpoint
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/<path>'
    When method get
    Then status 404
    Examples:
      | path    |
      #Maybe valid
      | 0       |
      | 1.00    |
      | 1.00.00 |
      #Defo invalid
      | 1.5     |
      | -1      |
      | Test    |
      | " "     |
      | true    |
      | \\\\    |
      #Null test below (if cant null in examples section use TC35)
      |         |

  @Regression
  Scenario: TC35 - No Param in endpoint
    #Initialize variables used in test
    * def expectedResponse = read('/data/TC01.json')
    #Request
    Given header Authorization = 'Bearer ' + accessToken
    And path '/productId-generator/itemNum/ '
    When method get
    Then status 404