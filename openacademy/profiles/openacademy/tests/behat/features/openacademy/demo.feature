Feature: Demo content
  In order to test out the site
  As a site owner
  I need to view demo content

  Scenario: Homepage
    Given I am an anonymous user
    When I visit "/"
    Then the "h4" element should contain "About Open Academy"
