Feature: Chapter 1 crashing

Background: a bot exists
  Given I have a new cargobot

Scenario: Stacks topple when brushed
  Given subroutine 1 is "R call1"
  And the pallets are [[],[red,red,red,red,red,red,red],[]]
  And the claw is in position 1
  When I activate the cargobot
  Then the claw should be in position 2
  And the step count should be 1
  And a stack of crates will be toppled