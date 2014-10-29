baseball-stats: A sample ruby gem
==============

# Demo instructions
Requires Ruby 2.1.3 or greater

1. `git clone git@github.com:nhance/baseball-stats.git`
2. `cd baseball-stats`
3. `bundle`
4. `bundle exec rake db:reset`
5. `bundle exec rake demo:load_everything` _Data issues are expected.
   Does not impact test results. Ran out of time to debug fully._
6. `bundle exec rake demo:demo`

**Overview:**  Write an application
that will be used to provide information about baseball player
statistics. This application
is representative of something that I would be comfortable
releasing to a production environment.

###Assumptions
All requests currently are based on data in the hitting
file.  Future requests of the system will require data from a pitching
file as well.  Consider this in the design.

###Requirements
When the application is run, use the provided data and
calculate the following results and write them to STDOUT.

1. Most improved batting average( hits / at-bats) from 2009 to 2010.
 Only include players with at least 200 at-bats.
2. Slugging percentage for all players on the Oakland A's (teamID = OAK)
in 2007. 
3. Who was the AL and NL triple crown winner for 2011 and 2012.  If no
one won the crown, output "(No winner)"

###Formulas
`Batting average = hits / at-bats`
`Slugging percentage = ((Hits – doubles – triples – home runs) + (2 *
doubles) + (3 * triples) + (4 * home runs)) / at-bats`

**Triple crown winner** – The player that had the highest batting average
AND the most home runs AND the most RBI in their league.

It's unusual for someone to win the triple crown, but there was a winner in 2012.
“Officially” the batting title (highest league batting average) is based on a minimum
of 502 plate appearances, but the provided dataset does not include plate
appearances. It also does not include walks so plate appearances cannot
be calculated. Instead, use a constraint of a minimum of 400 at-bats to
determine those eligible for the league batting title.


###Data
All the necessary data is available in the two csv files attached:

**data/Batting-07-12.csv** – Contains all the batting statistics from 2007-2012.
 
Column header key:
- playerID: Unique player id
- yearID: Year of recorded data
- league
- teamID
- G: _(description unavailable)_
- AB: at-bats
- R: _(description unavailable)_
- H: hits
- 2B: doubles
- 3B: triples
- HR: home runs
- RBI: runs batted in
- SB: _(description unavailable)_
- CS: _(description unavailable)_

**data/Master-small.csv** – Contains the demographic data for all baseball
players in history through 2012.

Column header key:
- playerID: unique player id
- birthYear
- nameFirst
- nameLast
