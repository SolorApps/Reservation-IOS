# Reservation-IOS

Do a simple git clone of this repo <br>
For simplicity, pods file was included and .gitignore is was not created <br>
The app uses the following backend code https://github.com/SolorApps/Reservation-Backend/tree/master <br>
Link to API that app uses to make request <br>
http://reservationbackend-env.7rpptpwvqj.us-east-1.elasticbeanstalk.com/api <br>

App Screens<br>
*ReservationsTableViewController* <br>
* Allows a user to search for a reservation by swiping down to bring up searchbar<br>
* Swipe left on a reservation to Delete it <br>
* selecting a reservation will be take you to the ReservationViewController <br>
* Selecting the + on the navigaiton bar will take the user to ReservationCreateViewController <br>

*ReservationCreateViewController* <br>
* Allows user to create a new reservation with their given name and phone number <br>

*ReservationViewController*
* Shows the selected reservation info (name and phone number) <br>
