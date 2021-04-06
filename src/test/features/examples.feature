Feature: Example/Sample requests of various calls handled via Inuit Karate API

  Background:
    * url 'https://reqres.in/'

  Scenario: TC01 - Get single user
    * def myResponse = read('/data/response/TC01.json')
    #Send Request
    Given path 'api/users/2'
    When method get
    Then status 200
    #Check responseBody as json object
    And match response == myResponse
    #Or
    #Check responseBody fields individually
    And match response.data.id == 2
    And match response.data.email == "janet.weaver@reqres.in"
    And match response.data.first_name == "Janet"
    And match response.data.last_name == "Weaver"
    And match response.data.avatar == "https://reqres.in/img/faces/2-image.jpg"

  Scenario: TC02 - Get multiple users w/ param
    * def expectedResponse = read('/data/response/TC02.json')
    Given path 'api/users'
    And param page = 1
    When method get
    Then status 200
    And match response == expectedResponse
      #Too many fields in list of users to match individually therefore done by matching all objects at once

  Scenario: TC03 - Get multiple users w/ new param
    * def expectedResponse = read('/data/response/TC03.json')
    Given path 'api/users'
    And param page = 2
    When method get
    Then status 200
    And match response == expectedResponse
      #Too many fields in list of users to match individually therefore done by matching all objects at once

  Scenario: TC04 - create a user and then get it by id

    * json myRequest = read('/data/request/TC04.json')
    * def myResponse = read('/data/response/TC01.json')


    Given path 'users'
    And request user.request
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: ', id

    Given path id
    # When method get
    # Then status 200
    # And match response contains user
