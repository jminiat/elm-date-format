module Main exposing (..)

{- A simple test an example of the library.
Does not test every option, you can submit PRs for that.
-}

import Date
import Date.Format
import ElmTest exposing (test, Test, suite, assertEqual, runSuiteHtml)


-- test name, expected value, format string


type alias TestTriple =
  ( String, String, String )


testData : List TestTriple
testData =
  [ ( "numeric date", "12/08/2014", "%d/%m/%Y" )
  , ( "spelled out date", "Tuesday, August 12, 2014", "%A, %B %d, %Y" )
  , ( "time", "04:53:51 AM", "%I:%M:%S %p" )
  , ( "time no spaces", "045351", "%H%M%S" )
  , ( "literal %", "04%53", "%H%%%M" )
  ]


sampleDate : Date.Date
sampleDate =
  Date.fromTime 1.407833631116e12


formatSampleDate : String -> String
formatSampleDate fstring =
  Date.Format.format fstring sampleDate


formatTest : TestTriple -> TestTriple
formatTest ( a, b, format ) =
  ( a, b, formatSampleDate format )


makeTest : TestTriple -> Test
makeTest ( described, expected, actual ) =
  test described <| assertEqual expected actual


tests : Test
tests =
  suite "Formatting" <| List.map (makeTest << formatTest) testData


main =
  runSuiteHtml tests
