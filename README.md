== Primary

* Ruby 2.0.0-p247
* Rails 4.0.0

== To do for Tinder 4

* Rspec install, with Factory Girl
* Bootcamp 3 integration (with Glyphicons)
* Devise & Can Can
* User setup
* MySQL setup for production on Linode server
* Linode server setup, as per Rails Rumble directions
* User-based tests
* Email set up, for confirmable user accounts

== To do for Primary (Models & Associations)

* User model: elo, has_many questions (authored by User), has_many answers (not authored by User)
* Question model: elo, text, explanation, belongs_to user, has_many choices, has_one subject, solution_id
* Subject model: name (just three for now: HTML, CSS, Ruby), belongs_to_many questions
* Choice model: text, belongs_to question
* Answers model/relational table: user_id, question_id, choice_id

== To do for Primary (Logic)

* ELO calculation: in User model, compares User.elo and Question.author.elo, parameters: Question, boolean correct?
* Better still, a helper method called 'calculate_elo_change' that just takes in two ELOs. (elo1, elo2, boolean). Use the returned number (positive or negative) to add to current ELO (whether it be the User's ELO or the Question's ELO)
* User controller method named 'submit_answer' or 'answer_question': What is the order of logic here? Check if answer is correct; update ELO of user; update ELO of question; show solution page
* Present next question based on user's ELO

== To do for Primary (Views)
* Always at top of screen: current_user's ELO, Login/Logout button, Create new question button
* Solution page (after answering): Correct or Wrong, explanation, Answer another question button

== To do for Primary (Design)

* Select typeface for headers and body (preferably Google font)
* Utilize Bootstrap 3 as much as possible in forms, layout, etc.
* Select color palette for a version of red, yellow, green, blue (not necessarily Bootstrap's colors). Maybe we can go brighter, bolder, deeper, something.
* Personalize the design

== Concerns & Extra Ideas

* Users submit code, we must allow all sorts of characters. Is this a security risk?
* Give an extra "Are You Sure?" after User selects their answer. It's just a nice thing to do.

== To do for Primary (Extras)
* User model: has_many comments
* Comment model: text, belongs_to user, belongs_to question