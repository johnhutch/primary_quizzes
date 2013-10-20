Primary
=======

Primary is a multiple choice quiz app that uses a traditional ELO system to rank users and deliver knowledge-level appropriate questions.

Technology Used
---------------

* Ruby 2.0.0-p247
* Rails 4.0.0
* SQLite for testing, Mysql 2 for production
* Rspec, Capybara, FactoryGirl, Faker testing
* Devise
* SASS, bootstrap-sass to avoid using cruddy-old LESS
* Unfortunately, Compass and CanCan are not supported in Rails 4 yet

To Do
=====

* Frontend
  * ~~Bootcamp 3 w/ SASS integration (with Glyicons)~~
  * ~~Create user dashboard (user controls, ELO, create question~~
  * new question with changeable category
  * Define answer selection, answer submit, and load new question animations
  * Change colors of all Bootstrap alerts/buttons to the 4 colors of Primary
  * ~~Small content means lots of space. Go big. Bring back the side-nav, give it a good 1/3 of the page width, and style boldly.~~

* User system
  * ~~Devise & Can Can~~
  * ~~Anonymous users~~ with belated registration

* Question system
  * ~~Create questions with associated choices~~
    * * ~~create question form~~
    * * ~~create nested answer form~~
    * * ~~create answer selection option within nested answer form~~
  * Create separate on-page editing possibilities for question (disable big old regular editing)
  * Create question/user/choice relational answer table
    * * build proper HABM relationship'd model
    * * create question answering/storing process
  * ELO
    * * ~~elo added to users and questions~~
    * * ~~build ELO algorithm maths into appropriate models~~
    * * build out controller actions on question answer
  * Flag bad questions

* Tests
  * ~~Install Rspec, Factory Girl, capybara, database_cleaner~~
  * ~~User-based tests~~
  * Question tests

* Server Setup
  * ~~deploy script~~
  * ~~gem installs~~
  * ~~passenger/apache~~
  * ~~database setup~~
  * ~~shared path/config/binaries setup~~
  * email configuration

* Extras
  * Front page blog for news/announcements
  * ability to add new categories, or sub-categories
  * Oauth authentication for github/twitter logins
  * Compile-a-test to generate x number of questions in a given ELO range with a permalink to be shared for score competition
  * Add an image to a question
  * Give an extra "Are You Sure?" after User selects their answer. It's just a nice thing to do.

Data Models
===========

```
User
  has_many :questions
  has_many :comments
  data: devise stuff, ELO, name? 

Category:
  has_many :questions
  belongs_to :category?
  data: name, parent_category for sub-categories?

Question
  belongs_to :user
  has_many :choices
  has_many :comments
  data: body, solution_id, category_id, user_id, ELO

Choice
  belongs_to :question
  data: body, :question_id, :user_id

Answer
  some sort of relationshional table for storing a user's answers to questions
  data: user_id, question_id, choice_id


Comment
  belongs_to :user
  belongs_to :question
  data: body
```

Implementation Notes
====================

Quiz submission process
-----------------------

* Both user and question have an ELO
* user submits answer, controller runs current_user.questions(:param(:id)).check_answer(:param(:choice_id)) (note -- syntax is probalby wrong -- might need to be find(:param(:id) or something liek that)
* check_answer then verifies and runs the approrpiarate correct/incorrect answer user method
* user.correct_answer(question) raises user ELO, lowers question ELO, according to ELO algo
* user.incorrect_answer(question) raises question ELO, lowers user ELo, accoridng to ELO ago
* controller then finds next unanswered question (user.unanswered_questions(category)) and presents it along with solution page (Correct or Wrong, explanation, option to flag for error)

Concerns & Additional Stuffs
========

* Users submit code, we must allow all sorts of characters. Is this a security risk?
-- no, rails sanitizes input

* Monospaced fonts: http://www.fontsquirrel.com/fonts/list/style/Monospaced
