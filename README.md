# itunes
Online music store written in Java and JSP

Title: Assignment #2 - Online Shopping
Author: Georgi Butev 
Lecturer: Dr Perry Xiao
Class: Advanced Network Programming
Cource: MSc Computer Systems and Networking (1024 FT)
Faculty: ESBE
University: LSBU
--------------------------------------------------------------------------------------
Web Application Manual
--------------------------------------------------------------------------------------
1. Copy the "lsbu" directory to your Tomcat webapps directory.
2. Copy all necessary libraries to the Tomcat ROOT library directory:
	+ commons-fileupload-1.2.2
	+ commons-io-2.3
	+ commons-io-2.3-javadoc
	+ commons-io-2.3-sources
	+ commons-io-2.3-tests
	+ commons-io-2.3-test-sources
	+ mysql-connector-java-5.1.18-bin
3. Import the supplied SQL dump file for the creation of "audiofarm" database table.
4. Navigate you browser to http://localhost:8080/lsbu/.
5. Register a new user using the "Register" link or use one of the following:
	+ username: isabele; password: iceice; administrator: YES;
	+ username: dana; password: kassemg; administrator: NO;
	+ username: hscott; password: avn; administrator: NO;
--------------------------------------------------------------------------------------
6. Login using the the "Login" link.
7. Select any song/s from the table and click on purchase.
8. Go back to see the change to the user's cart.
9. Click on the full basket.
10. You will see the amount of money on the user's account and the purchase song.
11. Either "Remove" the song or "Proceed" to purchase and checkout.
12. The changes will be reflected in the cart.
--------------------------------------------------------------------------------------
13. Now you can click on "History" to view the current credit balance, purchased songs,
and song recommendations based on the purchased song's genre.
14. Logout to destory the session.
--------------------------------------------------------------------------------------
15. Login as the adminstrator either with the existing account of by modifying the
admin field to 1 for a newly registered user.
16. You can edit, remove, and add new/existing songs to the database.
17. You can edit, remove, and add new/existing users to the database.
18. The album art procedure is as follows:
	+ Click on browse to select an image of JPEG type and upload it.
	+ In the album art section select a song and type the link name.
	+ Click on "Update" to submit the changes.
	+ Refresh the page to see the song and correspong album art.
19. Logout to destroy the session.
--------------------------------------------------------------------------------------
