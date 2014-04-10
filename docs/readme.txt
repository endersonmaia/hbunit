README.TXT
----------

What is xhUnit:
---------------

xhUnit is a testing framework developed for xHarbour users as a port to
the JUnit Testing Framework, that is popular among Java developers, and has
provided an easy means of writing SELF-TESTING code.  This excellent job is
done by Kent Beck and Eric Gamma.

This being only a framework, it is designed to be just a skeleton, and that,
being easy to use and write self-testing code when you are writing
applications using xHarbour.  For it to be useful, it has to be effective.
For it to be used, it has to be easy.

To write a testable and self-testing code, it is best to always consider
separation of code for logic, data and ui.  xhUnit, being a unit testing
framework, is designed to be used for unit testing of the logic that drives
the application.  To some extent, codes that handle data may also be tested
but it should always be remembered that the data status should be reset
after every method to make sure that the tests would not fail because of the
data being in a not expected state.

For the UI stuff, some debates is still on-going on how it should be tested.
For me, to some extent, it can be tested.  For a bit more extensive ui
testing, the use of MockObjects and ui hooks may be the way to go.  As to
the actual UI testing where the user has to do interactive testing, that
is in itself a different animal, and xhUnit is not designed to handle that.

For some samples of how xhUnit testing framework to be used, go to the
samples\ folder and see how it is being used to create classes.


How to use xhUnit:
------------------

As of writing, the xhUnit is only available in text/console mode so the
following steps would be for that mode.  Once you have learned the steps,
the GUI based would not be a difficult one to learn.

xhUnit, in binary form, is distributed as a lib file (xhUnit.lib for bcc55,
xhUnitm for msvc). To be able to experiment using xhUnit testing framework,
you need the following:

- an application prg (ie <unit>Tester.prg) #1
- a testcase prg (ie <unit>Test.prg)       #2
- a unit source code (ie <unit>.prg)       #3

If you create a unit employee.prg containing TEmployee class, you would need

- employeeTester.prg (to build employeeTester.prg)
- employeeTest.prg (to test TEmployee, inheriting from TTestCase from xhUnit)
- employee.prg (containing the TEmployee class)




What is TDD/TFD:
----------------


What is XP (Extreme Programming):
---------------------------------
