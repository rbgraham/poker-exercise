Interview Question 2
====================

Run the rspec tests with:

    rspec spec/interview_question_2.rb

Most of the tests for comparing poker hands are failing. Implement the code for comparing two hands. 

Desired Outcome
---------------

The tests for comparing hands with pairs and two pairs should pass. Bonus points for implementing comparison operations for other hands.

Interviewer Notes
-----------------

Ideally, the candidate will be able to compare one pair against another. Use the following questions to further test their design.

1. Based on the previous interview question, they should quickly construct the "<=>" method. This should make tests comparing unequal hands pass.

    rspec -e "hands of different value" spec/interview_question_2.rb

2. They should then construct a method to compare two sets of pairs using the pairs. For example, a pair of Queens is better than a pair of Fives.

3. They should then compare identical pairs using the kicker (highcard) card. For example, a pair of Queens with King kicker is better than a pair of Queens with Five kicker.

    rspec -e "hands of equal value pair" spec/interview_question_2.rb

4. They should then compare two pairs with the same criteria as above.

    rspec -e "hands of equal value two pair" spec/interview_question_2.rb
